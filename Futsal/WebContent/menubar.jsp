<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<title></title>
</head>
<body>
<c:choose>  
<c:when test="${sessionScope.user != null}"> <%-- check if user session is available --%>
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Admin Panel</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="admin.jsp">Home</a>
                <li><a href="Booking?action=check">Check Availability</a></li>

            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#about">You are logged in as ${sessionScope.user}</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</div>


</c:when>  
<c:otherwise>
Please login to access admin panel.
</c:otherwise>
</c:choose>

</body>
</html>