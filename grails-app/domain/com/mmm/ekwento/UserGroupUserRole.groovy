package com.mmm.ekwento

import org.apache.commons.lang.builder.HashCodeBuilder

class UserGroupUserRole implements Serializable {

	private static final long serialVersionUID = 1

	UserGroup userGroup
	UserRole userRole

	boolean equals(other) {
		if (!(other instanceof UserGroupUserRole)) {
			return false
		}

		other.userRole?.id == userRole?.id &&
		other.userGroup?.id == userGroup?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (userGroup) builder.append(userGroup.id)
		if (userRole) builder.append(userRole.id)
		builder.toHashCode()
	}

	static UserGroupUserRole get(long userGroupId, long userRoleId) {
		UserGroupUserRole.where {
			userGroup == UserGroup.load(userGroupId) &&
			userRole == UserRole.load(userRoleId)
		}.get()
	}

	static boolean exists(long userGroupId, long userRoleId) {
		UserGroupUserRole.where {
			userGroup == UserGroup.load(userGroupId) &&
			userRole == UserRole.load(userRoleId)
		}.count() > 0
	}

	static UserGroupUserRole create(UserGroup userGroup, UserRole userRole, boolean flush = false) {
		def instance = new UserGroupUserRole(userGroup: userGroup, userRole: userRole)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(UserGroup rg, UserRole r, boolean flush = false) {
		if (rg == null || r == null) return false

		int rowCount = UserGroupUserRole.where {
			userGroup == UserGroup.load(rg.id) &&
			userRole == UserRole.load(r.id)
		}.deleteAll()

		if (flush) { UserGroupUserRole.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(UserRole r, boolean flush = false) {
		if (r == null) return

		UserGroupUserRole.where {
			userRole == UserRole.load(r.id)
		}.deleteAll()

		if (flush) { UserGroupUserRole.withSession { it.flush() } }
	}

	static void removeAll(UserGroup rg, boolean flush = false) {
		if (rg == null) return

		UserGroupUserRole.where {
			userGroup == UserGroup.load(rg.id)
		}.deleteAll()

		if (flush) { UserGroupUserRole.withSession { it.flush() } }
	}

	static constraints = {
		userRole validator: { UserRole r, UserGroupUserRole rg ->
			if (rg.userGroup == null) return
			boolean existing = false
			UserGroupUserRole.withNewSession {
				existing = UserGroupUserRole.exists(rg.userGroup.id, r.id)
			}
			if (existing) {
				return 'roleGroup.exists'
			}
		}
	}

	static mapping = {
		id composite: ['userGroup', 'userRole']
		version false
	}
}
