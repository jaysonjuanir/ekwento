package com.mmm.ekwento

class UserGroup {

	String name

	static mapping = {
		cache true
	}

	Set<UserRole> getAuthorities() {
		UserGroupUserRole.findAllByUserGroup(this).collect { it.userRole }
	}

	static constraints = {
		name blank: false, unique: true
	}
}
