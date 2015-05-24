<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Availability</title>
</head>
<body>
Court ${court} during <fmt:formatDate value="${datetime}" pattern="dd/MM/yyyy HH:mm" /> is <c:out value="${status? 'available' :'not available'}"/>
<br /><a href="admin.jsp">Back</a>
</body>
</html>