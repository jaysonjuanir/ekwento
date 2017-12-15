<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page import="com.mmm.ekwento.Genre" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Show Article | e-Kwento</title>
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

            p.sidebar{
            font-size: inherit;
            padding: 0;
            margin: 0;
            line-height: 15px;
            }


            .container {
            margin-left: auto;
            margin-right: auto;
            -moz-user-select: none;

            -webkit-user-select: none;

            user-select: none;
            }

            .story-line {
            position: fixed;
            top: 0;
            left: 0;
            width: 100px;
            height: 100vh;
            overflow: hidden;
            background-color: #333;
            }
            .story-line .story-line-container {
            position: relative;
            top: 50vh;
            -webkit-transform: translateY(0);
            transform: translateY(0);
            }
            .story-line .viewport {
            position: absolute;
            right: 0;
            top: 50%;
            width: 100%;
            height: 50px;
            background-color: #fff;
            }

            .story .bit {
            font-family: 'Source Serif Pro';
            line-height: 1.6;
            font-size: 18px;
            padding-left: 10px;
            padding-right: 10px;
            }
            .story-line .story .bit {
            font-size: 2.482758621px;
            color: #999;
            }
            .story-line .story .bit:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ccc;
            cursor: pointer;
            }

        </style>

        <script type="text/javascript">
            $(function() {
            //console.log( $('.container').height() );

            var docHeight = $(".container").height();
            var trayHeight = $(".story-line-container").height();
            var factor = docHeight / trayHeight;
            console.log(docHeight, trayHeight, factor);

            $(".viewport").height($(window).innerHeight() / factor);

            $(window).on("resize", function() {
            $(".viewport").height($(window).innerHeight() / factor);
            });

            $(window).on("scroll", function() {
            calcOffset(factor);
            });

            $(".story-line-container .bit").each(function() {
                $(this).on("click", function() {
                    var anchor = this.offsetTop * factor;
                        $("html, body").animate(
                        {
                        scrollTop: anchor
                        },
                        300
                        );
                        //console.log();
                    });
                });
            });

            function calcOffset(factor) {
            $(".story-line-container").css(
            "transform",
            "translateY(-" + $(window).scrollTop() / factor + "px)"
            );
            }


        </script>
        <script type="text/javascript">
            $( document ).ready(function() {
                //Disable cut copy paste
                $('body').bind('cut copy paste', function (e) {
                    e.preventDefault();
                });

                //Disable mouse right click
                $("body").on("contextmenu",function(e){
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


        <div class="container">
            <h1>${title}</h1>
            <h3>${description}</h3>
            <div class="author">By ${createdBy} | <g:formatDate format="MM-dd-yyyy" date="${dateCreated}"/></div> 
            <div class="story">
                <g:each var="sentence" in="${content}" status="i">
                    <g:if test="${i==1}">
                        <div class="bit seed">
                            <p>${sentence}</p>
                        </div>
                    </g:if>
                    <g:if test="${i!=1}">
                        <div class="bit">
                            <p>${sentence}</p>
                        </div>
                    </g:if>

                </g:each>
            </div>


<%--  lol --%>
            <div class="story-line">
                <div class="viewport" id="viewport">
                </div>

                <div class="story-line-container">


                    <div class="story">
                        <g:each var="sentence" in="${content}" status="i">
                            <g:if test="${i==1}">
                                <div class="bit seed">
                                    <p class="sidebar">${sentence}</p>
                                </div>
                            </g:if>
                            <g:if test="${i!=1}">
                                <div class="bit">
                                    <p class="sidebar">${sentence}</p>
                                </div>
                            </g:if>

                        </g:each>
                    </div>
                </div>
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
                            <div class="col-lg-12">
								<div class="form-group">
									<label for="email" style="color : black;">Title:</label>
									<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
									<input type="text" class="form-control" name="bookTitle" id="bookTitle" placeholder="Title" required/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="email" style="color : black;">Description:</label>
									<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
									<input type="text" class="form-control" name="bookDescription" id="bookDescription" placeholder="Description" required/>
								</div>
							</div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="bookContent" style="color : black;">Upload text file:</label>
                                    <input type="file" class="form-control" name="fileContent" accept=".txt"/>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="bookLogo" style="color : black;">Upload text file:</label>
                                    <input type="file" class="form-control" name="bookLogo" accept=".gif,.jpg,.jpeg,.png,"/>
                                </div>
                            </div>
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
							<div class="col-lg-12">
								<div class="form-group">
									<label for="email" style="color : black;">Title:</label>
									<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
									<input type="text" class="form-control" name="articleTitle" id="articleTitle" placeholder="Title" required/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="email" style="color : black;">Description:</label>
									<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
									<input type="text" class="form-control" name="articleDescription" id="articleDescription" placeholder="Description" required/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="articleContent" style="color : black;">Upload text file:</label>
									<input type="file" class="form-control" name="fileContent" accept=".txt"/>
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
											<g:checkBox name="genres" value="${genre.id}" checked='false'/> ${genre.type}
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
							
                            <div class="col-lg-12">
								<div class="form-group">
									<label for="email" style="color : black;">Title:</label>
									<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
									<input type="text" class="form-control" name="mangaTitle" id="mangaTitle" placeholder="Title" required/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="email" style="color : black;">Description:</label>
									<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
									<input type="text" class="form-control" name="mangaDescription" id="mangaDescription" placeholder="Description" required/>
								</div>
							</div>
							<div class="col-lg-12">
                                <div class="form-group">
                                    <label for="articleLogo" style="color : black;">Upload logo file:</label>
                                    <input type="file" class="form-control" name="mangaLogo" accept=".gif,.jpg,.jpeg,.png"/>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="mangaContent" style="color : black;">Upload Content Image files:</label>
                                    <input type="file" class="form-control" name="mangaContent" accept=".gif,.jpg,.jpeg,.png" multiple/>
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



        <div id="editModal" class="modal fade" role="dialog">
            <div class="modal-dialog" style="width: 75%;">
              <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Create new Article</h4>
                    </div>
                    <div class="modal-body">
                        <g:form action="update" method="post" name="update" controller="article" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="email" style="color : black;">Title:</label>
                                <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                                <input type="text" class="form-control" name="articleTitle" id="articleTitle" placeholder="Title" value="${title}" required/>
                            </div>
                            <div class="form-group">
                                <label for="email" style="color : black;">Description:</label>
                                <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                                <input type="text" class="form-control" name="articleDescription" id="articleDescription" placeholder="Description" value="${description}" required/>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="articleContent" style="color : black;">Upload text file:</label>
                                    <g:textArea class="form-control" name="content" value="${articleInstance.content}" rows="10" cols="100"/>
                                </div>
                            </div>
                        <%--<g:actionSubmit action="login" value="Submit" class="btn btn-success"/>--%>
                            <input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>

                            <g:hiddenField name="id" value="${articleInstance.id}" />
                        </g:form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <div id="approveModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
            <div class="modal-dialog">
              <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Approve this article?</h4>
                    </div>
                    <div class="modal-body">
                        <g:link controller="home" action="updateApproveAdminArticle" class="btn btn-success" id="${articleInstance.id}" params="${params<<[listId:1]}">Yes</g:link>
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
                        <h4 class="modal-title">Reject this book?</h4>
                    </div>
                    <div class="modal-body">
                        <g:link controller="home" action="updateRejectAdminArticle" class="btn btn-success" id="${articleInstance.id}" params="${params<<[listId:1]}">Yes</g:link>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                        </div>
                        <div class="modal-footer">

                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
