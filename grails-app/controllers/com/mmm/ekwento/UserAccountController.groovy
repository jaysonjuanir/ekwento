package com.mmm.ekwento



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserAccountController {

    def springSecurityService
    def emailerService
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def total = 0
        def list = []
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        
        total = UserAccount.createCriteria().get{
            if(params.searchCriteria)
            or {
                ilike('username',"%$params.searchCriteria%")
            }
            projections{
                count('id')
            }
        }
        list = UserAccount.createCriteria().list{
            if(params.searchCriteria)
            or {
                ilike('username',"%$params.searchCriteria%")
            }
            maxResults(new Integer(params.max))
            firstResult(new Integer(params.offset))
            order("username")
        }
        println("1: " +total+ "\t");
        println("2: " +list+ "\t");
        render (view:"index", model:[userAccountInstanceCount: total, userAccountInstanceList:list])
    }

    def show(UserAccount userAccountInstance) {
        respond userAccountInstance
    }

    def create() {
        respond new UserAccount(params)
    }

    @Transactional
    def save(UserAccount userAccountInstance) {
        
        println("params"+params)
        if (userAccountInstance == null) {
            notFound()
            return
        }

        if (userAccountInstance.hasErrors()) {
            respond userAccountInstance.errors, view:'create'
            return
        }
        userAccountInstance.password = springSecurityService.encodePassword(params.password)
        
        userAccountInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccountInstance.id])
        redirect action:'index'
            
    }

    def edit(UserAccount userAccountInstance) {
        respond userAccountInstance
    }

    @Transactional
    def update(UserAccount userAccountInstance) {
        if (userAccountInstance == null) {
            notFound()
            return
        }

        if (userAccountInstance.hasErrors()) {
            respond userAccountInstance.errors, view:'edit'
            return
        }

        userAccountInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'UserAccount.label', default: 'UserAccount'), userAccountInstance.id])
                redirect userAccountInstance
            }
            '*'{ respond userAccountInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(UserAccount userAccountInstance) {

        if (userAccountInstance == null) {
            notFound()
            return
        }

        userAccountInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserAccount.label', default: 'UserAccount'), userAccountInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    @Transactional
    def register(){
        println("Register eKwento Account:" + params)
        
        def registerUser = new UserAccount()
        registerUser.username = params.regUsername
        registerUser.password = springSecurityService.encodePassword(params.regPassword)
        registerUser.firstName = params.regFirstName
        registerUser.lastName = params.regLastName
        registerUser.email = params.regEmail
        def token = emailerService.tokenGenerator(params.username+params.regFirstName, 40)
        registerUser.token = token
        
        if (registerUser.hasErrors()) {
            //respond userAccountInstance.errors, view:'edit'
            def errorMessage = ""
            registerUser.errors.allErrors.each { error ->
                // set response.error to an appropriate value
                errorMessage += error + " "
            }
            flash.error = errorMessage
            redirect action:"auth", controller:"login"
            return
        }
        registerUser.enabled = false;
        registerUser.save flush:true
        
        def url = createLink(action:"verify", controller:"userAccount", absolute:true)
        params.regLink = url
        params.token = token
        emailerService.sendRegistrationForm(params)
        
        flash.message = "User Account Registered. Please verify your email before logging in on eKwento."
        redirect action:"auth", controller:"login"
    }
    
    @Transactional
    def verify(){
        println("params: " +params);
        
        def userAccountInstance = UserAccount.findByUsername(params.username)
        def userToken = userAccountInstance.token
        
        if(userAccountInstance.enabled){
            flash.error = "User Account already verified."
            redirect action:"auth", controller:"login"
            return
        }
        if(params.token == userToken){
            userAccountInstance.enabled = true;
            userAccountInstance.save(flush:true)
            flash.message = "User Account Verified. You are now ready to login your account on eKwento."
            redirect action:"auth", controller:"login"
            return
        }
        
        
    }
}