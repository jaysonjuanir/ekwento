<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | TroleInstancelates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<section class="header hris-section" id="contact" >
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
            <div class="alert alert-danger" role="status">
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

    <div class="column column-6"><h4 style="color:green">${message}</h4></div>

    <div class="container">
        <div class="row tableDesign">
            <div class="col-md-12">
                
                <h2 class="caption">User Account List</h2>
                <div class="pagination addButton">
                    <a class="btnn btn-concrete" data-toggle="modal" data-target="#addUserAccountModal">
                        <i class="glyphicon glyphicon-plus"></i>Add User Account
                    </a>
                </div>
                <div class="clearfix"></div>
                <div class="headerTableButtons">
                    
                    
                    <div class="searchWrapper">
                        <g:form action="index" method="get" name="searchForm">
                            <div class="form-input">
                                <label for="input4" class="icon glyphicon glyphicon-pencil"></label>
                                <button id="convert" class="button glyphicon glyphicon-log-in"></button>
                                <input name="searchCriteria" type="text" class="input" value=""/>
                            </div>
                        </g:form>
                    </div>
                    
                </div>
                <div class="pagination" style="float:right;">
                        <ul class="paginateButtons">
                            <g:paginate controller="userAccount" action="index" total="${userAccountInstanceCount}" />
                        </ul>
                    </div>
                
                <table>
                    <!--<caption>ROLE LIST</caption>-->
                    

                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Username</th>
                            <th scope="col">Edit</th>
                            <th scope="col">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each var="userAccountInstance" in="${userAccountInstanceList}">
                            <tr>
                                <td data-label="ID"><g:link action="show" id="${userAccountInstance.id}" class="nameLink">${userAccountInstance.id}</g:link></td>
                                <td data-label="Username"><g:link action="show" id="${userAccountInstance.id}" class="nameLink">${userAccountInstance.username}</g:link></td>
                                <td data-label="Edit"><p data-toggle="tooltip" title="Edit"><a  class="btn btn-success btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit${userAccountInstance.id}" ><span class="glyphicon glyphicon-pencil"  style="left: 20%;"></span></a></p></td>
                                <td data-label="Delete"><p data-toggle="tooltip" title="Delete"><button class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete${userAccountInstance.id}" ><span class="glyphicon glyphicon-trash" style="left: 20%;"></span></button></p></td>
                                <!-- UPDATE MODAL -->
                                <div class="modal fade" id="edit${userAccountInstance.id}" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                                <!--modal header-->
                                            <div class="modal-header">
                                                <h2> Update User Account</h2>
                                            </div>
                                            <!--modal body-->
                                            <div class="modal-body">
                                                <div class="row text-justify"> 
                                                    <g:uploadForm action="update" method="post" name="update${userAccountInstance.id}">
                                                        <div class="col-lg-12">
                                                            <div class="form-group">
                                                                <div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'username', 'error')} required">
                                                                    <label for="username" style="color : black;">Username:</label>
                                                                    <g:textField class="form-control" name="username" placeholder="Enter Username" required="" value="${userAccountInstance.username}"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <div class="form-group">
                                                                <div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'password', 'error')} required">
                                                                    <label for="password" style="color : black;">Password:</label>
                                                                    <g:textField class="form-control" name="password" placeholder="Enter Password" required="" value="${userAccountInstance.password}"/>
                                                                </div>                                                    
>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <g:hiddenField type="hidden" name="id" value="${userAccountInstance?.id}"/>
                                                        <button class="btn btn-warning btn-lg" style="width: 100%;margin:2%;"><span class="glyphicon glyphicon-ok-sign"></span>Update Username</button>
                                                    </g:uploadForm>
                                                </div>
                                            </div>
                                            <!--modal footer-->
                                            <div class="modal-footer ">
                                                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Close</button>
                                            </div>
                                        </div><!-- end of modal-content --> 
                                    </div> <!-- end of modal-dialog --> 
                                </div> <!-- end of modal --> 

                                <!--DELETE MODAL-->
                                <div class="modal fade" id="delete${userAccountInstance.id}" tabindex="-1" role="dialog" aria-labelledby="delete" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                                <!--modal header-->
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title custom_align" id="Heading">Delete this entry</h4>
                                            </div>
                                            <!--modal body-->
                                            <div class="modal-body">
                                                <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>
                                            </div>
                                            <!--modal footer-->
                                            <div class="modal-footer ">

                                                <g:form action="delete" method="post" name="del${userAccountInstance.id}">
                                                    <input type="hidden" name="id" value="${userAccountInstance.id}"/><br/>
                                                </g:form>
                                                <button form="del${userAccountInstance.id}" type="sumbit" class="btn btn-success" ><span class="glyphicon glyphicon-ok-sign"></span>Yes</button>
                                                <button  type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span>No</button>
                                            </div>
                                        </div><!-- end of modal-content --> 
                                    </div> <!-- end of modal-dialog --> 
                                </div> <!-- end of modal --> 
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                
                
                
                <div class="pagination" style="float:right;">
                    <ul class="paginateButtons">
                        <g:paginate controller="userAccount" action="index" total="${userAccountInstanceCount}" />
                    </ul>
                </div>
            </div> <!--end of column-->
        </div> <!--end of row-->
    </div> <!--end of container-->
</section>

<div class="modal fade" id="addUserAccountModal" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
                <!--modal header-->
            <div class="modal-header">
                <h2> Create User Account</h2>
            </div>
            <!--modal body-->
            <div class="modal-body">
                <div class="row text-justify">
                    <g:uploadForm action='save' method="post" name="addEmployee">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'username', 'error')} required">
                                    <label for="username" style="color : black;">Username:</label>
                                    <g:textField class="form-control" name="username" placeholder="Enter Username" required="" value=""/>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <div class="fieldcontain ${hasErrors(bean: userAccountInstance, field: 'password', 'error')} required">
                                    <label for="password" style="color : black;">Password:</label>
                                    <g:textField class="form-control" name="password" placeholder="Enter Password" required="" value=""/>
                                </div>                                                    
                                >
                            </div>
                        </div>
                        
                        <div class="clearfix"></div>
                        <hr>
                        <button class="btn btn-warning btn-lg" style="width: 95%;margin:2%;"><span class="glyphicon glyphicon-ok-sign"></span>Add User Account</button>
                    </g:uploadForm>
                </div>
            </div>
            <!--modal footer-->
            <div class="modal-footer ">
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Close</button>
            </div>
        </div><!-- end of modal-content --> 
    </div> <!-- end of modal-dialog --> 
</div> <!-- end of modal --> 