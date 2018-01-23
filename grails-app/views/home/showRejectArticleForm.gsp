<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Reject Article | e-Kwento</title>
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
            
            .container{
            -moz-user-select: none;

            -webkit-user-select: none;

            user-select: none;
            }
        </style>

        <script type="text/javascript">
            $( document ).ready(function() {
			$("[data-toggle=popover]").popover({html:true})
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
            
            
        </script>

    </head>
    <body id="page-top" class="container-fluid">

        <section id="bulletin" class="hris-section">

        </section>

        <section id="bulletin" class="hris-section">
            <div class="container bookSection" id="offset-top">
                <div class="post">
					<g:form name="rejectForm">
						<div class="modal-dialog">
						<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title">${articleInstance.title} - ${articleInstance.createdBy}</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="reasonForReject" style="color : black;">Reason For Reject:</label>
										<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
										<input type="text" class="form-control" name="reasonForReject" id="reasonForReject" placeholder="Reason For Reject" required/>
									</div>
										<g:hiddenField name="id" value="${articleInstance.id}" />
										<g:actionSubmit class="btn btn-success" value="Reject" action="updateRejectAdminArticle" />
										<g:link controller="home" action="list"class="btn btn-danger" id="${2}">Cancel</g:link>
									</div>
									<div class="modal-footer">

								</div>
							</div>
						</div>
					</g:form>
                </div>
            <div class="clearfix"></div>
            </div>
        </section>

    <g:render template="/layouts/footer"/>

    



    
</body>
</html>
