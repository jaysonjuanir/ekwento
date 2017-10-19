package com.mmm.ekwento

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.web.multipart.commons.*;
import org.springframework.security.access.annotation.Secured

import javax.servlet.http.HttpServletResponse

//@Secured('IS_AUTHENTICATED_FULLY')
class HomeController {
    
    def springSecurityService

	@Secured('permitAll')
    def index() { 
        println("home index")
        
        def config = SpringSecurityUtils.securityConfig

//        if (springSecurityService.isLoggedIn()) {
////            redirect uri: '/home/show'
//            redirect action:'show', controller:"home"
//            return
//        }

		

        String view = 'index'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        respond view: view, model: [postUrl: postUrl]
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def list() { 
        println("home list: " +params)
		def max = null
		String view
		params.max = Math.min(max ?: 10, 100)
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        
        def model= [:]		

		if(params.id=="1"){ //book
			model.bookPendingCount = Book.createCriteria().get{
				projections{
					count("id")
				}
				eq("approved", false);
				eq("rejected", false)
				if(params?.searchBook)
					ilike("title", "%"+params.searchBook+"%")
				
			}
			model.bookPendingList = Book.createCriteria().list{
				eq("approved", false);
				eq("rejected", false);
				if(params?.searchBook)
					ilike("title", "%"+params.searchBook+"%")
				
				maxResults(new Integer(params.max))
				firstResult(new Integer(params.offset))
				order("dateCreated")
			}
			view = 'bookAdminList'
			params.listId = params.id
			
			println("model.bookPendingList: " + model.bookPendingList)
		}else if(params.id=="2"){ //article
			model.articlePendingCount = Article.createCriteria().get{
				projections{
					count("id")
				}
				eq("approved", false);
				eq("rejected", false)
				if(params?.searchBook)
					ilike("title", "%"+params.searchBook+"%")
				
			}
			model.articlePendingList = Article.createCriteria().list{
				eq("approved", false);
				eq("rejected", false);
				if(params?.searchBook)
					ilike("title", "%"+params.searchBook+"%")
				
				maxResults(new Integer(params.max))
				firstResult(new Integer(params.offset))
				order("dateCreated")
			}
			view = 'articleAdminList'
			params.listId = params.id
			
			println("model.articleAdminList: " + model.bookPendingList)
		}else if(params.id=="3"){  //manga
//			model.bookPendingList = Book.createCriteria().list{
//				eq("approved", false);
//				eq("rejected", false)
//			}
		}

        //String view = 'list'
        render view: view, model: model
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateApproveAdminBook(Book bookInstance) { 
        log.info "updateApproveAdminBook: " + params
        def model= [:]		
		model.bookUser = bookInstance.createdBy

		bookInstance.approved = true
		bookInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		//notification.createNotif(model.bookUser, "Admin approved your book.")

		flash.message = "Successfully approved the ${bookInstance} Book!"
        //String view = 'list'
		//model.id = params.listId
        redirect action:"list", id:params.listId
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateApproveAdminArticle(Article articleInstance) { 
        
        def model= [:]		
		model.articleUser = articleInstance.createdBy

		articleInstance.approved = true
		articleInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		//notification.createNotif(model.bookUser, "Admin approved your article.")

		flash.message = "Successfully approved the ${articleInstance} article!"
        String view = 'list'
        redirect action:"list", id:params.listId
    }
	
	/*@Secured('ROLE_ADMIN_DASHBOARD')
	def updateApproveAdminManga(Manga mangaInstance) { 
        
        def model= [:]		
		model.mangaUser = mangaInstance.createdBy

		mangaInstance.approved = true
		mangaInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		//notification.createNotif(model.bookUser, "Admin approved your manga.")

		flash.message = "Successfully approved the book! ${mangaInstance}"
        String view = 'list'
        respond view: view, model: model
    }*/
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateRejectAdminBook(Book bookInstance) { 
        
        def model= [:]		
		model.bookUser = bookInstance.createdBy

		bookInstance.rejected = true
		bookInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		//notification.createNotif(model.bookUser, "Admin rejected your book.")

		flash.message = "Successfully rejected the ${bookInstance} Book!"
        String view = 'list'
        redirect action:"list", id:params.listId
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateRejectAdminArticle(Article articleInstance) { 
        
        def model= [:]		
		model.articleUser = articleInstance.createdBy

		articleInstance.rejected = true
		articleInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		//notification.createNotif(model.bookUser, "Admin rejected your article.")

		flash.message = "Successfully rejected the ${articleInstance} Article!"
        String view = 'list'
        redirect action:"list", id:params.listId
    }
	
	/*@Secured('ROLE_ADMIN_DASHBOARD')
	def updateRejectAdminBook(Book bookInstance) { 
        
        def model= [:]		
		model.bookUser = bookInstance.createdBy

		bookInstance.rejected = true
		bookInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		//notification.createNotif(model.bookUser, "Admin rejected your book.")

		flash.message = "Successfully rejected the book! ${bookInstance}"
        String view = 'list'
        respond view: view, model: model
    }*/
    
	@Secured('IS_AUTHENTICATED_FULLY')
    def show(){
        println("Home show method params: "+params)
        //        if(params?.tempFile){
        //            Scanner sc = new Scanner(params.tempFile);
        //            List<String> lines = new ArrayList<String>();
        //            while (sc.hasNextLine()) {
        //                lines.add(sc.nextLine());
        //            }
        //            params.wordLists = lines
        //            println("lines: " + lines.size());
        //        }
        def testFile=null
//        testFile = request.getFile("fileContent")
//        if(testFile){
//            def contentDaw = testFile.getFileItem().getString()
//            
//            def wordLists = contentDaw.split("\\r?\\n");
//            
//            params.wordLists = wordLists
//            println("lines: " + wordLists.size());
//        }
        
        println("Home show method params: "+params)
        render(view:"show");
    }
}
