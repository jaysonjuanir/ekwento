package com.mmm.ekwento

import org.apache.commons.lang.builder.HashCodeBuilder

class UserAccountUserGroup implements Serializable {

	private static final long serialVersionUID = 1

	UserAccount userAccount
	UserGroup userGroup

	boolean equals(other) {
		if (!(other instanceof UserAccountUserGroup)) {
			return false
		}

		other.userAccount?.id == userAccount?.id &&
		other.userGroup?.id == userGroup?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (userAccount) builder.append(userAccount.id)
		if (userGroup) builder.append(userGroup.id)
		builder.toHashCode()
	}

	static UserAccountUserGroup get(long userAccountId, long userGroupId) {
		UserAccountUserGroup.where {
			userAccount == UserAccount.load(userAccountId) &&
			userGroup == UserGroup.load(userGroupId)
		}.get()
	}

	static boolean exists(long userAccountId, long userGroupId) {
		UserAccountUserGroup.where {
			userAccount == UserAccount.load(userAccountId) &&
			userGroup == UserGroup.load(userGroupId)
		}.count() > 0
	}

	static UserAccountUserGroup create(UserAccount userAccount, UserGroup userGroup, boolean flush = false) {
		def instance = new UserAccountUserGroup(userAccount: userAccount, userGroup: userGroup)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(UserAccount u, UserGroup g, boolean flush = false) {
		if (u == null || g == null) return false

		int rowCount = UserAccountUserGroup.where {
			userAccount == UserAccount.load(u.id) &&
			userGroup == UserGroup.load(g.id)
		}.deleteAll()

		if (flush) { UserAccountUserGroup.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(UserAccount u, boolean flush = false) {
		if (u == null) return

		UserAccountUserGroup.where {
			userAccount == UserAccount.load(u.id)
		}.deleteAll()

		if (flush) { UserAccountUserGroup.withSession { it.flush() } }
	}

	static void removeAll(UserGroup g, boolean flush = false) {
		if (g == null) return

		UserAccountUserGroup.where {
			userGroup == UserGroup.load(g.id)
		}.deleteAll()

		if (flush) { UserAccountUserGroup.withSession { it.flush() } }
	}

	static constraints = {
		userAccount validator: { UserAccount u, UserAccountUserGroup ug ->
			if (ug.userGroup == null) return
			boolean existing = false
			UserAccountUserGroup.withNewSession {
				existing = UserAccountUserGroup.exists(u.id, ug.userGroup.id)
			}
			if (existing) {
				return 'userGroup.exists'
			}
		}
	}

	static mapping = {
		id composite: ['userGroup', 'userAccount']
		version false
	}
}
