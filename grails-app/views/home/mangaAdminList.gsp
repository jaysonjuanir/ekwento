
<%@ page import="com.mmm.ekwento.Manga" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'manga.label', default: 'Manga')}" />
		<title>Manga Admin List | e-Kwento - MMM</title>
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

						<h2 class="caption">Manga List</h2>
						<div class="clearfix"></div>
						<div class="headerTableButtons">


							<div class="searchWrapper">
								<g:form action="list" method="get" name="searchForm">
									<div class="form-input">
										<label for="input4" class="icon glyphicon glyphicon-pencil"></label>
										<button id="convert" class="button glyphicon glyphicon-search"></button>
										<input name="searchManga" type="text" class="input" value="">
									</div>
									<g:hiddenField name="id" value="${3}" />
								</g:form>
							</div>

						</div>
						<div class="pagination" style="float:right;">
							<ul class="paginateButtons">
								<g:paginate controller="home" action="list" id="${3}" total="${mangaPendingCount}" />
							</ul>
						</div>


						<table class="table-bordered table-hover">
							<!--<caption>ROLE LIST</caption>-->


							<thead>
								<tr>
									<th scope="col">Manga Title</th>
									<th scope="col">Manga Description</th>
									<th scope="col">Approve</th>
									<th scope="col">Reject</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="mangaInstance" in="${mangaPendingList}">
									<tr>
										<td data-label="ID"><g:link controller="manga" action="show" id="${mangaInstance.id}" class="nameLink">${mangaInstance.title}</g:link></td>
										<td data-label="Authority"><g:link controller="manga" action="show" id="${mangaInstance.id}" class="nameLink">${mangaInstance.description}</g:link></td>
										<td data-label="Approve"><p data-toggle="tooltip" title="Approve"><a  class="btn btn-success btn-xs" data-title="Approve" data-toggle="modal" data-target="#approve${mangaInstance.id}" ><span class="glyphicon glyphicon-pencil"  style="left: 20%;"></span></a></p></td>
										<td data-label="Reject"><p data-toggle="tooltip" title="Reject"><button class="btn btn-danger btn-xs" data-title="Reject" data-toggle="modal" data-target="#reject${mangaInstance.id}" ><span class="glyphicon glyphicon-trash" style="left: 20%;"></span></button></p></td>
										<!-- UPDATE MODAL -->


									<div id="approve${mangaInstance.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
										<div class="modal-dialog">
										  <!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Approve this manga?</h4>
												</div>
												<div class="modal-body">
													<g:link controller="home" action="updateApproveAdminManga" class="btn btn-success" id="${mangaInstance.id}" params="${params}">Yes</g:link>
														<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
													</div>
													<div class="modal-footer">

												</div>
											</div>
										</div>
									</div>

									<div id="reject${mangaInstance.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
										<div class="modal-dialog">
										  <!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Reject this manga?</h4>
												</div>
												<div class="modal-body">
													<g:link controller="home" action="showRejectAdminMangaForm" class="btn btn-success" id="${mangaInstance.id}" params="${params}">Yes</g:link>
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
								<g:paginate controller="home" action="list" id="${3}" total="${mangaPendingCount}" />
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>

		

        <g:render template="/layouts/footer"/>
    </body>
</html>
