<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% pageContext.setAttribute("javax.servlet.jsp.jstl.fmt.fallbackLocale.page", java.util.Locale.US); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dashboard</title>
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
	
	<div class="row">
		<div class="col-md-12">
			
			<c:choose>
			<c:when test="${not empty currentbooking}">
				<c:forEach var="currentbook" items="${currentbooking}">
					<div class="alert alert-warning">
		        	<a href="#" class="close" data-dismiss="alert">&times;</a>
					<strong>Notice:</strong> ${currentbook.bookName} is live now at court
					${currentbook.bookCourtId} until <fmt:formatDate value="${currentbook.bookEnd}" pattern="HH:mm" />
		   			 </div>
		   		</c:forEach>
   			 </c:when>
   			 <c:when test="${not empty currentevent}">
				<c:forEach var="currentevent" items="${currentevent}">
					<div class="alert alert-danger">
		        	<a href="#" class="close" data-dismiss="alert">&times;</a>
					<strong>Event:</strong> ${currentevent.eventName} is currently held now until 
					<fmt:formatDate value="${currentevent.eventEnd}" pattern="dd/MM/yyyy HH:mm" />
		   			 </div>
		   		</c:forEach>
   			 </c:when>
   			</c:choose>
   			
		</div>
	</div>	
	
	<div class="row">
		
		<div class="col-md-9">
			
		<table border="1" align="center" class="table table-bordered table-hover" width=50%>
		<tr><td colspan=6 align="center">
			<h1>Welcome Admin!</h1>
		</td></tr>
		<tr><td align="center" colspan="3">What would you like to do?</td></tr>
			<tr>
			<td align="center"><a href="Booking?action=add"><button class="btn btn-primary">Add Booking</button></a></td>
			<td align="center"><a href="Event?action=add"><button class="btn btn-primary">Add Event</button></a></td>
			<td align="center">Check Availability</td>
		</tr>
		</table>
		
		</div>
		
		<div class="col-md-3">
		
			<%-- Court status --%>
			<div class="panel panel-default">
			<table border="1" align="center" class="table table-bordered table-hover">
			<tr><td colspan="2" align="center"><strong>Current Status</strong></td></tr>
			<tr>
				<th style="text-align: center;">Court</th>
				<th style="text-align: center;">Status</th>
			</tr>
			<tr>
				<td align="center">Court 1</td>
				<td align="center">${court1? '<font color="green">Available</font>' :'<font color="red">Not available</font>'}</td>
			</tr>
			<tr>
				<td align="center">Court 2</td>
				<td align="center">${court2? '<font color="green">Available</font>' :'<font color="red">Not available</font>'}</td>
			</tr>
			</table>
			</div>
			
			<%-- Upcoming matches --%>
			<div class="panel panel-default">
			<table border="1" align="center" class="table table-bordered table-hover">
			<tr><td colspan="3" align="center"><strong>Upcoming Matches</strong></td></tr>
			<tr>
				<th style="text-align: center;">Name</th>
				<th style="text-align: center;">Start</th>
				<th style="text-align: center;">Court</th>
			</tr>
			<c:if test="${empty bookinglist}"><tr><td colspan="3" align="center">No upcoming matches.</td></tr></c:if>
			<c:forEach var="book" items="${bookinglist}">
			<tr>
				<td align="center">${book.bookName}</td>
				<td align="center"><fmt:formatDate value="${book.bookStart}" pattern="dd/MM HH:mm" /></td>
				<td align="center">${book.bookCourtId}</td>
			</tr>
			</c:forEach>
			<tr><td align="right" colspan="3"><a href="booking.jsp">View all bookings >>></a></td></tr>
			<tr>
			</table>
			</div>
			
			<%-- Upcoming events --%>
			<div class="panel panel-default">
			<table border="1" align="center" class="table table-bordered table-hover">
			<tr><td colspan="2" align="center"><strong>Upcoming Events</strong></td></tr>
			<tr>
				<th style="text-align: center;">Name</th>
				<th style="text-align: center;">Start</th>
			</tr>
			<c:if test="${empty eventlist}"><tr><td colspan="2" align="center">No upcoming event.</td></tr></c:if>
			<c:forEach var="event" items="${eventlist}">
			<tr>
				<td align="center">${event.eventName}</td>
				<td align="center"><fmt:formatDate value="${event.eventStart}" pattern="dd/MM HH:mm" /></td>
			</tr>
			</c:forEach>
			<tr><td align="right" colspan="2"><a href="event.jsp">View all events >>></a></td></tr>
			<tr>
			</table>
			</div>
			
		</div>
		
	</div>
</div>
</body>
</html>