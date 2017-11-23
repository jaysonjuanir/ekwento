package com.mmm.ekwento

import groovy.time.TimeCategory
import org.springframework.security.access.annotation.Secured

@Secured('permitAll')
class MangaController {

    def index(Integer max) { 
		println("manga index: " +params)
		String view
		params.max = Math.min(max ?: 10, 100)
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        def minorAgeCompare
        def minorIndicator = true
        
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
		
		model.mangaInstanceCount = Manga.createCriteria().get{
			projections{
				countDistinct("id")
			}
			eq("approved", true);
			eq("rejected", false)
			if(params?.searchManga)
				ilike("title", "%"+params.searchManga+"%")
				
            genres{
                if(minorIndicator)
                    eq("isRestricted", false)
                if(params.genre)
                    eq('id', params.genre.toLong())
            }
		}
		model.mangaInstanceIdList = Manga.createCriteria().list{
            projections{
                groupProperty("id")
            }
			eq("approved", true);
			eq("rejected", false);
			
			if(params?.searchManga)
				ilike("title", "%"+params.searchManga+"%")
                
            genres{
                if(minorIndicator)
                    eq("isRestricted", false)
                if(params.genre)
                    eq('id', params.genre.toLong())
            }
				
			maxResults(new Integer(params.max))
			firstResult(new Integer(params.offset))
			order("dateCreated")
		}
        model.mangaInstanceList = Manga.getAll(model.mangaInstanceIdList)
		
		render view: 'index', model: model
	}
	
	@Secured('ROLE_CREATE_MANGA')
    def create(){
        println("test method params: "+params)
        
		
        def logo = request.getFile("mangaLogo")
        def mangaInstance
            
		mangaInstance = new Manga()
		mangaInstance.title = params.mangaTitle
		mangaInstance.description = params.mangaDescription

		if(logo)
			mangaInstance.logo = logo.getBytes()

		mangaInstance.dateCreated = new Date()
		mangaInstance.dateUpdated = new Date()
		mangaInstance.createdBy = authenticatedUser
		def genres = Genre.getAll(params.genres)
		mangaInstance.genres = genres
		mangaInstance.save(flush:true, failOnError:true)


		//manga page adding

		def mangaFiles = request.getFiles("mangaContent")

		mangaFiles.sort{a,b -> 
			def a1 = a.getOriginalFilename() 
			def b2 = b.getOriginalFilename()

			def n1 = (a1 =~ /\d+/)[-1] as Integer
			def n2 = (b2 =~ /\d+/)[-1] as Integer

			def s1 = a1.replaceAll(/\d+$/, '').trim()
			def s2 = b2.replaceAll(/\d+$/, '').trim()

			if (n1 == n2){
				return s1 <=> s2
			}
			else{
				return n1 <=> n2
			}
		}
		mangaFiles.eachWithIndex { file, index ->    
			println("Page Number: " + index + " and file " + file.getOriginalFilename())
			def mangaPageInstance = new MangaPage()

			if(file){
				mangaPageInstance.page = (index+1)
				mangaPageInstance.logo = file.getBytes()
				mangaPageInstance.manga = mangaInstance
				mangaPageInstance.save(flush:true)
			}
		}
        
        //params.wordLists = wordLists
        //        params.wordLists = wordLists1
        //        
        //        println("wordLists "+wordLists1)
        flash.message = "Manga "+params.mangaTitle + " has been created. Please wait for Admin to approve your Manga"
		
		
		
        
        redirect action:"index"
    }
	
	
	
	def show(Manga mangaInstance){
        println("Manga show params: " +params)
        
        def user = authenticatedUser
		
		if(!params.page){
			params.page = "1"
		}
        
        if(user && params.page == "1"){
            mangaInstance.numberOfViews = mangaInstance.numberOfViews + 1
            mangaInstance.save(flush:true)
        }
        
        def model = [:]
        model.title = mangaInstance.title
        model.description = mangaInstance.description
        model.dateCreated = mangaInstance.dateCreated
        model.createdBy = mangaInstance.createdBy
        model.numberOfViews = mangaInstance.numberOfViews
		
		model.mangaPage = MangaPage.findByMangaAndPage(mangaInstance,params.page)
		def mangaPageSize = MangaPage.findAllByManga(mangaInstance)
		model.mangaPageId = model.mangaPage.id
		model.mangaMaxPage = mangaPageSize.size()
		
		println("model.mangaPage: " + model.mangaPage);
		println("model.mangaMaxPage: " + model.mangaMaxPage);
        
        model.isOwned = false
        if(user == mangaInstance.createdBy){
			model.isOwned = true
		}
        
        //println(mangaInstance.content.split("\\r?\\n"))
        
        respond mangaInstance, model:model
    }
	
	
	@Secured('IS_AUTHENTICATED_ANONYMOUSLY')
	def renderImage(){
        log.info "renderImage : " + params.id
        println "renderImage : " + params.id
		
        def mangaInstance = Manga.findById(params.id)
        if (mangaInstance?.logo) {
            response.setContentLength(mangaInstance.logo.length)
            response.outputStream.write(mangaInstance.logo)
        } else {
            response.sendError(404)
        }
    }
	
	@Secured('IS_AUTHENTICATED_ANONYMOUSLY')
	def renderImagePage(){
        log.info "renderImage : " + params.id
        println "renderImage : " + params.id
		
        def mangaInstance = MangaPage.findById(params.id)
        if (mangaInstance?.logo) {
            response.setContentLength(mangaInstance.logo.length)
            response.outputStream.write(mangaInstance.logo)
        } else {
            response.sendError(404)
        }
    }
}
