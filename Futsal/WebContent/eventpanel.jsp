<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Manage event</title>
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
<div class="col-md-3 first"></div>
<div class="col-md-6 second">

<!-- checkAvailable() -->
<script type='text/javascript'>
	
	function checkAvailable(){
		 
		var start = document.getElementById('start').value;
		var end = document.getElementById('end').value;
		
		var data = {
				'start' : start,
				'end' : end
		};
		
		$.ajax({
            url : 'Event?action=checkboth',
            data : data, 
            type : 'GET',
            dataType : 'html', 
            success : function(response) {
                $('#available').html(response);
            },
            error : function(request, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
	}
	
</script>

<form action="Event" method="post">
	<input type="hidden" name="eventid" value="${eventinfo.eventId}">
	<table border="1" align="center" class="table table-bordered table-hover">
	<tr><td colspan=2 align="center"><h1>Event</h1></td></tr>
	<tr><td>Event Name:</td><td><input type="text" name="name" value="${eventinfo.eventName}" required/></td></tr>
	<tr><td>Event Time:</td>
	<td align="center">
	
	<%-- start time --%>
	<div class='input-group date' id='datetimepickerstart'>
        <input type='text' class="form-control" name="start" id="start" placeholder="Start time" value="<fmt:formatDate value="${currenttime}" pattern="dd/MM/yyyy HH:mm" />" required/>
        <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
        </span>
    </div>
	<%-- end time --%>
	<div class='input-group date' id='datetimepickerend'>
       <input type='text' class="form-control" name="end" id="end" placeholder="End time" value="<fmt:formatDate value="${currenttime}" pattern="dd/MM/yyyy HH:mm" />" required/>
       <span class="input-group-addon">
           <span class="glyphicon glyphicon-calendar"></span>
       </span>
    </div>
    
	<script type="text/javascript">
	    $(function () {
	        $('#datetimepickerstart').datetimepicker({
            	showTodayButton: true,
            	format: "DD/MM/YYYY HH:mm"
            });
	        $('#datetimepickerend').datetimepicker({
            	showTodayButton: true,
            	format: "DD/MM/YYYY HH:mm"
            });
	        $("#datetimepickerstart").on("dp.change", function (e) {
	            $('#datetimepickerend').data("DateTimePicker").minDate(e.date);
	        });
	        $("#datetimepickerend").on("dp.change", function (e) {
	            $('#datetimepickerstart').data("DateTimePicker").maxDate(e.date);
	        });
	    });
	</script>
	</td></tr>
	<tr><td>Court</td><td><em>All courts are closed to public during event.</em></td>
	</tr>
	<tr><td colspan="2" align="center">
	<a href="event.jsp"><input type="button" value="Cancel" class="btn btn-danger"></a>
	<input type="button" onclick="checkAvailable()" value="Check" class="btn btn-success">
	<input type="submit" onclick="return confirm('Are you sure you want to submit?')" value="Submit" class="btn btn-primary"></td></tr>
	</table>
</form>
<div class="available" id="available" align="center"></div>
</div>
<div class="col-md-3 third"></div>
</div>
</div>
</body>
</html>