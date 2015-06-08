<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% pageContext.setAttribute("javax.servlet.jsp.jstl.fmt.fallbackLocale.page", java.util.Locale.US); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Event List</title>
<link rel="stylesheet" type="text/css" media="screen" href="bootstrap/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="bootstrap/moment/moment.js"></script>
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script> 
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.min.js"></script>
</head>
<body>
<jsp:include page="menubar.jsp" />
<div class="container">
<div class="jumbotron"></div>

<%-- Court availability --%>
<c:if test="${not empty court}">
<div class="alert alert-warning">
	<a href="#" class="close" data-dismiss="alert">&times;</a>
		Court ${court} during <fmt:formatDate value="${datetime}" pattern="dd/MM/yyyy HH:mm" /> is <c:out value="${status? 'available' :'not available'}"/>
</div>
</c:if>

<div class="row">
	<div class="col-md-9 first">
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Event List</div>
	<div class="panel-body" align="center">You might want to <a href="Event?action=add">add new event</a></div>
		<table align="center" class="table table-bordered table-hover" width=50%>
				<tr>
				<th style="text-align: center;">#</th>
				<th style="text-align: center;">Name</th>
				<th style="text-align: center;">Start</th>
				<th style="text-align: center;">End</th>
				<th style="text-align: center;">Actions</th>
				</tr>
				<c:forEach var="event" items="${eventlist}">
					<tr>
					<td align="center">${event.eventId}</td>
					<td align="center">${event.eventName}</td>
					<td align="center"><fmt:formatDate value="${event.eventStart}" pattern="dd/MM/yyyy HH:mm" /></td>
					<td align="center"><fmt:formatDate value="${event.eventEnd}" pattern="dd/MM/yyyy HH:mm" /></td>
					<td align="center">
					<a href="Event?action=update&eventid=${event.eventId}" style="text-decoration:none" title="Update the event"><span class="label label-info">Update</span></a>
					<a href="Event?action=delete&eventid=${event.eventId}" style="text-decoration:none" title="Delete the event"><span class="label label-warning">Delete</span></a>
					</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	</div>
	
	<div class="col-md-3 second">
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Check Court Availability</div>
	<div class="panel-body">
		<form action="Event" method="get">
		<input type="hidden" name="action" value="check">
		<input type="hidden" name="court" value="1">
		<table border="1" align="center" class="table table-bordered table-hover">
		<tr><td align="center">
			
			Select date and time:
			
	            <div class="form-group">
	                <div class='input-group date' id='datetimepicker1'>
	                    <input type='text' class="form-control" name="datetime" value="<fmt:formatDate value="${datetime}" pattern="dd/MM/yyyy HH:mm" />" required/>
	                    <span class="input-group-addon">
	                        <span class="glyphicon glyphicon-calendar"></span>
	                    </span>
	                </div>
	            </div>
	        <script type="text/javascript">
	            $(function () {
	                $('#datetimepicker1').datetimepicker({
	                	showTodayButton: true,
	                	format: "DD/MM/YYYY HH:mm"
	                });
	            });
	        </script>
			
		</td></tr>
		<tr><td align="center"><input type="submit" value="Check" class="btn btn-primary"></td></tr>
		</table>
	</form>
	</div>
	</div>
	
</div>
</div>
</div>
</body>
</html>