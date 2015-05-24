<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logout...</title>
</head>
<body>
<c:choose>  
<c:when test="${sessionScope.user != null}"> <%-- check if user session is available --%>
<jsp:forward page="/Logout" /> <%-- forward to logout servlet --%>
</c:when>  
<c:otherwise>
<jsp:forward page="login.jsp" />
</c:otherwise>
</c:choose>
</body>
</html>