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
			
			<div class="alert alert-warning">
        		<a href="#" class="close" data-dismiss="alert">&times;</a>
				<strong>Notice:</strong> Please read guide if you are confused.
   			 </div>
   			
		</div>
	</div>	
	
	<div class="row">
		
		<div class="col-md-9">
		
		<div class="panel panel-info">
		<div class="panel-heading" align="center">Welcome!</div>
		<div class="panel-body">
		Welcome to the dashboard! To begin, <a href="Booking?action=add">book the court</a> or <a href="Event?action=add">
		add an event.</a>
		</div>
		</div>
		
		<div class="row">
		
			<div class="col-md-6">
			
				<%-- Upcoming matches --%>
				<div class="panel panel-success">
				<div class="panel-heading" align="center">Upcoming Matches</div>
				<table align="center" class="table table-bordered table-hover">
				<tr>
					<th style="text-align: center;">Name</th>
					<th style="text-align: center;">Start</th>
					<th style="text-align: center;">Court</th>
				</tr>
				<c:if test="${empty bookinglist}"><tr><td colspan="3" align="center">No upcoming matches.</td></tr></c:if>
				<c:forEach var="book" items="${bookinglist}">
				<tr>
					<td align="center">${book.bookName}</td>
					<td align="center"><fmt:formatDate value="${book.bookStart}" pattern="dd/MM/yyyy HH:mm" /></td>
					<td align="center">${book.bookCourtId}</td>
				</tr>
				</c:forEach>
				</table>
				<div class="panel-footer" align="right"><a href="booking.jsp">View all bookings &#x203a;&#x203a;</a></div>
				</div>
			
			</div>
			
			<div class="col-md-6">
			
				<%-- Upcoming events --%>
				<div class="panel panel-success">
				<div class="panel-heading" align="center">Upcoming Events</div>
				<table align="center" class="table table-bordered table-hover">
				<tr>
					<th style="text-align: center;">Name</th>
					<th style="text-align: center;">Start</th>
				</tr>
				<c:if test="${empty eventlist}"><tr><td colspan="2" align="center">No upcoming event.</td></tr></c:if>
				<c:forEach var="event" items="${eventlist}">
				<tr>
					<td align="center">${event.eventName}</td>
					<td align="center"><fmt:formatDate value="${event.eventStart}" pattern="dd/MM/yyyy HH:mm" /></td>
				</tr>
				</c:forEach>
				</table>
				<div class="panel-footer" align="right"><a href="event.jsp">View all events &#x203a;&#x203a;
				</a></div>
				</div>
			</div>
		
		</div>
		</div>
		
		<div class="col-md-3">
		
			<%-- Court status --%>
			<div class="panel panel-primary">
			<div class="panel-heading" align="center">Current Status</div>
			<table align="center" class="table">
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
		
			<%-- Now playing --%>
			<div class="panel panel-primary">
			<div class="panel-heading" align="center">Now Playing</div>
			<table align="center" class="table">
			<c:if test="${empty currentbooking && empty currentevent}"><tr><td align="center">No match or event.</td></tr></c:if>
			<c:choose>
			<c:when test="${not empty currentbooking}">
			<c:forEach var="currentbook" items="${currentbooking}">
				<tr><td>Type</td><td>Match</td></tr>
				<tr><td>Name</td><td>${currentbook.bookName}</td></tr>
				<tr><td>Court</td><td>${currentbook.bookCourtId}</td>
				<tr><td>Start</td><td><fmt:formatDate value="${currentbook.bookStart}" pattern="dd/MM/yyyy HH:mm" /></td>
				<tr><td>End</td><td><fmt:formatDate value="${currentbook.bookEnd}" pattern="dd/MM/yyyy HH:mm" /></td>
				<tr><td colspan="2" class="divider" align="right"><a href="Booking?action=update&bookingid=${currentbook.bookId}">Edit this match &#x203a;&#x203a;</a></td></tr>
			</c:forEach>
			</c:when>
			<c:when test="${not empty currentevent}">
			<c:forEach var="currentevent" items="${currentevent}">
				<tr><td>Type</td><td>Event</td></tr>
				<tr><td>Name</td><td>${currentevent.eventName}</td></tr>
				<tr><td>Court</td><td>All courts</td>
				<tr><td>Start</td><td><fmt:formatDate value="${currentevent.eventStart}" pattern="dd/MM/yyyy HH:mm" /></td>
				<tr><td>End</td><td><fmt:formatDate value="${currentevent.eventEnd}" pattern="dd/MM/yyyy HH:mm" /></td>
			</c:forEach>
			</c:when>
			</c:choose>
			</table>
			</div>
			
		</div>
	</div>
</div>
</body>
</html>