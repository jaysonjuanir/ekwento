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
    
	def createApproveEmailBook = { bookInstance ->
        def notification = composeApprovedBookMessage(bookInstance)
        def mail = bookInstance.createdBy.email
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Approved Book ${bookInstance.title}"
                body notification
            }
        }
	}
	
	def createApproveEmailArticle = { articleInstance ->
        def notification = composeApprovedArticleMessage(articleInstance)
        def mail = articleInstance.createdBy.email
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Approved Article ${articleInstance.title}"
                body notification
            }
        }
	}
	
	def createApproveEmailManga = { mangaInstance ->
        def notification = composeApprovedMangaMessage(mangaInstance)
        def mail = mangaInstance.createdBy.email
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Approved Manga ${mangaInstance.title}"
                body notification
            }
        }
	}
	
	def createRejectEmailBook = { bookInstance ->
        def notification = composeRejectedBookMessage(bookInstance)
        def mail = bookInstance.createdBy.email
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Rejected Book ${bookInstance.title}"
                body notification
            }
        }
	}
	
	def createRejectEmailManga = { mangaInstance ->
        def notification = composeRejectedMangaMessage(mangaInstance)
        def mail = mangaInstance.createdBy.email
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Rejected Manga ${mangaInstance.title}"
                body notification
            }
        }
	}
	
	def createRejectEmailArticle = { articleInstance ->
        def notification = composeRejectedArticleMessage(articleInstance)
        def mail = articleInstance.createdBy.email
        
        if(mail) {
            sendMail {
                to mail
                subject "eKwento Rejected Article ${articleInstance.title}"
                body notification
            }
        }
	}
	
	def composeRejectedBookMessage = { bookInstance ->
		def content = """Hi ${bookInstance.createdBy},

Greetings!

Your Book on eKwento has been rejected!\n\

The reason why it has been rejected was because of ${bookInstance.reasonForReject}.\n\

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
	
	def composeRejectedMangaMessage = { mangaInstance ->
		def content = """Hi ${mangaInstance.createdBy},

Greetings!

Your Manga on eKwento has been rejected!\n\

The reason why it has been rejected was because of ${mangaInstance.reasonForReject}.\n\

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
	
	def composeRejectedArticleMessage = { articleInstance ->
		def content = """Hi ${articleInstance.createdBy},

Greetings!

Your Article on eKwento has been rejected!\n\

The reason why it has been rejected was because of ${articleInstance.reasonForReject}.\n\

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
	
	def composeApprovedArticleMessage = { articleInstance ->
		def content = """Hi ${articleInstance.createdBy},

Greetings!

Your Article on eKwento has been approved!\n\

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
	
	def composeApprovedBookMessage = { bookInstance ->
		def content = """Hi ${bookInstance.createdBy},

Greetings!

Your Book on eKwento has been approved!\n\

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
	
	def composeApprovedMangaMessage = { mangaInstance ->
		def content = """Hi ${mangaInstance.createdBy},

Greetings!

Your Manga on eKwento has been approved!\n\

Very truly yours,

eKwento Admin."""

		return content.toString()
	}
}
