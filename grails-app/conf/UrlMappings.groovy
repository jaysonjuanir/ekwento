class UrlMappings {
    

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

//            "/"(controller: "home", action:"index")
        
        "/home/$action?"(controller: "home")
		"/logout/$action?"(controller: "logout")
		"/"(controller: "home", action:"index")
        
        "500"(view:'/error')
	}
}
