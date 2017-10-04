package com.mmm.ekwento

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils

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
        render(view:"show");
    }
}
