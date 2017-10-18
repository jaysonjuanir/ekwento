<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="eKwento-1.0"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <!-- SCRIPTS -->
<!--        <script src="/eKwento-1.0/js/jquery.js"></script>
        <script src="/eKwento-1.0/js/bootstrap.min.js"></script>
        <script src="/eKwento-1.0/js/effects.js"></script>
        <script src="/eKwento-1.0/dist/js/smooth-scroll.js"></script>-->
        <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
        <script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
        <script src="${resource(dir: 'js', file: 'effects.js')}"></script>
        <script src="${resource(dir: 'dist/js', file: 'smooth-scroll.js')}"></script>
        
        <!-- Latest compiled and minified CSS -->
        <!--<link rel="stylesheet" href="/eKwento-1.0/css/bootstrap.min.css" type="text/css" />-->
        
        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">-->
        
        <!--<link rel="stylesheet" href="/eKwento-1.0/css/font-awesome.min.css" type="text/css" />-->
        <link href="${resource(dir: 'css', file: 'bootstrap.min.css')}" rel="stylesheet"/>
        <link href="${resource(dir: 'css', file: 'font-awesome.min.css')}" rel="stylesheet"/>
        
        <!-- Custom CSS -->
        <!--<link rel="stylesheet" href="/eKwento-1.0/css/ekwento.css" type="text/css" />-->
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'ekwento.css')}" type="text/css" />
        
        <!-- Favicon -->
        <!--<link href="/eKwento-1.0/images/faviconn.ico" rel="shortcut icon" type="image/x-icon"></link>-->
        <link href="${resource(dir: 'images', file: 'ek.ico')}" rel="shortcut icon" type="image/x-icon"></link>
        <g:layoutHead/>
    </head>
    <body>
            <!-- NAVIGATION -->
        <nav class="navbar transparent navbar-default ">
            <div class="container">
                <div class="navbar-header page-scroll">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle Navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a data-scroll class="pull-left header-link" href="#page-top">
                        <img class="header-logo" src="${resource(dir: 'images', file: 'ek.png')}" height="100" width="100">
                        
                    </a>
                    <div style="float:left;">
                        <h3 style="float:left;">e-Kwento</h3>
                        <%--<form role="form" >
                            <div class="form-group">
                                <label for="email" style="color : black;">Username:</label>
                                <g:textField type="text" name="user" value="" class="form-control" id="email"/>
                            </div>  
                            <g:actionSubmit action = "login" value = "Submit" class="btn btn-success"/>
                        </form>--%>
                        <form role="form" class="searchform cf">
                            <input type="text" placeholder="Is it me you’re looking for?">
                            <button type="submit">Search</button>
                        </form>
                    </div>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="hidden active">
                            <a data-scroll href="#page-top"></a>
                        </li>
						<sec:ifAnyGranted roles="ROLE_ADMIN_DASHBOARD">
							<li>
								<g:link action="list" controller="home">
								<span>Home</span>
								</g:link>
							</li>
							<li>
								<a data-scroll href="#about">
									<span>About</span>
								</a>
							</li>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_ADMIN_DASHBOARD">
							<li>
								<g:link action="index" controller="home">
								<span>Home</span>
								</g:link>
							</li>
							<li>
								<a data-scroll href="#bulletin">
									<span>Books</span>
								</a>
							</li>
							<li>
								<a data-scroll href="#about">
									<span>About</span>
								</a>
							</li>
							<li>
								<a data-scroll href="#contact">
									<span>Contact Us</span>
								</a>
							</li>
						</sec:ifNotGranted>
                        <sec:ifNotLoggedIn>
                            <li>
                                <a href="#" data-toggle="modal" data-target="#loginModal">
                                    <span class="glyphicon glyphicon-log-in"></span>
                                    <span>Login</span>
                                </a>
                            </li>
                        </sec:ifNotLoggedIn>
                        <sec:ifLoggedIn>
                            <li>
                                <%--<g:link class="logout" data-toggle="modal" controller="logout" action="index"><span>Logout</span></g:link>--%>
                                <a href="#" data-toggle="modal" data-target="#logoutModal">
                                    <span>Logout</span>
                                </a>
                                | Logged In as <i><sec:username/></i> 
                            </li>
                        </sec:ifLoggedIn>
                    </ul>
                </div>
               
            </div>
        </nav>
        <g:layoutBody/>


        <!-- Login Modal -->
        <div id="loginModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
              <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Login</h4>
                    </div>
                    <div class="modal-body">
                        <%--<form role="form" >--%>
                        <%--<form action="/eKwento-1.0/j_spring_security_check" method="POST" role="form">--%>
                        <%--<form action="${postUrl}" method="POST" role="form">--%>
                        <form action="${ request.contextPath }/j_spring_security_check" method="POST" role="form">
                            <div class="form-group">
                                <label for="username" style="color : black;">Username:</label>
                                <%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
                                <input type="text" class="form-control" name="j_username" id="username" placeholder="Username"/>
                            </div>
                            <div class="form-group">
                                <label for="password" style="color : black;">Password:</label>
                                <%--<g:passwordField type="password" name="pass" value = "" class="form-control" id="pwd"/><br/>--%>
                                <input type="password" class="form-control" name="j_password" id="password" placeholder="Password"/>
                            </div>
                            <%--<g:actionSubmit action="login" value="Submit" class="btn btn-success"/>--%>
                            <input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
        
<div id="logoutModal" class="modal fade" role="dialog">
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
