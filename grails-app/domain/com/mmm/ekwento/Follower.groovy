package com.mmm.ekwento

class Follower {
	
	UserAccount userFollowed
	
	
	static belongsTo = [userFollowing:UserAccount]

    static constraints = {
    }
}
