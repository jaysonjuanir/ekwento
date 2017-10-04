package com.mmm.ekwento

import javax.servlet.http.HttpServletResponse
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.access.annotation.Secured

@Secured('permitAll')
class LogoutController {
    def index() {
        redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
    }
}