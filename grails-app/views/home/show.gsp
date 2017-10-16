<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>e-Kwento - MMM</title>
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
                    <li class="active"><a href="#" data-toggle="modal" data-target="#composeModal">Compose</a></li>
                    <li class="active"><a href="#">Message</a></li>
                    <li class="active"><a href="#">Library</a></li>
                    <li class="active"><a href="#">Notification</a></li>
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
                    <h1>My First Blog Post</h1>
                    <h3>Welcome to my new blog!</h3>
                    <div class="author">By G-SCO | 2016-02-03</div>

                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eu varius leo, vel porta eros. Praesent et viverra enim. Sed finibus, justo porttitor mattis posuere, dui elit dignissim dolor, vitae bibendum ipsum orci a quam. Praesent eget velit sit amet
                        ante ultricies vulputate in nec orci. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent eget ultrices odio. Vestibulum tempor commodo mauris, id blandit lectus hendrerit ac. Maecenas non faucibus tellus, ut eleifend libero. Integer
                        consectetur tellus ac semper euismod. Aenean porttitor semper tincidunt. Nunc sed urna nibh. Cras nec felis luctus, sollicitudin enim at, consequat orci. Suspendisse sit amet odio id velit aliquet commodo sed vitae lectus. Praesent egestas id justo
                        sit amet congue. Donec sed arcu quis felis finibus lacinia.</p>

                    <g:each var="sentence" in="${params.wordLists}" status="i">
                        <g:if test="${i<=3}">
                            <p>${sentence}</p>
                        </g:if>
                        <g:else>
                            <article>    
                                <p>${sentence}</p>
                        </article>
                        </g:else>
                    </g:each>

                    <div class="keepReading">Keep Reading</div>
                </div>


                <div class="clearfix"></div>
            </div>
        </section>

        <g:render template="/layouts/footer"/>

        <div id="composeModal" class="modal fade" role="dialog">
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
                                    <input type="file" class="form-control" name="fileContent"/>
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







    </body>
</html>
