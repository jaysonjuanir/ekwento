package com.mmm.ekwento

class Genre {
	
	String type
    Boolean isRestricted = false

    static constraints = {
		type nullable:false
    }
    String toString(){ type }
}
