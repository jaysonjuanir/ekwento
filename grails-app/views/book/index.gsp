
<%@ page import="com.mmm.ekwento.Book" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title>Book List | e-Kwento - MMM</title>
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
								<g:form action="index" method="get" name="searchForm">
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
								<g:paginate controller="book" action="index" total="${bookInstanceCount}" />
							</ul>
						</div>


						<table class="table-bordered table-hover">
							<!--<caption>ROLE LIST</caption>-->


							<thead>
								<tr>
									<th scope="col">Book Title</th>
									<th scope="col">Book Description</th>
									<th scope="col">Logo</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="bookInstance" in="${bookInstanceList}">
									<tr>
										<td data-label="ID"><g:link controller="book" action="show" id="${bookInstance.id}" class="nameLink">${bookInstance.title}</g:link></td>
										<td data-label="Authority"><g:link controller="book" action="show" id="${bookInstance.id}" class="nameLink">${bookInstance.description}</g:link></td>
										
										<td data-label="Logo">
											<g:if test="${bookInstance.logo}">
												<img src="${createLink (controller:'book' , action:'renderImage' , id:bookInstance.id)}" alt="bookLogo" height="75" width="75"/>
											</g:if>
											<g:else>
												<g:img dir="images" file="ek.png" height="75" width="75"/>
											</g:else>
										</td>
								</tr>
							</g:each>
							</tbody>
						</table>



						<div class="pagination" style="float:right;">

							<ul class="paginateButtons">
								<g:paginate controller="book" action="index" total="${bookInstanceCount}" />
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>

		

        <g:render template="/layouts/footer"/>
    </body>
</html>