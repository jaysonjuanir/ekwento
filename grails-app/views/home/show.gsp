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

        <section id="bulletin" class="hris-section">

        </section>

        <section id="bulletin" class="hris-section">
            <div class="container bookSection" id="offset-top">
                <div class="leftSidePanel" id="offset-top">
                    <div class="leftSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Latest Uploads</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="show" id="1">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>

                    <div class="leftSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Recent Books</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="show" id="1">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="rightSidePanel" id="offset-top">
                    <div class="rightSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Articles</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="show" id="1">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>

                    <div class="rightSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Manga</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="show" id="1">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>

                    <div class="rightSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
                        <h3 class="reg-inline"><b>Books</b></h3>
                        <g:link class="reg-inline side-buttons btn btn-primary" action="show" id="1">Read More</g:link>

                        <div>
                            <ul id="Grid">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>
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
                        <h4 class="modal-title">Logout</h4>
                    </div>
                    <div class="modal-body">
                        <g:link controller="logout" action="index" class="btn btn-success">Yes</g:link>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                        </div>
                        <div class="modal-footer">

                    </div>
                </div>
            </div>
        </div>







    </body>
</html>
