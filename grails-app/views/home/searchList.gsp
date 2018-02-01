
<%@ page import="com.mmm.ekwento.Book" %>
<%@ page import="com.mmm.ekwento.Genre" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title>Search Global List | e-Kwento - MMM</title>
    </head>
    <body id="page-top">
        <!-- HEADER -->
        <section class="header hris-section" id="contact" style="padding-top: 1px;">
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

						<h2 class="caption">Search List</h2>
						
						<div class="clearfix"></div>
						<div class="headerTableButtons">


							<div class="searchWrapper">
								<g:form controller="home" action="searchList" method="get" name="searchForm">
                                    
									<div class="form-input">
										<label for="input4" class="icon glyphicon glyphicon-pencil"></label>
										<button id="convert" class="button glyphicon glyphicon-search"></button>
										<input name="searchCriteria" type="text" class="input" value="${params.searchCriteria}">
									</div>
								</g:form>
							</div>

						</div>
						<div class="pagination" style="float:right;">
							<ul class="paginateButtons">
								<g:paginate controller="home" action="searchList" total="${searchGlobalCount}" params="${[searchCriteria:params.searchCriteria]}"/>
							</ul>
						</div>


						<table class="table-bordered table-hover">
							<!--<caption>ROLE LIST</caption>-->


							<thead>
								<tr>
									<th scope="col">Type</th>
									<th scope="col">Title</th>
									<th scope="col">Description</th>
									<th scope="col">Logo</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="searchInstance" in="${searchGlobalList}">
									<tr>
										<g:if test="${searchInstance.type=='book'}">
											<td data-label="Type"><g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.title}</g:link></td>
											<td data-label="ID"><g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.title}</g:link></td>
											<td data-label="Authority"><g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.description}</g:link></td>

											<td data-label="Logo">
												<g:if test="${searchInstance.logo}">
													<g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink"><img src="${createLink (controller:'book' , action:'renderImage' , id:searchInstance.id)}" alt="bookLogo" height="75" width="75"/></g:link>
												</g:if>
												<g:else>
													<g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
												</g:else>
											</td>
										</g:if>
										<g:elseif test="${searchInstance.type=='article'}">
											<td data-label="Type"><g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.title}</g:link></td>
											<td data-label="ID"><g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.title}</g:link></td>
											<td data-label="Authority"><g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.description}</g:link></td>

											<td data-label="Logo">
												<g:if test="${searchInstance.logo}">
													<g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink"><img src="${createLink (controller:'article' , action:'renderImage' , id:searchInstance.id)}" alt="articleLogo" height="75" width="75"/></g:link>
												</g:if>
												<g:else>
													<g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
												</g:else>
											</td>
										</g:elseif>
										<g:elseif test="${searchInstance.type=='manga'}">
											<td data-label="Type"><g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.title}</g:link></td>
											<td data-label="ID"><g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.title}</g:link></td>
											<td data-label="Authority"><g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.description}</g:link></td>

											<td data-label="Logo">
												<g:if test="${searchInstance.logo}">
													<g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink"><img src="${createLink (controller:'manga' , action:'renderImage' , id:searchInstance.id)}" alt="mangaLogo" height="75" width="75"/></g:link>
												</g:if>
												<g:else>
													<g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink"><g:img dir="images" file="ek.png" height="75" width="75"/></g:link>
												</g:else>
											</td>
										</g:elseif>
									</tr>
								</g:each>
							</tbody>
						</table>



						<div class="pagination" style="float:right;">

							<ul class="paginateButtons">
								<g:paginate controller="home" action="searchList" total="${searchGlobalCount}" params="${[searchCriteria:params.searchCriteria]}"/>
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>
        <g:render template="/layouts/footer"/>
    </body>
</html>