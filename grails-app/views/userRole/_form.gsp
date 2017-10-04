<%@ page import="com.mmm.ekwento.UserRole" %>



<div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'authority', 'error')} required">
	<label for="authority">
		<g:message code="userRole.authority.label" default="Authority" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="authority" required="" value="${userRoleInstance?.authority}"/>

</div>

