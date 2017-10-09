package com.mmm.ekwento

class Article {

    String title
    String description
    String content
    Date dateCreated
    Date dateUpdated
    Integer numberOfViews = 0
    UserAccount createdBy
    
    static mapping = {
        content type: 'text'
    }
    
    static constraints = {
        title nullable:false
        content nullable:false
        dateUpdated nullable:true
    }
}
