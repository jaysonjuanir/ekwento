package com.mmm.ekwento

import org.springframework.security.access.annotation.Secured

@Secured('permitAll')
class AboutController {

    def ekwento() { 
		render(view:"ekwento");
	}
}
