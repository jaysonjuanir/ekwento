<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div class="containerResume">

  <!-- wrapperResume -->
    <div class="wrapperResume">
        <hr>
        <!-- title name cv-->
        <header class="mainResume">
            <h1 class="text-uppercase"> ${emp?.name}</h1>
            <p class="lead"> ${emp?.position}</p>
        </header>
        <hr>
        <div class="row">
          <!-- column left -->
            <div class="col-md-7">

        <!-- about me -->
                <section>

                    <h3 class="text-uppercase">Information</h3>
                    <article>
                        <div class="row">
                            <div class="col-sm-4 col-sm-push-9">
                                <img src="${resource(dir: 'uploads/avatar', file: "${emp?.id}.${pic}")}" class="img-responsive img-circle photoResume"/>
                            </div>
                            <div class="col-xs-12 col-sm-8 col-sm-pull-2">
                                
                                <span style="float:left;"><i class="glyphicon glyphicon-user"></i>&nbsp;<b>Full Name:</b></span> <p> ${emp?.name}</p>
                                <div class="clearfix"></div>
                                
                                <span style="float:left;"><i class="glyphicon glyphicon-tasks"></i>&nbsp;<b>Position:</b></span> <p> ${emp?.position}</p>
                                <div class="clearfix"></div>
                                <br/>
                            </div>
                        </div>
                    </article>
                </section>
                <!--/ about me -->

                <!-- experiences -->
                <section>
                    <h3 class="text-uppercase">Work Experiences</h3>
                    <div class="col four">			
                        <g:link action="download" params="[title: emp?.id+'.'+pic1, path: 'uploads/tor']" style="padding: 1.5em 1.5em; color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-education"></i> Education Record</g:link>			
                        </div>

                    <div class="col four">
                        <g:link action="download" params="[title: emp?.id+'.'+pic2, path: 'uploads/performanceAssessment']" style="padding: 1.5em 1.5em;color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-thumbs-up"></i> Performance Assessment</g:link>			
                        </div>

                    <div class="col four">
                        <g:link action="download" params="[title: emp?.id+'.'+pic3, path: 'uploads/clearance']" style="padding: 1.5em 1.5em;color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-check"></i> Clearance</g:link>						
                        </div>

                    <div class="col four">
                        <g:link action="download" params="[title: emp?.id+'.'+pic4, path: 'uploads/correctiveActions']" style="padding: 1.5em 1.5em;color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-alert"></i> Sanctions and Violation</g:link>			
                        </div>
                        <div class="col four">			
                        <g:link action="download" params="[title: emp?.id+'.'+pic5, path: 'uploads/workHistory']" style="padding: 1.5em 1.5em;color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-briefcase"></i> Work History</g:link>		
                        </div>
                        <div class="col four">
                        <g:link action="download" params="[title: emp?.id+'.'+pic6, path: 'uploads/postEmployment']" style="padding: 1.5em 1.5em;color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-briefcase"></i> Post Employment</g:link>			
                        </div>
                        <div class="col four">
                        <g:link controller="manager" action="testReport" style="padding: 1.5em 1.5em;color:#000;width:100%;" href="#" class="btn btn-default"><i class="glyphicon glyphicon-blackboard"></i> Hiring Requirements</g:link>			
                        </div>
                        
                        <div class="col four" style="color:#000;background-color:white;padding: 2% 0%;" class="btn btn-default">
                            <g:jasperReport action="test" controller="manager" format="PDF" jasper="jobDescription1" name="Job Description"/>
                        </div>

                </section>
                <!--/ experiences -->
            </div>
            <!--/ column left -->

      <!-- column right -->
            <div class="col-md-5">

        <!-- contact -->
                <section>

                    <h3 class="text-uppercase">Contact</h3>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-phone text-primary"></span>${emp?.contact}</div>
                    </article>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-road text-primary"></span>${emp?.address}</div>
                    </article>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-gift text-primary"></span><g:formatDate type="date" style="LONG" date="${emp?.birthday}" /></div>
                    </article>
                </section>
                <!--/ contact -->

        <!-- Personal -->
                <section>
                    <h3 class="text-uppercase">Mandatory Benefits</h3>
                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-usd text-primary"></span>SSS Number: ${emp?.sss}</div>
                    </article>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-bitcoin text-primary"></span>BIR Number: ${emp?.bir}</div>
                    </article>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-superscript text-primary"></span>Tax Information Number: ${emp?.tin}</div>
                    </article>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-heart text-primary"></span>HDMF Number: ${emp?.pagibig}</div>
                    </article>

                    <article class="media">
                        <div class="media-body"><span class="glyphicon glyphicon-user text-primary"></span>PhilHealth Number: ${emp?.philHealth}</div>
                    </article>
                </section>
                <!--/ Personal -->

                <section>
                    <h3 class="text-uppercase">Actions:</h3>
                    <article>
                        <div class="row">
                            <div class="col-sm-6 col-md-12">
                              <!-- button download PDF -->
                                <div class="text-left">
                                    <a style="width:100%;margin-bottom: 5%;" class="btn btn-success btn-lg btn-download" data-title="Edit" data-toggle="modal" data-target="#edit" title="Edit this Employee" class="btn btn-default btn-lg btn-download">
                                        <i class="glyphicon glyphicon-pencil"></i>&nbsp; Edit this Employee 
                                    </a>

                                    <g:if test="${session.level==2}">
                                        
                                        <a style="width:100%;" title="Delete this Employee" id="delete" class="btn btn-danger btn-lg btn-download" data-title="Delete" data-toggle="modal" data-target="#delete">
                                            <i class="glyphicon glyphicon-trash"></i>&nbsp; Delete this Employee
                                        </a>
                                    </g:if>
                                </div>
                                <!--/ button download PDF -->
                            </div>
                        </div>
                    </article>
                </section>
            </div>
            <!--/ column right -->
        </div>
        <hr>

        <!--/ button download PDF -->

    </div>
    <!--/ wrapperResume -->

