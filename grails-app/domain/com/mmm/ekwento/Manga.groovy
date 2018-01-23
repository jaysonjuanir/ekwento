package com.mmm.ekwento

class Manga {
String title
    String description
    String reasonForReject
    Date dateCreated
    Date dateUpdated
    Integer numberOfViews = 0
    UserAccount createdBy
    
    Boolean approved = false  //admin approved
    Boolean rejected = false  //admin rejected
    byte[] logo    //logo for Manga
    
	static hasMany = [genres:Genre, contentPage:MangaPage]
	
    static mapping = {
        logo column: "logo" , sqlType: "LONGBLOB"
        contentPage column: "logo" , sqlType: "LONGBLOB"
		genres joinTable: [name: "book_genres", column: "genre_id", key: 'book_id' ]
    }
    
    static constraints = {
        title nullable:false
        contentPage nullable:true
        dateUpdated nullable:true
        reasonForReject nullable:true
        logo(nullable:true)
    }
	String toString(){
		return "${title} by ${createdBy}"
	}
}
