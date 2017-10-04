package com.mmm.ekwento

import org.apache.commons.lang.builder.HashCodeBuilder

class UserAccountUserRole implements Serializable {

	private static final long serialVersionUID = 1

	UserAccount userAccount
	UserRole userRole

	boolean equals(other) {
		if (!(other instanceof UserAccountUserRole)) {
			return false
		}

		other.userAccount?.id == userAccount?.id &&
		other.userRole?.id == userRole?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (userAccount) builder.append(userAccount.id)
		if (userRole) builder.append(userRole.id)
		builder.toHashCode()
	}

	static UserAccountUserRole get(long userAccountId, long userRoleId) {
		UserAccountUserRole.where {
			userAccount == UserAccount.load(userAccountId) &&
			userRole == UserRole.load(userRoleId)
		}.get()
	}

	static boolean exists(long userAccountId, long userRoleId) {
		UserAccountUserRole.where {
			userAccount == UserAccount.load(userAccountId) &&
			userRole == UserRole.load(userRoleId)
		}.count() > 0
	}

	static UserAccountUserRole create(UserAccount userAccount, UserRole userRole, boolean flush = false) {
		def instance = new UserAccountUserRole(userAccount: userAccount, userRole: userRole)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(UserAccount u, UserRole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = UserAccountUserRole.where {
			userAccount == UserAccount.load(u.id) &&
			userRole == UserRole.load(r.id)
		}.deleteAll()

		if (flush) { UserAccountUserRole.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(UserAccount u, boolean flush = false) {
		if (u == null) return

		UserAccountUserRole.where {
			userAccount == UserAccount.load(u.id)
		}.deleteAll()

		if (flush) { UserAccountUserRole.withSession { it.flush() } }
	}

	static void removeAll(UserRole r, boolean flush = false) {
		if (r == null) return

		UserAccountUserRole.where {
			userRole == UserRole.load(r.id)
		}.deleteAll()

		if (flush) { UserAccountUserRole.withSession { it.flush() } }
	}

	static constraints = {
		userRole validator: { UserRole r, UserAccountUserRole ur ->
			if (ur.userAccount == null) return
			boolean existing = false
			UserAccountUserRole.withNewSession {
				existing = UserAccountUserRole.exists(ur.userAccount.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['userRole', 'userAccount']
		version false
	}
}
