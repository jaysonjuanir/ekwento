class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "home", action:"index")
		"/home/$action?"(controller: "home")
//        "/login/$action?"(controller: "login")
        
        "500"(view:'/error')
	}
}
