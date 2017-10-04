package com.mmm.ekwento

import org.springframework.mail.MailException
import org.springframework.mail.MailSender
import org.springframework.mail.SimpleMailMessage
import grails.transaction.Transactional
import javax.servlet.http.HttpServletRequest


class EmailerService {
    
    def servletContext
	def customJasperService
	MailSender mailSender
	SimpleMailMessage mailMessage // a "prototype" email instance

    

    def sendRegistrationForm = { params ->
		def name = params.regFirstName +" "+params.regLastName 
//        def url = createLink(action:"verify", controller:"userAccount", absolute:true)
        def url = params.regLink 
        
        def token = params.token
        def regLink = url+"?username="+params.regUsername+"&token="+token
        
        def notification = notificationMessage(name, regLink)
        def mail = params.regEmail
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Registration Verification Form"
                body notification
            }
        }
	}
    
    def tokenGenerator = { String alphabet, int n ->
        new Random().with {
            (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
        }
    }
    
    def notificationMessage = { name, regLink ->

		def content = """Hi ${name},

Greetings!

Thank you for registering on eKwento!\n\

Please visit the link provided below to verify you account.\n\
${regLink}

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
    
}
