<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% pageContext.setAttribute("javax.servlet.jsp.jstl.fmt.fallbackLocale.page", java.util.Locale.US); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Booking List</title>
</head>
<body>
<jsp:include page="menubar.jsp" />
<div class="container">
<div class="jumbotron"></div>
<table border="1" align="center" class="table table-bordered table-hover" width=50%>
		<tr><td colspan=6 align="center">
			<h1>Booking List</h1>
			<a href="Booking?action=add">Add Booking</a>
		</td></tr>
		<tr>
		<th style="text-align: center;">#</th>
		<th style="text-align: center;">Name</th>
		<th style="text-align: center;">Start</th>
		<th style="text-align: center;">End</th>
		<th style="text-align: center;">Court</th>
		<th style="text-align: center;">Actions</th>
		</tr>
		<c:forEach var="book" items="${bookinglist}">
			<tr>
			<td align="center">${book.bookId}</td>
			<td align="center">${book.bookName}</td>
			<td align="center"><fmt:formatDate value="${book.bookStart}" pattern="dd/MM/yyyy HH:mm" /></td>
			<td align="center"><fmt:formatDate value="${book.bookEnd}" pattern="dd/MM/yyyy HH:mm" /></td>
			<td align="center">${book.bookCourt}</td>
			<td align="center">
			<a href="Booking?action=update&bookingid=${book.bookId}" style="text-decoration:none"><span class="label label-info">Update</span></a>
			<a href="Booking?action=delete&bookingid=${book.bookId}" style="text-decoration:none"><span class="label label-warning">Delete</span></a>
			</td>
			</tr>
		</c:forEach>
</table>
</div>
</body>
</html>