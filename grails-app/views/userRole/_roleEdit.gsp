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
                
                <h2 class="caption">User Role List</h2>
                <div class="pagination addButton">
                    <a class="btnn btn-concrete" data-toggle="modal" data-target="#addRoleModal">
                        <i class="glyphicon glyphicon-plus"></i>Add Role
                    </a>
                </div>
                <div class="clearfix"></div>
                <div class="headerTableButtons">
                    
                    
                    <div class="searchWrapper">
                        <g:form action="index" method="get" name="searchForm">
                            <div class="form-input">
                                <label for="input4" class="icon glyphicon glyphicon-pencil"></label>
                                <button id="convert" class="button glyphicon glyphicon-search"></button>
                                <input name="searchCriteria" type="text" class="input" value="">
                            </div>
                        </g:form>
                    </div>
                    
                </div>
                <div class="pagination" style="float:right;">
                        <ul class="paginateButtons">
                            <g:paginate controller="userRole" action="index" total="${userRoleInstanceCount}" />
                        </ul>
                    </div>
                    
                            
                <table class="table-bordered table-hover">
                    <!--<caption>ROLE LIST</caption>-->
                    

                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Authority</th>
                            <th scope="col">Edit</th>
                            <th scope="col">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each var="roleInstance" in="${userRoleInstance}">
                            <tr>
                                <td data-label="ID"><g:link action="show" id="${roleInstance.id}" class="nameLink">${roleInstance.id}</g:link></td>
                                <td data-label="Authority"><g:link action="show" id="${roleInstance.id}" class="nameLink">${roleInstance.authority}</g:link></td>
                                <td data-label="Edit"><p data-toggle="tooltip" title="Edit"><a  class="btn btn-success btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit${roleInstance.id}" ><span class="glyphicon glyphicon-pencil"  style="left: 20%;"></span></a></p></td>
                                <td data-label="Delete"><p data-toggle="tooltip" title="Delete"><button class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete${roleInstance.id}" ><span class="glyphicon glyphicon-trash" style="left: 20%;"></span></button></p></td>
                                <!-- UPDATE MODAL -->
                                <div class="modal fade" id="edit${roleInstance.id}" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                                <!--modal header-->
                                            <div class="modal-header">
                                                <h2> Update Role</h2>
                                            </div>
                                            <!--modal body-->
                                            <div class="modal-body">
                                                <div class="row text-justify"> 
                                                    <g:uploadForm action="update" method="post" name="update${roleInstance.id}">
                                                        <div class="col-lg-12">
                                                            <div class="form-group">
                                                                <div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'authority', 'error')} required">
                                                                    <label for="authority" style="color : black;">Authority:</label>
                                                                    <g:textField class="form-control" name="authority" placeholder="Enter New Role" required="" value="${roleInstance.authority}"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <g:hiddenField type="hidden" name="id" value="${roleInstance?.id}"/>
                                                        <button class="btn btn-warning btn-lg" style="width: 100%;margin:2%;"><span class="glyphicon glyphicon-ok-sign"></span>Update Employee</button>
                                                    </g:uploadForm>
                                                </div>
                                            </div>
                                            <!--modal footer-->
                                            <div class="modal-footer ">
                                                <!--<button form = "update${roleInstance.id}" type="submit" class="btn btn-warning btn-lg" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span>Update Employee</button>-->
                                                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Close</button>
                                            </div>
                                        </div><!-- end of modal-content --> 
                                    </div> <!-- end of modal-dialog --> 
                                </div> <!-- end of modal --> 

                                <!--DELETE MODAL-->
                                <div class="modal fade" id="delete${roleInstance.id}" tabindex="-1" role="dialog" aria-labelledby="delete" aria-hidden="true">
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

                                                <g:form action="delete" method="post" name="del${roleInstance.id}">
                                                    <input type="hidden" name="id" value="${roleInstance.id}"/><br/>
                                                </g:form>
                                                <button form="del${roleInstance.id}" type="sumbit" class="btn btn-success" ><span class="glyphicon glyphicon-ok-sign"></span>Yes</button>
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
                        <g:paginate controller="userRole" action="index" total="${userRoleInstanceCount}" />
                    </ul>
                </div>
            </div> <!--end of column-->
        </div> <!--end of row-->
    </div> <!--end of container-->
</section>

<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
                <!--modal header-->
            <div class="modal-header">
                <h2> Create Role</h2>
            </div>
            <!--modal body-->
            <div class="modal-body">
                <div class="row text-justify">
                    <g:uploadForm action='save' method="post" name="addEmployee">
                        <div class="col-lg-12">
                            
                            <div class="form-group">
                                <div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'authority', 'error')} required">
                                        <label for="authority" style="color : black;">Authority:</label>
                                        <g:textField class="form-control" name="authority" placeholder="Enter New Role" required="" value=""/>
                                </div>
                            </div>
                        </div>
                        
                        <div class="clearfix"></div>
                        <hr>
                        <button class="btn btn-warning btn-lg" style="width: 95%;margin:2%;"><span class="glyphicon glyphicon-ok-sign"></span>Add Role</button>
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