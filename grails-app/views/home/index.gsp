<!DOCTYPE html>

<%@ page import="com.mmm.ekwento.UserAccount" %>
<%@ page import="com.mmm.ekwento.Book" %>
<%@ page import="com.mmm.ekwento.Article" %>
<%@ page import="com.mmm.ekwento.Manga" %>

<html>
    <head>
        <title>e-Kwento - MMM</title>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name='layout' content='main' />
		<g:set var="userObject" value="${UserAccount.findByUsername(sec.loggedInUserInfo(field:'username'))}"/>
		<style>
			.popover-content{
				color:#000;
			}
			ul li div{
				color:#000;
				font-size:1.5em;
			}
		</style>

		<script>
			$(document).ready(function(){
			$('[data-toggle="popover"]').popover();
			});
		</script>
    </head>

    <body id="page-top">
                <!-- HEADER -->
			<g:if test="${flash.warning || flash.message || flash.success || flash.error}">
				<div class="span7">
					<g:if test="${flash.message}">
						<div class="alert alert-info" role="status">
							<strong>
								${flash.message}
							</strong>
						</div>
					</g:if>
					<g:if test="${flash.success}">
						<div class="alert alert-success" role="status">
							<strong>
								${flash.success}
							</strong>
						</div>
					</g:if>
					<g:if test="${flash.error}">
						<div class="alert alert-error" role="status">
							<strong>
								${flash.error}
							</strong>
						</div>
					</g:if>
					<g:if test="${flash.warning}">
						<div class="alert alert-warning" role="status">
							<strong>
								${flash.warning}
							</strong>
						</div>
					</g:if>
				</div>
			</g:if>
			
			<sec:ifNotLoggedIn>
            <div class="container cont" style="margin-bottom: 1.5em;">
                <div class="registration" style="float:left;">
                    <h3 class="text-center">New in eKwento? Sign up here!</h3>
                    <g:form class="form-horizontal" action="register" controller="userAccount">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="regFirstName" placeholder="First Name">
                                </div>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="regLastName" placeholder="Last Name">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-6">
                                    <input type="email" class="form-control" name="regEmail" placeholder="Email">
                                </div>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="regUsername" placeholder="Username">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-6">
                                    <input type="password" class="form-control" name="regPassword" placeholder="Password">
                                </div>
                                <div class="col-sm-6">
                                    <input type="password" class="form-control" name="regConfirmPassword" placeholder="Confirm Password">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="bookLogo" style="color : black;">Birthdate:</label>
                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <div class="form-group">
                                            <g:datePicker class="form-control" name="regBirthdate" value="${new Date()}" precision="day" years="${1970..2017}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-horizontal">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label class="col-xs-12 col-sm-6 col-md-8">
                                        <input class="reg-inline" required type="checkbox" data-toggle="popover" data-placement="bottom" title="By Checking this" data-content="Term and Termination

This Agreement shall remain in effect until terminated by you or My Company (change this). 

My Company (change this) may, in its sole discretion, at any time and for any or no reason, suspend or terminate this Agreement with or without prior notice.

This Agreement will terminate immediately, without prior notice from My Company (change this), in the event that you fail to comply with any provision of this Agreement. You may also terminate this Agreement by deleting the Application and all copies thereof from your mobile device or from your desktop.

Upon termination of this Agreement, you shall cease all use of the Application and delete all copies of the Application from your mobile device or from your desktop.

Severability

If any provision of this Agreement is held to be unenforceable or invalid, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect.

Amendments to this Agreement

My Company (change this) reserves the right, at its sole discretion, to modify or replace this Agreement at any time. If a revision is material we will provide at least 30 (changes this) days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.

Contact Information

