package com.mmm.ekwento

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import org.springframework.web.multipart.commons.*;

import grails.plugin.springsecurity.annotation.Secured

@Secured('IS_AUTHENTICATED_FULLY')
class ArticleController {

    def index() { }
    
    def create(){
        println("test method params: "+params)
        
        def testFile=null
        testFile = request.getFile("fileContent")
        def articleInstance
        if(testFile){
            def content = testFile.getFileItem().getString()
            
            articleInstance = new Article()
            articleInstance.title = params.articleTitle
            articleInstance.description = params.articleDescription
            articleInstance.content = content
            articleInstance.dateCreated = new Date()
            articleInstance.dateUpdated = new Date()
            articleInstance.createdBy = authenticatedUser
			def genres = Genre.getAll(params.genres)
			articleInstance.genres = genres
            articleInstance.save(flush:true, failOnError:true)
        }else{
            flash.error = "File cannot read."
            redirect action:"index"
            return
        }
        
        //params.wordLists = wordLists
        //        params.wordLists = wordLists1
        //        
        //        println("wordLists "+wordLists1)
        flash.message = "Book "+params.articleTitle + " has been created."
        
        redirect action:'show', id:articleInstance.id
    }
    
    def show(Article articleInstance){
        println("Book show params: " +params)
        
        def user = authenticatedUser
        
        if(user){
            articleInstance.numberOfViews = articleInstance.numberOfViews + 1
            articleInstance.save(flush:true)
        }
        
        def model = [:]
        model.title = articleInstance.title
        model.description = articleInstance.description
        model.content = articleInstance.content.split("\\r?\\n");
        model.dateCreated = articleInstance.dateCreated
        model.createdBy = articleInstance.createdBy
        model.numberOfViews = articleInstance.numberOfViews
        
        model.isOwned = false
        if(user == articleInstance.createdBy){
			model.isOwned = true
		}
        
        //println(articleInstance.content.split("\\r?\\n"))
        
        respond articleInstance, model:model
    }
    
    def update(Article articleInstance){
        println("Book update params: " +params)
        
        articleInstance.title = params.articleTitle
        articleInstance.description = params.articleDescription
        articleInstance.content = params.content
        articleInstance.dateUpdated = new Date()
		
		def genres = Genre.getAll(params.genres)
		articleInstance.genres = genres
        
        articleInstance.save(flush:true, failOnError:true)
        
        flash.message = "Book Updated!"
        
        redirect action:"show", id:articleInstance.id
    }
}