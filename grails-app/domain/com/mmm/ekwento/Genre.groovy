package com.mmm.ekwento

class Genre {
	
	String type
    String isRestricted = false

    static constraints = {
		type nullable:false
    }
}
