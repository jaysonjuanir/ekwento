
<%@ page import="com.mmm.ekwento.Manga" %>
<%@ page import="com.mmm.ekwento.Genre" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'manga.label', default: 'Manga')}" />
		<title>Manga List | e-Kwento - MMM</title>
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
						<sec:ifAnyGranted roles="ROLE_CREATE_MANGA">
							<div class="pagination addButton">
								<a class="btnn btn-concrete" data-toggle="modal" data-target="#composeMangaModal">
									<i class="glyphicon glyphicon-plus"></i>Add Manga
								</a>
							</div>
						</sec:ifAnyGranted>
						<div class="clearfix"></div>
						<div class="headerTableButtons">


							<div class="searchWrapper">
								<g:form action="index" method="get" name="searchForm">
									<div class="form-input">
										<label for="input4" class="icon glyphicon glyphicon-pencil"></label>
										<button id="convert" class="button glyphicon glyphicon-search"></button>
										<input name="searchManga" type="text" class="input" value="">
									</div>
                                    <div class="form-input">
										<label for="genres" style="color : black;">Genre
                                            <%--<g:each var="genre" in="${Genre.list(sort: "type", order: "asc")}">
											<g:checkBox name="genres" value="${genre.id}" /> ${genre.type}
											<br/>
                                            </g:each>--%>
                                            
										</label>
                                        <g:select name="genre" from="${Genre.list(sort: "type", order: "asc")}" value="${params.genre}" optionKey="id" noSelection="['':'-Choose your Genre-']"/>
									</div>
								</g:form>
							</div>

						</div>
						<div class="pagination" style="float:right;">
							<ul class="paginateButtons">
								<g:paginate controller="manga" action="index" total="${mangaInstanceCount}" />
							</ul>
						</div>


						<table class="table-bordered table-hover">
							<!--<caption>ROLE LIST</caption>-->


							<thead>
								<tr>
									<th scope="col">Manga Title</th>
									<th scope="col">Manga Description</th>
									<th scope="col">Logo</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="mangaInstance" in="${mangaInstanceList}">
									<tr>
										<td data-label="Title"><g:link title="${mangaInstance.description}" controller="manga" action="show" id="${mangaInstance.id}" class="nameLink">${mangaInstance.title}</g:link></td>
										<td data-label="Description"><g:link title="${mangaInstance.description}" controller="manga" action="show" id="${mangaInstance.id}" class="nameLink">${mangaInstance.description}</g:link></td>
										
										<td data-label="Logo">
											<g:if test="${mangaInstance.logo}">
												<g:link title="${mangaInstance.description}" controller="manga" action="show" id="${mangaInstance.id}" class="nameLink"><img src="${createLink (controller:'manga' , action:'renderImage' , id:mangaInstance.id)}" alt="bookLogo" height="75" width="75"/></g:link>
											</g:if>
											<g:else>
												<g:link title="${mangaInstance.description}" controller="manga" action="show" id="${mangaInstance.id}" class="nameLink"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
											</g:else>
										</td>
								</tr>
							</g:each>
							</tbody>
						</table>



						<div class="pagination" style="float:right;">

							<ul class="paginateButtons">
								<g:paginate controller="manga" action="index" total="${mangaInstanceCount}" />
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>

		

        <g:render template="/layouts/footer"/>
		
		<div id="composeMangaModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Create new Manga</h4>
					</div>
					<div class="modal-body">
						<g:form action="create" method="post" name="create" controller="manga" enctype="multipart/form-data">

							<div class="form-group">
								<label for="mangaTitle" style="color : black;">Title:</label>
								<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
								<input type="text" class="form-control" name="mangaTitle" id="mangaTitle" placeholder="Title" required/>
							</div>
							<div class="form-group">
								<label for="mangaDescription" style="color : black;">Description:</label>
								<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
								<input type="text" class="form-control" name="mangaDescription" id="mangaDescription" placeholder="Description" required/>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="mangaLogo" style="color : black;">Upload logo file:</label>
									<input type="file" class="form-control" name="mangaLogo" accept=".gif,.jpg,.jpeg,.png,"/>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group">
									<label for="mangaContent" style="color : black;">Upload Content Image files:</label>
									<input type="file" class="form-control" name="mangaContent" accept=".gif,.jpg,.jpeg,.png" multiple/>
								</div>
							</div>
                            <g:each var="genre" in="${Genre.list(sort: "type", order: "asc")}">
								<div class="col-lg-3">
									<div class="form-group">
										<label for="genres" style="color : black;">
											<g:checkBox name="genres" value="${genre.id}" checked='false'/> ${genre.type}
											<br/>

										</label>
									</div>
								</div>
							</g:each>
						<%--<g:actionSubmit action="login" value="Submit" class="btn btn-success"/>--%>
							<input type="submit" class="btn btn-success" id="submit" value="Submit"/><br>
						</g:form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
    </body>
</html>