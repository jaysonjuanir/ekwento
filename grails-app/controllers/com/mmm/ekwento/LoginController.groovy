package com.mmm.ekwento

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils

import javax.servlet.http.HttpServletResponse
//
//import org.springframework.security.access.annotation.Secured
//import org.springframework.security.authentication.AccountExpiredException
//import org.springframework.security.authentication.CredentialsExpiredException
//import org.springframework.security.authentication.DisabledException
//import org.springframework.security.authentication.LockedException
//import org.springframework.security.core.context.SecurityContextHolder as SCH
//import org.springframework.security.web.WebAttributess
import org.apache.commons.lang.RandomStringUtils;


class LoginController {
    
    def authenticationTrustResolver
    

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService
        
    def index() {
        println("login index")
        if (springSecurityService.isLoggedIn()) {
            println("postUrl lol dito ba?")
            //			redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
            redirect action:'show', controller:"home"
            //			redirect uri: '/index'
            //			redirect uri: '/layouts/main'
        }
        else {
            redirect action: 'auth', params: params
        }
    }

    def auth() {
        println("login auth")
        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            println("postUrl lol dito ba?")
            //redirect uri: config.successHandler.defaultTargetUrl
            redirect action:'show', controller:"home"
            return
        }

        String view = 'auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        
        
        render view: view, model: [postUrl: postUrl]
        return
    }
    
}
