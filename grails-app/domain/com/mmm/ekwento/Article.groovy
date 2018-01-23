package com.mmm.ekwento

class Article {

    String title
    String description
    String content
    String reasonForReject
    Date dateCreated
    Date dateUpdated
    Integer numberOfViews = 0
    UserAccount createdBy
    
    Boolean approved = false  //admin approved
    Boolean rejected = false  //admin rejected
    byte[] logo    //logo for book
	
	static hasMany = [genres:Genre]
    
    static mapping = {
        content type: 'text'
        logo column: "logo" , sqlType: "LONGBLOB"
		genres joinTable: [name: "article_genres", column: "genre_id", key: 'article_id' ]
    }
    
    static constraints = {
        title nullable:false
        content nullable:false
		reasonForReject nullable:true
        dateUpdated nullable:true
        logo(nullable:true)
    }
	String toString(){
		return "${title} by ${createdBy}"
	}
}
