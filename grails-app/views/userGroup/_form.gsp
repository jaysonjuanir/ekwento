<%@ page import="com.mmm.ekwento.UserGroup" %>



<div class="fieldcontain ${hasErrors(bean: userGroupInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="userGroup.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${userGroupInstance?.name}"/>

</div>

