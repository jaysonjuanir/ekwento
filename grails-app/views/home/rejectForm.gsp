<g:form name="rejectForm" action="updateRejectAdminArticle">
<div class="modal-dialog">
<!-- Modal content-->
  <div class="modal-content">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<h4 class="modal-title">Reject this article?</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="reasonForReject" style="color : black;">Reason For Reject:</label>
			<%--<g:textField type="text" name = "user" value = "" class="form-control" id="email"/>--%>
			<input type="text" class="form-control" name="reasonForReject" id="reasonForReject" placeholder="Reason For Reject" required/>
		</div>
		<g:link controller="home" action="updateRejectAdminArticle" class="btn btn-success" id="${articleInstance.id}" params="${params}">Yes</g:link>
		<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
	</div>
	<div class="modal-footer">

	</div>
  </div>
</div>
</g:form>