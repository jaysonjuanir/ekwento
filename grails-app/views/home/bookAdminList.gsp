
<%@ page import="com.mmm.ekwento.Book" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title>Book Admin List | e-Kwento - MMM</title>
    </head>
    <body id="page-top">
        <!-- HEADER -->
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

						<h2 class="caption">Book List</h2>
						<div class="clearfix"></div>
						<div class="headerTableButtons">


							<div class="searchWrapper">
								<g:form action="list" method="get" name="searchForm">
									<div class="form-input">
										<label for="input4" class="icon glyphicon glyphicon-pencil"></label>
										<button id="convert" class="button glyphicon glyphicon-search"></button>
										<input name="searchBook" type="text" class="input" value="">
									</div>
									<g:hiddenField name="id" value="${1}" />
								</g:form>
							</div>

						</div>
						<div class="pagination" style="float:right;">
							<ul class="paginateButtons">
								<g:paginate controller="home" action="list" id="${1}" total="${bookPendingCount}" />
							</ul>
						</div>


						<table class="table-bordered table-hover">
							<!--<caption>ROLE LIST</caption>-->


							<thead>
								<tr>
									<th scope="col">Book Title</th>
									<th scope="col">Book Description</th>
									<th scope="col">Approve</th>
									<th scope="col">Reject</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="bookInstance" in="${bookPendingList}">
									<tr>
										<td data-label="ID"><g:link controller="book" action="show" id="${bookInstance.id}" class="nameLink">${bookInstance.title}</g:link></td>
										<td data-label="Authority"><g:link controller="book" action="show" id="${bookInstance.id}" class="nameLink">${bookInstance.description}</g:link></td>
										<td data-label="Approve"><p data-toggle="tooltip" title="Approve"><a  class="btn btn-success btn-xs" data-title="Approve" data-toggle="modal" data-target="#approve${bookInstance.id}" ><span class="glyphicon glyphicon-pencil"  style="left: 20%;"></span></a></p></td>
										<td data-label="Reject"><p data-toggle="tooltip" title="Reject"><button class="btn btn-danger btn-xs" data-title="Reject" data-toggle="modal" data-target="#reject${bookInstance.id}" ><span class="glyphicon glyphicon-trash" style="left: 20%;"></span></button></p></td>
										<!-- UPDATE MODAL -->


									<div id="approve${bookInstance.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
										<div class="modal-dialog">
										  <!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Approve this book?</h4>
												</div>
												<div class="modal-body">
													<g:link controller="home" action="updateApproveAdminBook" class="btn btn-success" id="${bookInstance.id}" params="${params}">Yes</g:link>
														<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
													</div>
													<div class="modal-footer">

												</div>
											</div>
										</div>
									</div>

									<div id="reject${bookInstance.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
										<div class="modal-dialog">
										  <!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Reject this book?</h4>
												</div>
												<div class="modal-body">
													<g:link controller="home" action="showRejectAdminBookForm" class="btn btn-success" id="${bookInstance.id}" params="${params}">Yes</g:link>
														<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
													</div>
													<div class="modal-footer">

												</div>
											</div>
										</div>
									</div>


								</tr>
							</g:each>
							</tbody>
						</table>



						<div class="pagination" style="float:right;">

							<ul class="paginateButtons">
								<g:paginate controller="home" action="list" id="${1}" total="${bookPendingCount}" />
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>

		

        <g:render template="/layouts/footer"/>
    </body>
</html>