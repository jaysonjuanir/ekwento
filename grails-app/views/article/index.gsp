
<%@ page import="com.mmm.ekwento.Article" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'article.label', default: 'Article')}" />
		<title>Article List | e-Kwento - MMM</title>
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

						<h2 class="caption">Article List</h2>
						<div class="clearfix"></div>
						<div class="headerTableButtons">


							<div class="searchWrapper">
								<g:form action="index" method="get" name="searchForm">
									<div class="form-input">
										<label for="input4" class="icon glyphicon glyphicon-pencil"></label>
										<button id="convert" class="button glyphicon glyphicon-search"></button>
										<input name="searchArticle" type="text" class="input" value="">
									</div>
								</g:form>
							</div>

						</div>
						<div class="pagination" style="float:right;">
							<ul class="paginateButtons">
								<g:paginate controller="article" action="index" total="${articleInstanceCount}" />
							</ul>
						</div>


						<table class="table-bordered table-hover">
							<!--<caption>ROLE LIST</caption>-->


							<thead>
								<tr>
									<th scope="col">Article Title</th>
									<th scope="col">Article Description</th>
									<th scope="col">Logo</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="articleInstance" in="${articleInstanceList}">
									<tr>
										<td data-label="Title"><g:link controller="article" action="show" id="${articleInstance.id}" class="nameLink">${articleInstance.title}</g:link></td>
										<td data-label="Description"><g:link controller="article" action="show" id="${articleInstance.id}" class="nameLink">${articleInstance.description}</g:link></td>
										
										<td data-label="Logo">
											<g:if test="${articleInstance.logo}">
												<img src="${createLink (controller:'article' , action:'renderImage' , id:articleInstance.id)}" alt="bookLogo" height="75" width="75"/>
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
								<g:paginate controller="article" action="index" total="${articleInstanceCount}" />
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>

		

        <g:render template="/layouts/footer"/>
    </body>
</html>