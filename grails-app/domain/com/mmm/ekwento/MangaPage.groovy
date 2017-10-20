package com.mmm.ekwento

class MangaPage {

	Integer page
	byte[] logo    //logo for book
	
	static belongsTo = [manga:Manga]
	static mapping = {
		logo column: "logo" , sqlType: "LONGBLOB"
	}
	
    static constraints = {
    }
}
