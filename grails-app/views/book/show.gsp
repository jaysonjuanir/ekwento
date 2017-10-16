<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page import="com.mmm.ekwento.Genre" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Show Book | e-Kwento</title>
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
                    <li class="dropdown active">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Compose
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" data-toggle="modal" data-target="#composeBookModal">Book</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#composeArticleModal">Article</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#composeMangaModal">Manga</a></li>
                        </ul>
                    </li>
					<li class="active"><a href="#">Library</a></li>
                    <li class="active"><a href="#">Message</a></li>
                    <li class="active"><a href="#">Notification</a></li>
                </ul>
                
                <ul class="nav navbar-nav navbar-right ">
					<g:if test="${isOwned}">
						<li class="active"><a href="#" data-toggle="modal" data-target='#editModal'><span class="glyphicon glyphicon-pencil"></span>Edit</a></li>
					</g:if>
                    <li class="active"><a href="#"><span class="glyphicon glyphicon-eye-open"></span>${numberOfViews} Views</a></li>
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

        <section id="bulletin" class="hris-section">

        </section>

        <section id="bulletin" class="hris-section">
            <div class="container bookSection" id="offset-top">
                <div class="post">
                    <div class="closeArticle">Close Article</div>
                    <h1>${title}</h1>
                    <h3>${description}</h3>
                    <div class="author">By ${createdBy} | <g:formatDate format="MM-dd-yyyy" date="${dateCreated}"/></div> 

                    <!--PREVIEW CONTENT WITH 3 PARAGRAPHS-->
                    <g:each var="sentence" in="${content}" status="i">
                        <g:if test="${i<=2}">
                            <p>${sentence}</p>
                        </g:if>
                    </g:each>

                    <!--REST OF THE CONTENT-->
                    <article>    
                        <g:each var="sentence" in="${content}" status="i">
                            <g:if test="${i>=3}">
                                <p>${sentence}</p>
                            </g:if>
                        </g:each>
                    </article>
                <div class="keepReading">Keep Reading</div>
            </div>


            <div class="clearfix"></div>
        </div>
    </section>

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
                                <label for="bookLogo" style="color : black;">Upload text file:</label>
                                <input type="file" class="form-control" name="bookLogo" accept=".gif,.jpg,.jpeg,.png,"/>
                            </div>
                        </div>
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
                            <label for="email" style="color : black;">Title:</label>
                            <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                            <input type="text" class="form-control" name="articleTitle" id="articleTitle" placeholder="Title" required/>
                        </div>
                        <div class="form-group">
                            <label for="email" style="color : black;">Description:</label>
                            <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                            <input type="text" class="form-control" name="articleDescription" id="articleDescription" placeholder="Description" required/>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="articleContent" style="color : black;">Upload text file:</label>
                                <input type="file" class="form-control" name="fileContent"/>
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
                    <h4 class="modal-title">Create new Book</h4>
                </div>
                <div class="modal-body">
                    <g:form action="update" method="post" name="update" controller="book" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="email" style="color : black;">Title:</label>
                            <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                            <input type="text" class="form-control" name="bookTitle" id="bookTitle" placeholder="Title" value="${title}" required/>
                        </div>
                        <div class="form-group">
                            <label for="email" style="color : black;">Description:</label>
                            <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                            <input type="text" class="form-control" name="bookDescription" id="bookDescription" placeholder="Description" value="${description}" required/>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="bookContent" style="color : black;">Upload text file:</label>
                                <g:textArea class="form-control" name="content" value="${bookInstance.content}" rows="10" cols="100"/>
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
                        
                        <g:hiddenField name="id" value="${bookInstance.id}" />
                    </g:form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>




</body>
</html>
