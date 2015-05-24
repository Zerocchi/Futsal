<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
<p align="center"><jsp:include page="menubar.jsp" /></p>
<form action="Login" method="post">
	<table border="1" align="center">
	<tr><td colspan=2 align="center"><h1>Log In</h1></td></tr>
	<tr><td>Username:</td><td><input type="text" name="username"></td></tr>
	<tr><td>Password:</td><td><input type="password" name="password"></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="Submit"></td></tr>
	</table>
</form>
</body>
</html>