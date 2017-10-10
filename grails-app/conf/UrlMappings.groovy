class UrlMappings {
    

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

//            "/"(controller: "home", action:"index")
        
        "/"(controller: "login", action:"index")
		"/login/$action?"(controller: "login")
//        "/login/$action?"(controller: "login")
        
        "500"(view:'/error')
	}
}
