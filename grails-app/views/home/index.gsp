<!DOCTYPE html>
<html>
    <head>
        <title>e-Kwento - MMM</title>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name='layout' content='main' />

    </head>

    <body id="page-top">
                <!-- HEADER -->
        <section id="home-top" class="header hris-section">
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
            <div class="container cont">
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
                        <div class="form-horizontal">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label class="col-xs-12 col-sm-6 col-md-8">
                                        <input class="reg-inline" type="checkbox"> By Checking this will also agree on license of terms provided by eKwento.
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


        <footer id="footer">
        </footer>
    </body>
</html>