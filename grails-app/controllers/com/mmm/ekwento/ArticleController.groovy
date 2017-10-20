package com.mmm.ekwento

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import org.springframework.web.multipart.commons.*;

import org.springframework.security.access.annotation.Secured

@Secured('permitAll')
class ArticleController {

    def index(Integer max) { 
		println("article index: " +params)
		String view
		params.max = Math.min(max ?: 10, 100)
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        
        def model= [:]		
		
		model.articleInstanceCount = Article.createCriteria().get{
			projections{
				count("id")
			}
			eq("approved", true);
			eq("rejected", false)
			if(params?.searchArticle)
				ilike("title", "%"+params.searchArticle+"%")
				
		}
		model.articleInstanceList = Article.createCriteria().list{
			eq("approved", true);
			eq("rejected", false);
			
			if(params?.searchArticle)
				ilike("title", "%"+params.searchArticle+"%")
				
			maxResults(new Integer(params.max))
			firstResult(new Integer(params.offset))
			order("dateCreated")
		}
		
		render view: 'index', model: model
	}
    
	@Secured('ROLE_CREATE_ARITICLES')
    def create(){
        println("Article create method params: "+params)
        
        def testFile=null
        testFile = request.getFile("fileContent")
		
        def logo = request.getFile("articleLogo")
        def articleInstance
        if(testFile){
            def content = testFile.getFileItem().getString()
            
            articleInstance = new Article()
            articleInstance.title = params.articleTitle
            articleInstance.description = params.articleDescription
            articleInstance.content = content
			
			if(logo)
				articleInstance.logo = logo.getBytes()
			
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
        flash.message = "Article "+params.articleTitle + " has been created. Please wait for Admin to approve your Article"
        
        redirect action:"index"
    }
    
    def show(Article articleInstance){
        println("Article show params: " +params)
        
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
    
	@Secured('ROLE_UPDATE_ARITICLES')
    def update(Article articleInstance){
        println("Article update params: " +params)
        
		def logo = request.getFile('articleLogo')
        articleInstance.title = params.articleTitle
        articleInstance.description = params.articleDescription
        articleInstance.content = params.content
        articleInstance.dateUpdated = new Date()
		if(logo)
			articleInstance.logo = logo.getBytes()
		
		def genres = Genre.getAll(params.genres)
		articleInstance.genres = genres
        
        articleInstance.save(flush:true, failOnError:true)
        
        flash.message = "Book Updated!"
        
        redirect action:"show", id:articleInstance.id
    }
	
	def renderImage = {
        log.info "renderImage : " + params.id
        def articleInstance = Article.findById(params.id)

        if (articleInstance?.logo) {
            response.setContentLength(articleInstance.logo.length)
            response.outputStream.write(articleInstance.logo)
        } else {
            response.sendError(404)
        }
    }
}