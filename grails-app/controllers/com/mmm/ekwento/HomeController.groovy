package com.mmm.ekwento

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.web.multipart.commons.*;

import javax.servlet.http.HttpServletResponse

class HomeController {
    
    def springSecurityService

    def index() { 
        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: '/home/show'
            return
        }

        String view = 'index'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl]
    }
    
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
