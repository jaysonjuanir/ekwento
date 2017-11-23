package com.mmm.ekwento

import java.text.SimpleDateFormat
import groovy.time.TimeCategory
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import org.springframework.web.multipart.commons.*;

import org.springframework.security.access.annotation.Secured

@Secured('permitAll')
class BookController {

    def index(Integer max) { 
		println("book index: " +params)
		String view
        def genre = []
		params.max = Math.min(max ?: 10, 100)
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        def minorAgeCompare
        def minorIndicator = true
        
        //def sdf = new SimpleDateFormat("MM/dd/yyyy");
        if(authenticatedUser){
            Date birthdate = authenticatedUser.birthdate;
            use(TimeCategory) {
                minorAgeCompare = new Date() - 18.year
            }

            if(minorAgeCompare >= authenticatedUser.birthdate){
                println "not minor" 
                minorIndicator = false
            }
        }
        
        def model= [:]		
		
		model.bookInstanceCount = Book.createCriteria().get{
			projections{
				countDistinct("id")
			}
			eq("approved", true);
			eq("rejected", false)
			if(params?.searchBook)
				ilike("title", "%"+params.searchBook+"%")
                
            genres{
                if(minorIndicator){
                    eq("isRestricted", false)
                }
                if(params.genre)
                eq('id', params.genre.toLong())
            }
		}
        //model.bookInstanceList = Book.executeQuery("select distinct b from Book b join Genre g where g.isRestricted=0 and b.approved= :approved and b.rejected= :rejected order by b.dateCreated",[approved:true,rejected:false], [max: new Integer(params.max), offset: new Integer(params.offset)])
		model.bookInstanceIdList = Book.createCriteria().list{
            projections{
                groupProperty("id")
            }
			eq("approved", true);
			eq("rejected", false);
			
			if(params?.searchBook)
				ilike("title", "%"+params.searchBook+"%")

            genres{
                if(minorIndicator){
                    eq("isRestricted", false)
                }
                if(params.genre)
                eq('id', params.genre.toLong())
            }
				
			maxResults(new Integer(params.max))
			firstResult(new Integer(params.offset))
			order("dateCreated")
		}
        model.bookInstanceList = Book.getAll(model.bookInstanceIdList)
		render view: 'index', model: model
	}
    
	@Secured('ROLE_CREATE_BOOKS')
    def create(){
        println("book create method params: "+params)
        
        def testFile=null
        testFile = request.getFile("fileContent")
		def logo = request.getFile('bookLogo')
        def bookInstance
        if(testFile){
            def content = testFile.getFileItem().getString()
            
            bookInstance = new Book()
            bookInstance.title = params.bookTitle
            bookInstance.description = params.bookDescription
            bookInstance.content = content
			if(logo)
				bookInstance.logo = logo.getBytes()
			
            bookInstance.dateCreated = new Date()
            bookInstance.dateUpdated = new Date()
            bookInstance.createdBy = authenticatedUser
			def genres = Genre.getAll(params.genres)
			bookInstance.genres = genres
            bookInstance.save(flush:true, failOnError:true)
        }else{
            flash.error = "File cannot read."
            redirect action:"index"
            return
        }
        
        //params.wordLists = wordLists
        //        params.wordLists = wordLists1
        //        
        //        println("wordLists "+wordLists1)
        flash.message = "Book "+params.bookTitle + " has been created. Please wait for Admin to approve your Book"
        
        redirect action:"index"
    }
    
    def show(Book bookInstance){
        println("Book show params: " +params)
        
        def user = authenticatedUser
        
        if(user){
            bookInstance.numberOfViews = bookInstance.numberOfViews + 1
            bookInstance.save(flush:true)
        }
		
        def model = [:]
        model.title = bookInstance.title
        model.description = bookInstance.description
        model.content = bookInstance.content.split("\\r?\\n");
        model.dateCreated = bookInstance.dateCreated
        model.createdBy = bookInstance.createdBy
        model.numberOfViews = bookInstance.numberOfViews
        
		model.isOwned = false
        if(user == bookInstance.createdBy){
			model.isOwned = true
		}else{
			//			if(!bookInstance.approved){
			//				flash.message = "Book is not ready for viewing because it is not approved by admin"
			//				redirect action:"show", controller:"home"
			//			}
		}
        
        //println(bookInstance.content.split("\\r?\\n"))
        
        respond bookInstance, model:model
    }
	
	@Secured('ROLE_UPDATE_BOOKS')
    def update(Book bookInstance){
        println("Book update params: " +params)
        
		def logo = request.getFile('bookLogo')
        bookInstance.title = params.bookTitle
        bookInstance.description = params.bookDescription
        bookInstance.content = params.content
        bookInstance.dateUpdated = new Date()
		
		if(logo)
			bookInstance.logo = logo.getBytes()
		
		def genres = Genre.getAll(params.genres)
		bookInstance.genres = genres
        
        bookInstance.save(flush:true, failOnError:true)
        
        flash.message = "Book Updated!"
        
        redirect action:"show", id:bookInstance.id
    }
	
	@Secured('ROLE_UPDATE_BOOKS')
	def followAuthor(Book bookInstance){
		println "followAuthor : " + params.id + " and following: " + bookInstance.createdBy
		
		def follow = new Follower()
		follow.userFollowed = authenticatedUser
		follow.userFollowing = bookInstance.createdBy
		follow.save(flush:true)
		
		flash.message = "Author followed!"
        
        redirect action:"show", id:bookInstance.id
	}
	
	@Secured('IS_AUTHENTICATED_ANONYMOUSLY')
	def renderImage(){
        log.info "renderImage : " + params.id
        println "renderImage : " + params.id
		
        def bookInstance = Book.findById(params.id)
        if (bookInstance?.logo) {
            response.setContentLength(bookInstance.logo.length)
            response.outputStream.write(bookInstance.logo)
        } else {
            response.sendError(404)
        }
    }
}