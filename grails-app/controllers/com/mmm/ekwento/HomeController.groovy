package com.mmm.ekwento

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.web.multipart.commons.*;
import org.springframework.security.access.annotation.Secured

import javax.servlet.http.HttpServletResponse

//@Secured('IS_AUTHENTICATED_FULLY')
class HomeController {
    
    def springSecurityService
    def emailerService
    def searchService

	@Secured('permitAll')
    def index() { 
        println("home index")
        
        def config = SpringSecurityUtils.securityConfig

		//        if (springSecurityService.isLoggedIn()) {
		////            redirect uri: '/home/show'
		//            redirect action:'show', controller:"home"
		//            return
		//        }

		def globalLatestUploadList = searchService.getGlobalLatestUploadResult(0, 4)
		def globalPopularUploadList = searchService.getGlobalPopularUploadResult(0, 12)
		
		println("globalLatestUploadList: " +globalLatestUploadList)
		globalLatestUploadList.each{latest->
			println("globalLatest.title class: " + (latest.title.getClass()))
		}
		println("globalPopularUploadList" +globalPopularUploadList)

        String view = 'index'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
		
		def model = [:]
		
		model.postUrl = postUrl
		model.globalLatestUploadList = globalLatestUploadList
		model.globalPopularUploadList = globalPopularUploadList 
		
		println("model: "+ model)
//        respond view: view, model: model
		render(view: "index", model: model)
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def list() { 
        println("home list: " +params)
		def max = null
		String view
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
				if(params?.searchBook){
					or{
						ilike("title", "%"+params.searchBook+"%")
						ilike("description", "%"+params.searchBook+"%")
					}
				}
				
			}
			model.bookPendingList = Book.createCriteria().list{
				eq("approved", false);
				eq("rejected", false);
				if(params?.searchBook){
					or{
						ilike("title", "%"+params.searchBook+"%")
						ilike("description", "%"+params.searchBook+"%")
					}
				}
				
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
				if(params?.searchArticle){
					or{
						ilike("title", "%"+params.searchArticle+"%")
						ilike("description", "%"+params.searchArticle+"%")
					}
				}
			}
			model.articlePendingList = Article.createCriteria().list{
				eq("approved", false);
				eq("rejected", false);
				if(params?.searchArticle){
					or{
						ilike("title", "%"+params.searchArticle+"%")
						ilike("description", "%"+params.searchArticle+"%")
					}
				}
				
				maxResults(new Integer(params.max))
				firstResult(new Integer(params.offset))
				order("dateCreated")
			}
			view = 'articleAdminList'
			params.listId = params.id
			
			println("model.articleAdminList: " + model.bookPendingList)
		}else if(params.id=="3"){  //manga
			//			model.bookPendingList = Manga.createCriteria().list{
			//				eq("approved", false);
			//				eq("rejected", false)
			//			}

			model.mangaPendingCount = Manga.createCriteria().get{
				projections{
					count("id")
				}
				eq("approved", false);
				eq("rejected", false)
				if(params?.searchManga){
					or{
						ilike("title", "%"+params.searchManga+"%")
						ilike("description", "%"+params.searchManga+"%")
					}
				}
			}
			model.mangaPendingList = Manga.createCriteria().list{
				eq("approved", false);
				eq("rejected", false);
				if(params?.searchManga){
					or{
						ilike("title", "%"+params.searchManga+"%")
						ilike("description", "%"+params.searchManga+"%")
					}
				}
				
				maxResults(new Integer(params.max))
				firstResult(new Integer(params.offset))
				order("dateCreated")
			}
			view = 'mangaAdminList'
			params.listId = params.id
			
			println("model.mangaAdminList: " + model.bookPendingList)
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
		emailerService.createApproveEmailBook(bookInstance)

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
		emailerService.createApproveEmailArticle(articleInstance)

		flash.message = "Successfully approved the ${articleInstance} article!"
        String view = 'list'
        redirect action:"list", id:params.listId
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateApproveAdminManga(Manga mangaInstance) { 
        
        def model= [:]		
		model.mangaUser = mangaInstance.createdBy

		mangaInstance.approved = true
		mangaInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		emailerService.createApproveEmailManga(mangaInstance)

		flash.message = "Successfully approved the manga! ${mangaInstance}"
        String view = 'list'
        redirect action:"list", id:params.listId
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def showRejectAdminBookForm(Book bookInstance) { 
        def model= [:]
		model.bookInstance = bookInstance
        render view:"showRejectBookForm", id:bookInstance.id, model:model
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def showRejectAdminArticleForm(Article articleInstance) { 
        def model= [:]		
		model.articleInstance = articleInstance
        render view:"showRejectArticleForm", id:articleInstance.id,model:model
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def showRejectAdminMangaForm(Manga mangaInstance) { 
        def model= [:]		
		model.mangaInstance = mangaInstance
        render view:"showRejectMangaForm", id:mangaInstance.id,model:model
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateRejectAdminBook(Book bookInstance) { 
        println("updateRejectAdminBook params: ${params}")

		bookInstance.rejected = true
		bookInstance.reasonForReject = params.reasonForReject
		bookInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		emailerService.createRejectEmailBook(bookInstance)

		flash.message = "Successfully rejected the ${bookInstance} Book!"
        String view = 'list'
        redirect action:"list", id:1
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateRejectAdminArticle(Article articleInstance) { 
        println("updateRejectAdminArticle params: ${params}")

		articleInstance.rejected = true
		articleInstance.reasonForReject = params.reasonForReject
		articleInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		emailerService.createRejectEmailArticle(articleInstance)

		flash.message = "Successfully rejected the ${articleInstance} Article!"
        String view = 'list'
        redirect action:"list", id:2
    }
	
	@Secured('ROLE_ADMIN_DASHBOARD')
	def updateRejectAdminManga(Manga mangaInstance) { 
        println("updateRejectAdminManga params: ${params}")

		mangaInstance.rejected = true
		mangaInstance.reasonForReject = params.reasonForReject
		mangaInstance.save(flush:true, failOnError:true)
		
		
		//create notification from user here
		emailerService.createRejectEmailManga(mangaInstance)

		flash.message = "Successfully rejected the ${mangaInstance} Manga!"
        String view = 'list'
        redirect action:"list", id:3
    }
    
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
	
	@Secured('permitAll')
	def searchList(){
		println("Search List params: "+params)
		
		def model = [:]
        if(!params.max) params.max = 10
		else params.max = params.max.toInteger()
		
        if(!params.offset) params.offset = 0
		else params.offset = params.offset.toInteger()
		
		if(!params.searchCriteria) params.searchCriteria = ""
		
		def searchGlobalList = searchService.searchGlobalResult(params.searchCriteria, params.offset, params.max)
		def searchGlobalCount = searchService.searchGlobalCount(params.searchCriteria)
		
		model.searchGlobalList = searchGlobalList
		model.searchGlobalCount = searchGlobalCount
		
		println("model Success!: "+model)
		
		render(view:"searchList", model:model)
	}
	
	@Secured('permitAll')
	def latestUploads(){
		println("Latest Uploads params: "+params)
		
		def model = [:]
        if(!params.max) params.max = 10
		else params.max = params.max.toInteger()
		
        if(!params.offset) params.offset = 0
		else params.offset = params.offset.toInteger()
		
		if(!params.searchCriteria) params.searchCriteria = ""
		
		def latestGlobalList = searchService.getGlobalLatestUploadResult(params.offset, params.max)
		def latestGlobalCount = searchService.getGlobalLatestUploadCount()
		
		model.latestGlobalList = latestGlobalList
		model.latestGlobalCount = latestGlobalCount
		
		println("model Success!: "+model)
		
		render(view:"latestUploads", model:model)
	}
	
	@Secured('permitAll')
	def popularUploads(){
		println("Popular Uploads params: "+params)
		
		def model = [:]
        if(!params.max) params.max = 10
		else params.max = params.max.toInteger()
		
        if(!params.offset) params.offset = 0
		else params.offset = params.offset.toInteger()
		
		def popularGlobalList = searchService.getGlobalPopularUploadResult(params.offset, params.max)
		def popularGlobalCount = searchService.getGlobalPopularUploadCount()
		
		model.popularGlobalList = popularGlobalList
		model.popularGlobalCount = popularGlobalCount
		
		println("model Success!: "+model)
		
		render(view:"popularUploads", model:model)
	}
}
