package com.mmm.ekwento

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils

import javax.servlet.http.HttpServletResponse

class HomeController {

    def index() { 
        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'index'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl]
    }
}
