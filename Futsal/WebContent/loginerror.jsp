<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login error!</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script> 
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="row">
<div class="col-md-2"></div>
<div class="col-md-8"> 
<div class="alert alert-warning">

        <a href="#" class="close" data-dismiss="alert">&times;</a>

        <strong>Warning!</strong> Wrong credentials. Please try again..

    </div>

</div>
</div>
<jsp:include page="login.jsp" /> <%-- forward to login servlet --%>
</body>
</html>