<%@ page import="com.mmm.ekwento.UserAccount" %>



<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="userAccount.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userAccountInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="userAccount.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userAccountInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="userAccount.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${userAccountInstance?.accountExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="userAccount.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${userAccountInstance?.accountLocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="userAccount.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${userAccountInstance?.enabled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="userAccount.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${userAccountInstance?.passwordExpired}" />

</div>

