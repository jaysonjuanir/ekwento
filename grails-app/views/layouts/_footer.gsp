<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page import="com.mmm.ekwento.Book" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<section id="footer" class="hris-section">
    <div class="container" id="offset-top">
        <div class="rowFooter">
            <h3>Recent Stories</h3>
			<g:each var="book" in="${Book.findAllByApprovedAndRejected(true, false, [max: 3, sort: "dateCreated", order: "desc"])}">
				<g:link action="show" controller="book" id="${book.id}">${book.title}</g:link>
				<br/>
			</g:each>
        </div>
        <div class="rowFooter">
            <h3>Trending Stories</h3>
            <g:each var="book" in="${Book.findAllByApprovedAndRejected(true, false, [max: 3, sort: "numberOfViews", order: "desc"])}">
				<g:link action="show" controller="book" id="${book.id}">${book.title}</g:link>
				<br/>
			</g:each>
        </div>
        <div class="rowFooter">
            <h3>Trending Authors</h3>
			<%-- <g:each var="author" in="${UserAccount.list(max: 3, sort: "numberOfFollowers", order: "desc")}">
				<g:link action="show" controller="profile" id="${author.id}">${author.firstName} ${author.lastName}</g:link>
				<br/>
			</g:each> --%>
            <g:link action="auth" controller="login">Mica</g:link>
            <br/>
            <g:link action="auth" controller="login">John Michael</g:link>
            <br/>
            <g:link action="auth" controller="login">Maxine</g:link>
        </div>
        <div class="rowFooter">
            <h3>Contact Us</h3>
            <a href="https://twitter.com/minimalmonkey" class="icon-button twitter"><i id="twitter-hover">t</i><span></span></a>
            <a href="https://www.facebook.com/E-Kwento-A-Web-based-and-Mobile-Application-1504561822997621/" class="icon-button facebook"><i id="fb-hover">f</i><span></span></a>
            <a href="https://plus.google.com/u/1/114882348674497438322" class="icon-button google-plus"><i id="gmail-hover">g</i><span></span></a>
        </div>
<!--        <div class="row">
            <small class="pull-right">Karaoke Avenue. Sing your feelings &copy; 2016</small>
            <small class="pull-left">
                <span class="glyphicon glyphicon-envelope"></span>
                <a href="http://plv.edu.ph/" target="_blank">Pamantasan ng Lungsod ng Valenzuela</a>
                <span>&nbsp;&bull;&nbsp;</span>
                <g:if test="${session.level}">
                    <a href="#" data-toggle="modal" data-target="#changeUserModal">Change password</a>
                </g:if>
            </small>
            <small class="pull-left">

            </small>
        </div>-->
    </div>
</section>
<g:if test="${session.level}">
<div id="changeUserModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
<!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Change Password</h4>
            </div>
            <div class="modal-body">
                    <!--modal body-->
                <div class="modal-body">
                    <g:form action="changePass" name="changeUser">
                        <div class="form-group">
                            <g:passwordField class="form-control " name="oldPass" placeholder="Enter Old Password" required=""/>
                        </div>
                        <div class="form-group">
                            <g:passwordField class="form-control " name="newPass" placeholder="Enter New Password" required=""/>
                        </div>
                        <div class="form-group">
                            <g:passwordField class="form-control " name="newPass2" placeholder="Confirm New Password" required=""/>
                        </div>
                        <g:hiddenField name="id" value="${session['id']}"/>
                    </g:form>
                </div>
            </div>
            <div class="modal-footer">
                <button form="changeUser" type="submit" class="btn btn-warning btn-lg" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span>Submit</button>
            </div>
        </div>
    </div>
</div>
</g:if>

