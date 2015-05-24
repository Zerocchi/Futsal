<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Check Availability</title>

<link rel="stylesheet" type="text/css" media="screen" href="bootstrap/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="bootstrap/moment/moment.js"></script>
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script> 
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.min.js"></script>

</head>
<body>

<p align="center"><jsp:include page="menubar.jsp" /></p>

<div class="container">

<div class="jumbotron"></div>
<div class="row">
<div class="col-md-4 first"></div>
<div class="col-md-4 second">
<form action="Check" method="post">
	<table border="1" align="center" class="table table-bordered table-hover">
	<tr><td align="center"><h1>Check Availability</h1></td></tr>
	<tr><td align="center">
		
		Select date and time:
		
            <div class="form-group">
                <div class='input-group date' id='datetimepicker1'>
                    <input type='text' class="form-control" name="datetime" />
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
<div class="col-md-4 third"></div>
</div>
</div>
</body>
</html>