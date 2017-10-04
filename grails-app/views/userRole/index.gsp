
<%@ page import="com.mmm.ekwento.UserRole" %>
<!DOCTYPE html>
<html>
    <head>
            <meta name="layout" content="main">
            <g:set var="entityName" value="${message(code: 'userRole.label', default: 'UserRole')}" />
            <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body id="page-top">
        <!-- HEADER -->
        <section id="home-top" >
                <g:render template="roleEdit"/>
        </section>

        <g:render template="/layouts/footer"/>
    </body>
</html>
