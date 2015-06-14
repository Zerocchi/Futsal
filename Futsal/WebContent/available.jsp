<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("javax.servlet.jsp.jstl.fmt.fallbackLocale.page", java.util.Locale.US); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Booking List</title>
<link rel="stylesheet" type="text/css" media="screen" href="bootstrap/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="bootstrap/moment/moment.js"></script>
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script> 
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.min.js"></script>
</head>
<body>
<c:if test="${not empty status}">
<div class="alert alert-danger">
	<a href="#" class="close" data-dismiss="alert">&times;</a>
		Court ${court} is <c:out value="${status? 'available' :'not available'}"/> at the selected date/time.
</div>
</c:if>
<c:if test="${not empty booking}">
<c:forEach var="book" items="${booking}">
<div class="alert alert-danger">
	<a href="#" class="close" data-dismiss="alert">&times;</a>
There is a match at court ${book.bookCourtId} from <fmt:formatDate value="${book.bookStart}" pattern="dd/MM/yyyy HH:mm" /> 
until <fmt:formatDate value="${book.bookEnd}" pattern="dd/MM/yyyy HH:mm" /> 
</div>
</c:forEach>
</c:if>
<c:if test="${not empty event}">
<c:forEach var="event" items="${event}">
<div class="alert alert-danger">
	<a href="#" class="close" data-dismiss="alert">&times;</a>
There is an event from <fmt:formatDate value="${event.eventStart}" pattern="dd/MM/yyyy HH:mm" /> 
until <fmt:formatDate value="${event.eventEnd}" pattern="dd/MM/yyyy HH:mm" /> 
</div>
</c:forEach>
</c:if>
</body>
</html>