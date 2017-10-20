package com.mmm.ekwento

class UserAccount {

    transient springSecurityService

    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    
    String firstName
    String lastName
    String email
    String token
	Integer numberOfFollowers=0
    
    Date birthdate //viewing content below 18
    String contact
	
	static hasMany = [userFollowing:Follower]
	static mappedBy = [userFollowing: 'userFollowing']

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        firstName(nullable:false,blank:false, minSize:1, maxSize:255, matches:"[0-9, a-z, A-Z, \\,, \\-, /, ., \\s]+")
        lastName(nullable:false,blank:false, minSize:1, maxSize:255, matches:"[0-9, a-z, A-Z, \\,, \\-, /, ., \\s]+")
        email(nullable:false,blank:false,email:true, minSize:1, maxSize:255)
        token(blank:true)
        contact(blank:true, nullable:true)
        userFollowing( nullable:true)
        birthdate(nullable:true, blank:true)
    }

    static mapping = {
        password column: '`password`'
    }
    
    String toString() {
        firstName + " " + lastName
    }

    Set<UserGroup> getAuthorities() {
        UserAccountUserGroup.findAllByUserAccount(this).collect { it.userGroup }
    }
	
    Set<UserGroup> getUserAccountGroups() {
        UserAccountUserGroup.findAllByUserAccount(this).collect{ it.userGroup } as Set
    }
	
    //added parts
    Set<UserRole> getRoles() {
        UserAccountUserRole.findAllByUserAccount(this).collect { it.role } as Set
    }
    
    
    def beforeInsert() {    //before inserting to database, make all necessary string variable to all caps
        		                                               
    }  

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }	
    }

    protected void encodePassword() {
        //password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
        password = springSecurityService.encodePassword(password)
    }
}
