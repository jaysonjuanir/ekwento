
<%@ page import="com.mmm.ekwento.Book" %>
<%@ page import="com.mmm.ekwento.Genre" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title>Latest Uploads List | e-Kwento - MMM</title>
    </head>
    <body id="page-top">
        <!-- HEADER -->
        <section class="header hris-section" id="contact" style="padding-top: 1px;">
			<div class="container">
				<div class="row tableDesign">
					<div class="col-md-12">
						<h2 class="caption">Latest Uploads List</h2>
						
						<div class="clearfix"></div>
						<div class="pagination" style="float:right;">
							<ul class="paginateButtons">
								<g:paginate controller="home" action="latestUploads" total="${latestGlobalCount}"/>
							</ul>
						</div>

						<table class="table-bordered table-hover">
							<thead>
								<tr>
									<th scope="col">Type</th>
									<th scope="col">Title</th>
									<th scope="col">Description</th>
									<th scope="col">Logo</th>
									<th scope="col">Date Created</th>
									<th scope="col">Views</th>
								</tr>
							</thead>
							<tbody>
								<g:each var="searchInstance" in="${latestGlobalList}">
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
											<td data-label="Date Created"><g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink"><g:formatDate format="MMMM dd, yyyy" date="${searchInstance.dateCreated}"/></g:link></td>
											<td data-label="Views"><g:link title="${searchInstance.description}" controller="book" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.numberOfViews}</g:link></td>
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
											<td data-label="Date Created"><g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink"><g:formatDate format="MMMM dd, yyyy" date="${searchInstance.dateCreated}"/></g:link></td>
											<td data-label="Views"><g:link title="${searchInstance.description}" controller="article" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.numberOfViews}</g:link></td>
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
											<td data-label="Date Created"><g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink"><g:formatDate format="MMMM dd, yyyy" date="${searchInstance.dateCreated}"/></g:link></td>
											<td data-label="Views"><g:link title="${searchInstance.description}" controller="manga" action="show" id="${searchInstance.id}" class="nameLink">${searchInstance.numberOfViews}</g:link></td>
										</g:elseif>
									</tr>
								</g:each>
							</tbody>
						</table>



						<div class="pagination" style="float:right;">

							<ul class="paginateButtons">
								<g:paginate controller="home" action="latestUploads" total="${latestGlobalCount}"/>
							</ul>
						</div>
					</div> <!--end of column-->
				</div> <!--end of row-->
			</div> <!--end of container-->
		</section>
        <g:render template="/layouts/footer"/>
    </body>
</html>