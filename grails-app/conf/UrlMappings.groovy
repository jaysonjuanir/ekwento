class UrlMappings {
    

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

//            "/"(controller: "home", action:"index")
        
        "/login/$action?"(controller: "login")
		"/logout/$action?"(controller: "logout")
		"/"(controller: "login", action:"index")
        
        "500"(view:'/error')
	}
}
