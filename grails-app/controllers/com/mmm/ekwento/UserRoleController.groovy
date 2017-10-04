package com.mmm.ekwento



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

///@Secured('IS_AUTHENTICATED_FULLY')
@Transactional(readOnly = true)
class UserRoleController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def total = 0
        def list = []
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        
        total = UserRole.createCriteria().get{
            if(params.searchCriteria)
            or {
                ilike('authority',"%$params.searchCriteria%")
            }
            projections{
                count('id')
            }
        }
        list = UserRole.createCriteria().list{
            if(params.searchCriteria)
            or {
                ilike('authority',"%$params.searchCriteria%")
            }
            maxResults(new Integer(params.max))
            firstResult(new Integer(params.offset))
            order("authority")
        }
        
        render (view:"index", model:[userRoleInstanceCount: total, userRoleInstance:list])
    }

    def show(UserRole userRoleInstance) {
        respond userRoleInstance
    }

    def create() {
        respond new UserRole(params)
    }

    @Transactional
    def save(UserRole userRoleInstance) {
        println("lol this!")
        if (userRoleInstance == null) {
            notFound()
            return
        }
        
        userRoleInstance.authority=params.authority

        if (userRoleInstance.hasErrors()) {
            respond userRoleInstance.errors, view:'create'
            return
        }

        userRoleInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'userRole.label', default: 'UserRole'), userRoleInstance.id])
        redirect (action:"index")
    }

    def edit(UserRole userRoleInstance) {
        respond userRoleInstance
    }

    @Transactional
    def update(UserRole userRoleInstance) {
        if (userRoleInstance == null) {
            notFound()
            return
        }
        
        userRoleInstance.authority=params.authority

        if (userRoleInstance.hasErrors()) {
            respond userRoleInstance.errors, view:'edit'
            return
        }

        userRoleInstance.save flush:true
        
        flash.message = message(code: 'default.updated.message', args: [message(code: 'userRole.label', default: 'UserRole'), userRoleInstance.id])
        redirect (action:"index")
    }

    @Transactional
    def delete(UserRole userRoleInstance) {

        if (userRoleInstance == null) {
            notFound()
            return
        }

        userRoleInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserRole.label', default: 'UserRole'), userRoleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
