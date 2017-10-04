
<%@ page import="com.mmm.ekwento.UserAccount" %>
<!DOCTYPE html>
<html>
    <head>
            <meta name="layout" content="main">
            <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}" />
            <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body id="page-top">
        <!-- HEADER -->
        <section id="home-top" >
                <g:render template="userEdit"/>
        </section>

        <g:render template="/layouts/footer"/>
    </body>
</html>
