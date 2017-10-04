class UrlMappings {
    
    def springSecurityService

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        if (springSecurityService.isLoggedIn()) {
            "/"(controller: "home", action:"show")
            "/home/$action?"(controller: "home")
        }else{
            "/"(controller: "home", action:"index")
            "/home/$action?"(controller: "home")
        }
//        "/login/$action?"(controller: "login")
        
        "500"(view:'/error')
	}
}
