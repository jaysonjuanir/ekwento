<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<section id="bulletin" class="hris-section">
    <div class="container" id="offset-top">
        <div class="row" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
            <h2><b>Bulletin</b></h2>
            <g:if test="${session['level']==2}">
                <g:link action="editBulletin" style="width: 20%;left: 40%;" class="btnn btn-concrete" role="button" ><i class="glyphicon glyphicon-th-list"></i>Edit Bulletin</g:link>
            </g:if>
            <div class="clearfix"></div>
            <hr>
            <!--ANNOUNCEMENTS CAROUSEL-->
            <div id="announcementCarousel" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->

                <ol class="carousel-indicators">
                    <li data-target="#announcementCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#announcementCarousel" data-slide-to="1"></li>
                    <li data-target="#announcementCarousel" data-slide-to="2"></li>
                </ol>

                                                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <div class="row alert announcements" style ="border:1px solid orange;">
                            <div class="announcement message">
                                <h2>Announcements!</h2>
                                <g:each in="${bulletin}" var="blog">
                                    <g:if test="${blog.bulletinType==('announcement')}">
                                        <div class="col-xs-6">
                                            <h4 class=""> <b>Posted By: ${blog.employeeName}</b> </h4>
                                            <span class="text-center big" ><b>Title:</b> ${blog.bulletinSubject}</span>
                                        </div>
                                        <br/>
                                        <br/>
                                        <div class="text-center">

                                            <p class="pannouncements">${blog.message}</p>
                                        </div>
                                        <hr/>
                                    </g:if>
                                </g:each>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="row alert updates" style ="border:1px solid orange;" >
                            <div class="information message">
                                <h2>Updates</h2>
                                <g:each var="blog" in="${bulletin}" >
                                    <g:if test="${blog.bulletinType.equals('update')}">
                                        <div class="col-xs-6">
                                            <h4 class=""> <b>Posted By: ${blog.employeeName}</b> </h4>
                                            <span class="text-center big" ><b>Title:</b> ${blog.bulletinSubject}</span>
                                        </div>
                                        <br/>
                                        <br/>
                                        <div class="text-center">

                                            <p class="pupdates">${blog.message}</p>
                                        </div>
                                        <hr/>
                                    </g:if>
                                </g:each>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="row alert news" style ="border:1px solid orange;">
                            <div class="success message">
                                <h2>News</h2>
                                <g:each var="blog" in="${bulletin}" >
                                    <g:if test="${blog.bulletinType.equals('news')}">
                                        <div class="col-xs-6">
                                            <h4 class=""> <b>Posted By: ${blog.employeeName}</b> </h4>
                                            <span class="text-center big" ><b>Title:</b> ${blog.bulletinSubject}</span>
                                        </div>
                                        <br/>
                                        <br/>
                                        <div class="text-center">

                                            <p class="pnews">${blog.message}</p>
                                        </div>
                                        <hr/>
                                    </g:if>
                                </g:each>
                            </div>
                        </div>
                    </div>

<!-- Left and right controls -->
                    <a class="left carousel-control" href="#announcementCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#announcementCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>

                </div>
            </div>
        </div>
</section>