</div>

<!-- UPDATE MODAL -->
<div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
                <!--modal header-->
            <div class="modal-header">
                <h2> Update Employee</h2>
            </div>
            <!--modal body-->
            <div class="modal-body">
                <div class="row text-justify"> 
                    <g:uploadForm action="update" method="post" controller="manager">
                        <div class="col-lg-12">
                            <div class="form-group">

                                <h4><label style="color : black;">Full Name</label></h4>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="fname" style="color : black;">First Name:</label>
                                <g:textField class="form-control " name="firstName" placeholder="First Name" value="${emp?.name?.firstName}" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group image-preview">
                                <label for="prof-pic" style="color : black;">Profile Picture:</label>
                                <input type="text" class="form-control image-preview-filename" disabled="disabled" id="prof-pic"> <!-- don't give a name === doesn't send on POST/GET -->
                                <span class="form-group-btn">
                            <!-- image-preview-clear button -->
                                    <button type="button" class="btn btn-default image-preview-clear" style="display:none;">
                                        <span class="glyphicon glyphicon-remove"></span> Clear
                                    </button>
                                    <!-- image-preview-input -->
                                    <div class="btn btn-default image-preview-input">
                                        <span class="glyphicon glyphicon-folder-open"></span>
                                        <span class="image-preview-input-title">Browse</span>
                                        <g:field type="file" accept="image/png, image/jpeg, image/gif" name="avatar"/> <!-- rename it -->
                                    </div>
                                </span>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="mname" style="color : black;">Middle Name:</label>
                                <g:textField class="form-control " name="middleName" placeholder="Middle Name" value="${emp?.name?.middleName}" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="lname" style="color : black;">Last Name:</label>
                                <g:textField class="form-control " name="lastName" value="${emp?.name?.lastName}" placeholder="Last Name" required=""/>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <hr/>
                        <div class="col-lg-12">
                            <div class="form-group">

                                <h4><label style="color : black;">Full Address</label></h4>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="streetName" style="color : black;">Street Name:</label>
                                <g:textField class="form-control " name="streetName" value="${emp?.address?.streetName}" placeholder="Street Name" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="barangay" style="color : black;">Barangay:</label>
                                <g:textField class="form-control " name="barangay" value="${emp?.address?.barangay}" placeholder="Barangay" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="city" style="color : black;">City:</label>
                                <g:textField class="form-control " name="city" placeholder="City" required="" value="${emp?.address?.city}" />
                            </div>
                        </div>

                        <div class="clearfix"></div>
                        <hr>

                        <div class="col-lg-12">
                            <div class="form-group">

                                <h4><label style="color : black;">Other Information</label></h4>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="contact" style="color : black;">Contact Number:</label>
                                <g:textField class="form-control " id="cont"name="contact" value="${emp?.contact}" placeholder="Contact" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="bdate" style="color : black;">Date of Birth:</label><div class="clearfix"></div>
                                <g:datePicker class="form-control" name="birthday" value="${emp?.birthday}" precision="day" years="${1970..2016}"/>

                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="position" style="color : black;">Position:</label>
                                
                                <g:select class="form-control" name="position" style="width: 100%;" required="" from="${['Store Manager', 'Purchasing Assistant', 'Kitchen Staff', 'Kitchen Head', 'Cashier', 'Receptionist', 'Service Crew', 'Maintenance']}" value="${emp?.position}" noSelection="['':'']"/>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="sss" style="color : black;">SSS Number:</label>
                                <g:textField class="form-control " name="sss" placeholder="SSS" value="${emp?.sss}" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="bir" style="color : black;">BIR Number:</label>
                                <g:textField class="form-control " name="bir" placeholder="bir" value="${emp?.bir}" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="tin" style="color : black;">TIN:</label>
                                <g:textField class="form-control " name="tin" placeholder="TIN" value="${emp?.tin}" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="philHealth" style="color : black;">PhilHealth Number:</label>
                                <g:textField class="form-control " name="philHealth" placeholder="Phil Health" value="${emp?.philHealth}" required=""/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="hdmf" style="color : black;">HDMF Number:</label>
                                <g:textField class="form-control " name="pagibig" placeholder="Phil Health" value="${emp?.pagibig}" required=""/>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <hr>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="education" style="color : black;">Education Records:</label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="tor"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="performanceAssessment" style="color : black;">Performance Assessment:</label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="performanceAssessment" id="performanceAssessment"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="clearance" style="color : black;">Clearance: </label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="clearance" id="clearance"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="correctiveActions" style="color : black;">Corrective Actions: </label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="correctiveActions" id="correctiveActions"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="workHistory" style="color : black;">Work History:</label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="workHistory" id="workHistory"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="postEmployment" style="color : black;">Post Employments:</label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="postEmployment" id="postEmployment"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="hiringRequirements" style="color : black;">Hiring Requirements:</label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="hiringRequirements" id="hiringRequirements"/>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="jobDescription" style="color : black;">Job Description:</label>
                                <g:field type="file" accept="application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf" class="form-control" name="jobDescription" id="jobDescription"/>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <hr>
                        <g:hiddenField type="hidden" name="id" value="${emp?.id}"/>
                        <button class="btn btn-warning btn-lg" style="width: 100%;margin:2%;"><span class="glyphicon glyphicon-ok-sign"></span>Update Employee</button>
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

<!-- DELETE MODAL -->
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="delete" aria-hidden="true">
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

                <g:form action="delete" method="post" name="del${emp.id}">
                    <input type="hidden" name="id" value="${emp.id}"/><br/>
                </g:form>
                <button form="del${emp.id}" type="sumbit" class="btn btn-success" ><span class="glyphicon glyphicon-ok-sign"></span>Yes</button>
                <button  type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span>No</button>
            </div>
        </div><!-- end of modal-content --> 
    </div> <!-- end of modal-dialog --> 
</div> <!-- end of modal --> 

<!--/ container-->

<!-- footer signature -->
<div class="clearfix"></div>
<footer ><div>${emp?.name.toString()}&nbsp;2016 / Karaoke Avenue</div></footer>