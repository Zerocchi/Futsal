<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% pageContext.setAttribute("javax.servlet.jsp.jstl.fmt.fallbackLocale.page", java.util.Locale.US); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Event List</title>
<link rel="stylesheet" type="text/css" media="screen" href="bootstrap/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/moment/moment.js"></script>
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script> 
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.min.js"></script>
</head>
<body>
<jsp:include page="menubar.jsp" />
<div class="container">
<div class="jumbotron"></div>


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

<!-- Court availability modal -->
<div id="availableModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Court Availability</h4>
      </div>
      <div class="modal-body">
        <div class="available" id="available" align="center"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<div class="row">
	<div class="col-md-9 first">
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Event List</div>
	<div class="panel-body" align="center"></div>
		<table align="center" class="table table-bordered table-hover" width=50%>
				<tr>
				<th style="text-align: center;">#</th>
				<th style="text-align: center;">Name</th>
				<th style="text-align: center;">Start</th>
				<th style="text-align: center;">End</th>
				<th style="text-align: center;">Actions</th>
				</tr>
				<c:if test="${empty eventlist}"><tr><td colspan=6 align="center">There's no event yet. You might want to <a href="Event?action=add">add new event</a>.</td></c:if>
				<c:forEach var="event" items="${eventlist}">
					<tr>
					<td align="center">${event.eventId}</td>
					<td align="center">${event.eventName}</td>
					<td align="center"><fmt:formatDate value="${event.eventStart}" pattern="dd/MM/yyyy HH:mm" /></td>
					<td align="center"><fmt:formatDate value="${event.eventEnd}" pattern="dd/MM/yyyy HH:mm" /></td>
					<td align="center">
					<a href="Event?action=update&eventid=${event.eventId}" style="text-decoration:none" title="Update the event"><span class="label label-info">Update</span></a>
					<a href="Event?action=delete&eventid=${event.eventId}" style="text-decoration:none" title="Delete the event" onclick="return confirm('Are you sure you want to delete this booking?')"><span class="label label-warning">Delete</span></a>
					</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	</div>
	
	<div class="col-md-3 second">
	
	<%-- add event button --%>
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Add Event</div>
	<table align="center" class="table table-bordered table-hover">
		<tr><td><a href="Event?action=add" style="text-decoration:none"><button class='btn btn-block btn-primary'><i class='fa fa-plus'></i> Add New Event</button></a></td></tr>
	</table>
	</div>
	
	<%-- check availability section --%>
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Check Court Availability</div>
	<div class="panel-body">
		<form action="Event" method="get">
		<input type="hidden" name="action" value="check">
		<input type="hidden" name="court" value="1">
		<table border="1" align="center" class="table table-bordered table-hover">
		<tr><td align="center">
		
		Enter date and time: <br />
	
	<%-- start time --%>
	<div class='input-group date' id='datetimepickerstart'>
        <input type='text' class="form-control" name="start" id="start" placeholder="Start time" value="<fmt:formatDate value="${currentdate}" pattern="dd/MM/yyyy HH:mm" />" required/>
        <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
        </span>
    </div>
	<%-- end time --%>
	<div class='input-group date' id='datetimepickerend'>
       <input type='text' class="form-control" name="end" id="end" placeholder="End time" value="<fmt:formatDate value="${currentdate}" pattern="dd/MM/yyyy HH:mm" />" required/>
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
		<tr><td align="center"><input type="button" onclick="checkAvailable()" data-toggle="modal" data-target="#availableModal" value="Check" class="btn btn-success"></td></tr>
		</table>
	</form>
	</div>
	</div>
	
</div>
</div>
</div>
</body>
</html>