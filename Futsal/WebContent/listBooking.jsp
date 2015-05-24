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
<div class="col-md-9 first">
<table border="1" align="center" class="table table-bordered table-hover" width=50%>
		<tr><td colspan=6 align="center">
			<h1>Booking List</h1>
			<a href="Booking?action=add"><button class="btn btn-primary">Add Booking</button></a>
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
			<td align="center">${book.bookCourtId}</td>
			<td align="center">
			<a href="Booking?action=update&bookingid=${book.bookId}" style="text-decoration:none" title="Update the booking"><span class="label label-info">Update</span></a>
			<a href="Booking?action=delete&bookingid=${book.bookId}" style="text-decoration:none" title="Delete the booking"><span class="label label-warning">Delete</span></a>
			</td>
			</tr>
		</c:forEach>
</table>
</div>
<div class="col-md-3 second">
	<form action="Check" method="post">
	<table border="1" align="center" class="table table-bordered table-hover">
	<tr><td align="center"><h1>Check Availability</h1></td></tr>
	<tr><td align="center">
		
		Select date and time:
		
            <div class="form-group">
                <div class='input-group date' id='datetimepicker1'>
                    <input type='text' class="form-control" name="datetime" value="${currentdate}"/>
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
	<tr><td align="center">
	Select court:
	<select name="court" class="form-control">
	<c:forEach var="court" items="${courtlist}">
		<option value="${court.courtId}">${court.courtNum}</option>
	</c:forEach> 
	</select>
	</td></tr>
	<tr><td align="center"><input type="submit" value="Check" class="btn btn-primary"></td></tr>
	</table>
</form>
</div>
</div>
</div>
</body>
</html>