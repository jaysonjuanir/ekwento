<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page import="com.mmm.ekwento.Genre" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Show Manga | e-Kwento</title>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name='layout' content='main' />

        <style>
            /* Note: Try to remove the following lines to see the effect of CSS positioning */
            .affix {
            top: 0;
            width: 100%;
            }

            .affix + .container-fluid {
            padding-top: 70px;
            }

			.mangaPage {
			margin: auto;
			width: 100%;
			border: 3px solid green;
			padding: 10px;
			}
        </style>

        <script type="text/javascript">
            $( document ).ready(function() {
            $('div.keepReading').click(function() {
            $(this).animate({
            opacity: 0
            });
            $(this).parent().find('.closeArticle').animate({
            opacity: 1
            });
            $(this).prev().slideDown();

            return false;
            });

            $('div.closeArticle').click(function() {
            $(this).animate({
            opacity: 0
            });
            $(this).parent().find('.keepReading').animate({
            opacity: 1
            });
            $(this).parent().find('article').slideUp();

            return false;
            });
            });
        </script>

    </head>
    <body id="page-top" class="container-fluid">

        <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="190" style="border:none;">
            <div class="container">
                <ul class="nav navbar-nav">
                    <sec:ifAnyGranted roles="ROLE_CREATE_BOOKS, ROLE_CREATE_ARITICLES, ROLE_CREATE_MANGA">
						<li class="dropdown active">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">Compose
								<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<sec:ifAnyGranted roles="ROLE_CREATE_BOOKS">
									<li><a href="#" data-toggle="modal" data-target="#composeBookModal">Book</a></li>
								</sec:ifAnyGranted>
								<sec:ifAnyGranted roles="ROLE_CREATE_ARITICLES">
									<li><a href="#" data-toggle="modal" data-target="#composeArticleModal">Article</a></li>
								</sec:ifAnyGranted>
								<sec:ifAnyGranted roles="ROLE_CREATE_MANGA">
									<li><a href="#" data-toggle="modal" data-target="#composeMangaModal">Manga</a></li>
								</sec:ifAnyGranted>
							</ul>
						</li>
					</sec:ifAnyGranted>
					<li class="active"><a href="#">Library</a></li>
                    <li class="active"><a href="#">Message</a></li>
                    <li class="active"><a href="#">Notification</a></li>
                </ul>

                <ul class="nav navbar-nav navbar-right ">
					<g:if test="${isOwned}">
						<li class="active"><a href="#" data-toggle="modal" data-target='#editModal'><span class="glyphicon glyphicon-pencil"></span>Edit</a></li>
						</g:if>
					<sec:ifAnyGranted roles="ROLE_ADMIN_DASHBOARD">
						<li class="active"><a href="#" data-toggle="modal" data-target="#approveModal">Approve</a></li>
						<li class="active"><a href="#" data-toggle="modal" data-target="#rejectModal">Reject</a></li>
					</sec:ifAnyGranted>
                    <li class="active"><a><span class="glyphicon glyphicon-eye-open"></span><span class="badge">${numberOfViews}</span> Views</a></li>
                </ul>
            </div>
        </nav>

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

		

		<div class="container bookSection" id="offset-top">
			<div class="container" style="width: 0px;padding:1em;margin-right: 100%;">
			<div class="dropdown">
				<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Turn to Page
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<g:each var="pageNumber" in="${ (1..< (mangaMaxPage+1) )}">
						<li><g:link controller="manga" action="show" id="${mangaInstance.id}" params="[page: pageNumber]">${pageNumber}</g:link></li>
					</g:each>
				</ul>
			</div>
			
			
		</div>
			<h2>${mangaInstance.title}</h2>
			<h4>${mangaInstance.description}</h4>
			<h4>Uploaded by ${mangaInstance.createdBy}</h4>
			<h4><g:formatDate format="MM-dd-yyyy" date="${mangaInstance.dateCreated}"/></div> </h4>
			
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
<!-- Indicators -->

  <!-- Wrapper for slides -->
				<div class="carousel-inner">
					<div class="item active">
						<img src="${createLink (controller:'manga' , action:'renderImagePage' , id:mangaPageId)}" alt="mangaPage" class="mangaPage" align="middle"/>
					</div>
				</div>

  <!-- Left and right controls -->
				<g:if test="${Integer.valueOf(params.page) != 1}">
					<g:link controller="manga" action="show" id="${mangaInstance.id}" params="[page: (Integer.valueOf(params.page)-1)]" class="left carousel-control" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
						<span class="sr-only">Previous</span>
					</g:link>
				</g:if>
				<g:if test="${Integer.valueOf(params.page) != mangaMaxPage}">
					<g:link controller="manga" action="show" id="${mangaInstance.id}" params="[page: (Integer.valueOf(params.page)+1)]" class="right carousel-control" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
						<span class="sr-only">Next</span>
					</g:link>
				</g:if>
			</div>


			<div class="clearfix"></div>
		</div>

		<g:render template="/layouts/footer"/>

		<div id="composeBookModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Create new Book</h4>
                    </div>
                    <div class="modal-body">
                        <g:form action="create" method="post" name="create" controller="book" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="email" style="color : black;">Title:</label>
                                <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                                <input type="text" class="form-control" name="bookTitle" id="bookTitle" placeholder="Title" required/>
                            </div>
                            <div class="form-group">
                                <label for="email" style="color : black;">Description:</label>
                                <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                                <input type="text" class="form-control" name="bookDescription" id="bookDescription" placeholder="Description" required/>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="bookContent" style="color : black;">Upload text file:</label>
                                    <input type="file" class="form-control" name="fileContent" accept=".txt"/>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="bookLogo" style="color : black;">Upload logo:</label>
                                    <input type="file" class="form-control" name="bookLogo" accept=".gif,.jpg,.jpeg,.png,"/>
                                </div>
                            </div>
                            <g:each var="genre" in="${Genre.list(sort: "type", order: "asc")}">
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="genres" style="color : black;">
                                            <g:checkBox name="genres" value="${genre.id}" /> ${genre.type}
                                            <br/>

                                        </label>
                                    </div>
                                </div>
                            </g:each>

    <%--<g:actionSubmit action="login" value="Submit" class="btn btn-success"/>--%>
                            <input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>
                        </g:form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

		<div id="composeArticleModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Create new Article</h4>
					</div>
					<div class="modal-body">
						<g:form action="create" method="post" name="create" controller="article" enctype="multipart/form-data">
							<div class="form-group">
								<label for="articleTitle" style="color : black;">Title:</label>
								<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
								<input type="text" class="form-control" name="articleTitle" id="articleTitle" placeholder="Title" required/>
							</div>
							<div class="form-group">
								<label for="articleDescription" style="color : black;">Description:</label>
								<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
								<input type="text" class="form-control" name="articleDescription" id="articleDescription" placeholder="Description" required/>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="fileContent" style="color : black;">Upload text file:</label>
									<input type="file" class="form-control" name="fileContent"/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="articleLogo" style="color : black;">Upload logo:</label>
									<input type="file" class="form-control" name="articleLogo" accept=".gif,.jpg,.jpeg,.png,"/>
								</div>
							</div>
							<g:each var="genre" in="${Genre.list(sort: "type", order: "asc")}">
								<div class="col-lg-3">
									<div class="form-group">
										<label for="genres" style="color : black;">
											<g:checkBox name="genres" value="${genre.id}" /> ${genre.type}
											<br/>

										</label>
									</div>
								</div>
							</g:each>
						<%--<g:actionSubmit action="login" value="Submit" class="btn btn-success"/>--%>
							<input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>
						</g:form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<div id="composeMangaModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Create new Manga</h4>
					</div>
					<div class="modal-body">
						<g:form action="create" method="post" name="create" controller="manga" enctype="multipart/form-data">

							<div class="form-group">
								<label for="mangaTitle" style="color : black;">Title:</label>
								<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
								<input type="text" class="form-control" name="mangaTitle" id="articleTitle" placeholder="Title" required/>
							</div>
							<div class="form-group">
								<label for="mangaDescription" style="color : black;">Description:</label>
								<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
								<input type="text" class="form-control" name="mangaDescription" id="articleDescription" placeholder="Description" required/>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="mangaLogo" style="color : black;">Upload logo file:</label>
									<input type="file" class="form-control" name="mangaLogo" accept=".gif,.jpg,.jpeg,.png,"/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="mangaContent" style="color : black;">Upload Content Image files:</label>
									<input type="file" class="form-control" name="mangaContent" accept=".gif,.jpg,.jpeg,.png" multiple/>
								</div>
							</div>
                            <g:each var="genre" in="${Genre.list(sort: "type", order: "asc")}">
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="genres" style="color : black;">
                                            <g:checkBox name="genres" value="${genre.id}" /> ${genre.type}
                                            <br/>

                                        </label>
                                    </div>
                                </div>
                            </g:each>
						<%--<g:actionSubmit action="login" value="Submit" class="btn btn-success"/>--%>
							<input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>
						</g:form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>



		<%--<div id="editModal" class="modal fade" role="dialog">
			<div class="modal-dialog" style="width: 75%;">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Create new Manga</h4>
					</div>
					<div class="modal-body">
						<g:form action="update" method="post" name="update" controller="manga" enctype="multipart/form-data">
							<div class="col-lg-12">
								<div class="form-group">
									<label for="mangaLogo" style="color : black;">Update Logo:</label>
									<input type="file" class="form-control" name="mangaLogo" accept=".gif,.jpg,.jpeg,.png,"/>
								</div>
							</div>
							<div class="form-group">
								<label for="email" style="color : black;">Title:</label>
								<input type="text" class="form-control" name="mangaTitle" id="mangaTitle" placeholder="Title" value="${title}" required/>
							</div>
							<div class="form-group">
								<label for="email" style="color : black;">Description:</label>
								<input type="text" class="form-control" name="mangaDescription" id="mangaDescription" placeholder="Description" value="${description}" required/>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="mangaContent" style="color : black;">Upload text file:</label>
									<g:textArea class="form-control" name="content" value="${mangaInstance.content}" rows="10" cols="100"/>
								</div>
							</div>
							<g:each var="genre" in="${Genre.list(sort: "type", order: "asc")}">
								<div class="col-lg-3">
									<div class="form-group">
										<label for="genres" style="color : black;">
											<g:checkBox name="genres" value="${genre.id}" /> ${genre.type}
											<br/>

										</label>
									</div>
								</div>
							</g:each>
							<input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>

							<g:hiddenField name="id" value="${mangaInstance.id}" />
						</g:form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>--%>


		<div id="approveModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
			<div class="modal-dialog">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Approve this manga?</h4>
					</div>
					<div class="modal-body">
						<g:link controller="home" action="updateApproveAdminManga" class="btn btn-success" id="${mangaInstance.id}" params="${params<<[listId:1]}">Yes</g:link>
							<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
						</div>
						<div class="modal-footer">

					</div>
				</div>
			</div>
		</div>

		<div id="rejectModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
			<div class="modal-dialog">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Reject this manga?</h4>
					</div>
					<div class="modal-body">
						<g:link controller="home" action="updateRejectAdminManga" class="btn btn-success" id="${mangaInstance.id}" params="${params<<[listId:1]}">Yes</g:link>
							<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
						</div>
						<div class="modal-footer">

					</div>
				</div>
			</div>
		</div>


		<div id="mustLoginModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
			<div class="modal-dialog">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">You need to be logged in to read this manga</h4>
					</div>
					<div class="modal-body">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Okay</button>
					</div>
					<div class="modal-footer">

					</div>
				</div>
			</div>
		</div>

	</body>
</html>