If you have any questions about this Agreement, please contact us.
"> By Checking this will also agree on license of terms provided by eKwento.
                                    </label>
                                    <div class="col-xs-6 col-sm-4">
                                        <button type="submit" class="btn btn-default reg-inline">Sign in</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">

                        </div>
                    </g:form>
                </div>
                <div class="splash-image-registration">
                    <a data-scroll class="pull-left header-link" href="#page-top">
                        <img class="img-responsive" alt="Responsive image" src="${resource(dir: 'images', file: 'books-library.jpg')}" >
                    </a>
                </div>
            </div>
			</sec:ifNotLoggedIn>
			
			<sec:ifLoggedIn>
            <div class="container cont" style="margin-bottom: 1.5em;">
                <div class="registration" style="float:left;">
                    <h3 class="text-center"> Welcome ${userObject.firstName} ${userObject.lastName} | <sec:username/></h3>
                    
                </div>
                <div class="splash-image-registration">
                    <a data-scroll class="pull-left header-link" href="#page-top">
                        <img class="img-responsive" alt="Responsive image" src="${resource(dir: 'images', file: 'books-library.jpg')}" >
                    </a>
                </div>
            </div>
			</sec:ifLoggedIn>

        <section id="bulletin" class="hris-section">
            <div class="container bookSection" id="offset-top">
                <div class="leftSidePanel" id="offset-top">
                    <div class="leftSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Latest Uploads</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="latestUploads" controller="home">Read More</g:link>

                        <div>
                            <ul id="Grid">
								
								<%--<g:each var="book" in="${Book.list(max: 4, sort: "dateCreated", order: "desc")}">--%>
								<g:each var="globalLatest" in="${globalLatestUploadList}">
									<li>
										<g:if test="${globalLatest.type == 'book'}">
											<g:if test="${globalLatest.logo}">
												<g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="book" id="${globalLatest.id}"><img src="${createLink (controller:'book' , action:'renderImage' , id:globalLatest.id)}" alt="bookLogo" height="140" width="140"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="book" id="${globalLatest.id}"><g:img dir="images" file="ek.png" width="140" height="140"/></g:link>
											</g:else>
											<g:if test="${globalLatest.title.size() >=12}">
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="book" id="${globalLatest.id}">${globalLatest.title.substring(0,10)}.....</g:link></div>
											</g:if>
											<g:else>
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="book" id="${globalLatest.id}">${globalLatest.title}</g:link></div>
											</g:else>
										</g:if>
										<g:elseif test="${globalLatest.type == 'article'}">
											<g:if test="${globalLatest.logo}">
												<g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="article" id="${globalLatest.id}"><img src="${createLink (controller:'article' , action:'renderImage' , id:globalLatest.id)}" alt="articleLogo" height="140" width="140"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="article" id="${globalLatest.id}"><g:img dir="images" file="ek.png" width="140" height="140"/></g:link>
											</g:else>
											<g:if test="${globalLatest.title.size() >=12}">
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="article" id="${globalLatest.id}">${globalLatest.title.substring(0,10)}.....</g:link></div>
											</g:if>
											<g:else>
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="article" id="${globalLatest.id}">${globalLatest.title}</g:link></div>
											</g:else>
										</g:elseif>
										<g:elseif test="${globalLatest.type == 'manga'}">
											<g:if test="${globalLatest.logo}">
												<g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="manga" id="${globalLatest.id}"><img src="${createLink (controller:'manga' , action:'renderImage' , id:globalLatest.id)}" alt="mangaLogo" height="140" width="140"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="manga" id="${globalLatest.id}"><g:img dir="images" file="ek.png" width="140" height="140"/></g:link>
											</g:else>
											<g:if test="${globalLatest.title.size() >=12}">
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="manga" id="${globalLatest.id}">${globalLatest.title.substring(0,10)}.....</g:link></div>
											</g:if>
											<g:else>
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalLatest.title} - ${globalLatest.description}" action="show" controller="manga" id="${globalLatest.id}">${globalLatest.title}</g:link></div>
											</g:else>
										</g:elseif>
									</li>
								</g:each>
                                
                            </ul>
                        </div>
                    </div>

                    <div class="leftSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Popular Books</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="popularUploads" controller="home">Read More</g:link>

                        <div>
                            <ul id="Grid">
								<g:each var="globalPopular" in="${globalPopularUploadList}">
									<li>
										<g:if test="${globalPopular.type == 'book'}">
											<g:if test="${globalPopular.logo}">
												<g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="book" id="${globalPopular.id}"><img src="${createLink (controller:'book' , action:'renderImage' , id:globalPopular.id)}" alt="bookLogo" height="140" width="140"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="book" id="${globalPopular.id}"><g:img dir="images" file="ek.png" width="140" height="140"/></g:link>
											</g:else>
											<g:if test="${globalPopular.title.size() >=12}">
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="book" id="${globalPopular.id}">${globalPopular.title.substring(0,10)}.....</g:link></div>
											</g:if>
											<g:else>
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="book" id="${globalPopular.id}">${globalPopular.title}</g:link></div>
											</g:else>
										</g:if>
										<g:elseif test="${globalPopular.type == 'article'}">
											<g:if test="${globalPopular.logo}">
												<g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="article" id="${globalPopular.id}"><img src="${createLink (controller:'article' , action:'renderImage' , id:globalPopular.id)}" alt="articleLogo" height="140" width="140"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="article" id="${globalPopular.id}"><g:img dir="images" file="ek.png" width="140" height="140"/></g:link>
											</g:else>
											<g:if test="${globalPopular.title.size() >=12}">
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="article" id="${globalPopular.id}">${globalPopular.title.substring(0,10)}.....</g:link></div>
											</g:if>
											<g:else>
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="article" id="${globalPopular.id}">${globalPopular.title}</g:link></div>
											</g:else>
										</g:elseif>
										<g:elseif test="${globalPopular.type == 'manga'}">
											<g:if test="${globalPopular.logo}">
												<g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="manga" id="${globalPopular.id}"><img src="${createLink (controller:'manga' , action:'renderImage' , id:globalPopular.id)}" alt="mangaLogo" height="140" width="140"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="manga" id="${globalPopular.id}"><g:img dir="images" file="ek.png" width="140" height="140"/></g:link>
											</g:else>
											<g:if test="${globalPopular.title.size() >=12}">
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="manga" id="${globalPopular.id}">${globalPopular.title.substring(0,10)}.....</g:link></div>
											</g:if>
											<g:else>
												<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${globalPopular.title} - ${globalPopular.description}" action="show" controller="manga" id="${globalPopular.id}">${globalPopular.title}</g:link></div>
											</g:else>
										</g:elseif>
									</li>
								</g:each>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="rightSidePanel" id="offset-top">
                    <div class="rightSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Articles</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="index" controller="article">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <g:each var="article" in="${Article.findAllByApprovedAndRejected(true, false, [max: 4, sort: "dateCreated", order: "desc"])}">
									<li>
										<g:if test="${article.logo}">
											<g:link title="${article.title} - ${article.description}" action="show" controller="article" id="${article.id}"><img src="${createLink (controller:'article' , action:'renderImage' , id:article.id)}" alt="articleLogo" height="75" width="75"/></g:link>
										</g:if>
										<g:else>
											<g:link title="${article.title} - ${article.description}" action="show" controller="article" id="${article.id}"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
										</g:else>
										<g:if test="${article.title.size() >=7}">
											<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${article.title} - ${article.description}" action="show" controller="article" id="${article.id}">${article.title.substring(0,5)}.....</g:link></div>
										</g:if>
										<g:else>
											<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${article.title} - ${article.description}" action="show" controller="article" id="${article.id}">${article.title}</g:link></div>
										</g:else>
									</li>
								</g:each>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="rightSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Manga</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="show" id="1">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <g:each var="manga" in="${Manga.findAllByApprovedAndRejected(true, false, [max: 4, sort: "dateCreated", order: "desc"])}">
									<li>
										<g:if test="${manga.logo}">
											<g:link title="${manga.title} - ${manga.description}" action="show" controller="manga" id="${manga.id}"><img src="${createLink (controller:'manga' , action:'renderImage' , id:manga.id)}" alt="mangaLogo" height="75" width="75"/></g:link>
										</g:if>
										<g:else>
											<g:link title="${manga.title} - ${manga.description}" action="show" controller="manga" id="${manga.id}"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
										</g:else>
										<g:if test="${manga.title.size() >=7}">
											<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${manga.title} - ${manga.description}" action="show" controller="manga" id="${manga.id}">${manga.title.substring(0,4)}.....</g:link></div>
										</g:if>
										<g:else>
											<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${manga.title} - ${manga.description}" action="show" controller="manga" id="${manga.id}">${manga.title}</g:link></div>
										</g:else>
									</li>
								</g:each>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="rightSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Books</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="index" controller="book">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <g:each var="book" in="${Book.findAllByApprovedAndRejected(true, false, [max: 4, sort: "dateCreated", order: "desc"])}">
									<li>
										<g:if test="${book.logo}">
											<g:link title="${book.title} - ${book.description}" action="show" controller="book" id="${book.id}"><img src="${createLink (controller:'book' , action:'renderImage' , id:book.id)}" alt="bookLogo" height="75" width="75"/></g:link>
										</g:if>
										<g:else>
											<g:link title="${book.title} - ${book.description}" action="show" controller="book" id="${book.id}"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
										</g:else>
										<g:if test="${book.title.size() >=7}">
											<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${book.title} - ${book.description}" action="show" controller="book" id="${book.id}">${book.title.substring(0,4)}.....</g:link></div>
										</g:if>
										<g:else>
											<div style="padding:1em;font-size: 16px;font-size: 0.75em;"><g:link title="${book.title} - ${book.description}" action="show" controller="book" id="${book.id}">${book.title}</g:link></div>
										</g:else>
									</li>
								</g:each>
                            </ul>
                        </div>
                    </div>
                </div>

                
                <div class="clearfix"></div>
            </div>
        </section>
        
        <g:render template="/layouts/footer"/>


        <footer id="footer">
        </footer>
    </body>
</html>