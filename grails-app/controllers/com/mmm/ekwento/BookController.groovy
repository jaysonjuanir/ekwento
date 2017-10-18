package com.mmm.ekwento

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import org.springframework.web.multipart.commons.*;

import grails.plugin.springsecurity.annotation.Secured


class BookController {

    def index() { }
    
	//@Secured('ROLE_CREATE_BOOKS')
    def create(){
        println("test method params: "+params)
        
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
        flash.message = "Book "+params.bookTitle + " has been created."
        
        redirect action:'show', id:bookInstance.id
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
	
	//@Secured('ROLE_UPDATE_BOOKS')
    def update(Book bookInstance){
        println("Book update params: " +params)
        
		def logo = request.getFile('bookLogo')
        bookInstance.title = params.bookTitle
        bookInstance.description = params.bookDescription
        bookInstance.content = params.content
        bookInstance.dateUpdated = new Date()
        bookInstance.logo = logo.getBytes()
		
		def genres = Genre.getAll(params.genres)
		bookInstance.genres = genres
        
        bookInstance.save(flush:true, failOnError:true)
        
        flash.message = "Book Updated!"
        
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