package com.mmm.ekwento

class Book {

    String title
    String description
    String content
    Date dateCreated
    Date dateUpdated
    Integer numberOfViews = 0
    UserAccount createdBy
    
    Boolean approved = false  //admin approved
    byte[] logo    //logo for book
    
	static hasMany = [genres:Genre]
	
    static mapping = {
        content type: 'text'
        logo column: "logo" , sqlType: "LONGBLOB"
		genres joinTable: [name: "book_genres", column: "genre_id", key: 'book_id' ]
    }
    
    static constraints = {
        title nullable:false
        content nullable:false
        dateUpdated nullable:true
        logo(nullable:true)
    }
}
