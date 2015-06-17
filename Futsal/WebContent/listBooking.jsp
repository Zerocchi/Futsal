<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Booking List</title>
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
		var court = document.getElementById('court').value;
		
		var data = {
				'start' : start,
				'end' : end,
				'court' : court,
		};
		
		$.ajax({
            url : 'Booking?action=checkboth',
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
	<div class="panel-heading" align="center">Booking List</div>
	<div class="panel-body" align="right"></div>
		<table align="center" class="table table-bordered table-hover" width=50%>
			<tr>
			<th style="text-align: center;">#</th>
			<th style="text-align: center;">Name</th>
			<th style="text-align: center;">Start</th>
			<th style="text-align: center;">End</th>
			<th style="text-align: center;">Court</th>
			<th style="text-align: center;">Actions</th>
			</tr>
			<c:if test="${empty bookinglist}"><tr><td colspan=6 align="center">There's no booking yet. You might want to <a href="Booking?action=add">add new booking</a>.</td></c:if>
			<c:forEach var="book" items="${bookinglist}">
				<tr>
				<td align="center">${book.bookId}</td>
				<td align="center">${book.bookName}</td>
				<td align="center"><fmt:formatDate value="${book.bookStart}" pattern="dd/MM/yyyy HH:mm" /></td>
				<td align="center"><fmt:formatDate value="${book.bookEnd}" pattern="dd/MM/yyyy HH:mm" /></td>
				<td align="center">${book.bookCourtId}</td>
				<td align="center">
				<a href="Booking?action=update&bookingid=${book.bookId}" style="text-decoration:none" title="Update the booking"><span class="label label-info">Update</span></a>
				<a href="Booking?action=delete&bookingid=${book.bookId}" style="text-decoration:none" title="Delete the booking" onclick="return confirm('Are you sure you want to delete this booking?')"><span class="label label-danger">Delete</span></a>
				</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
	
<div class="col-md-3 second">

	<%-- add booking button --%>
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Add Booking</div>
	<table align="center" class="table table-bordered table-hover">
		<tr><td><a href="Booking?action=add" style="text-decoration:none"><button class='btn btn-block btn-primary'><i class='fa fa-plus'></i> Add New Booking</button></a></td></tr>
	</table>
	</div>
	
	<%-- check availability section --%>
	<div class="panel panel-info">
	<div class="panel-heading" align="center">Check Court Availability</div>
	<div class="panel-body">
		<form action="Booking" method="get">
		<input type="hidden" name="action" value="checkboth">
		<table align="center" class="table table-bordered table-hover">
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
		<tr><td align="center">
		Select court:
		<select name="court" id="court" class="form-control">
		<c:forEach var="court" items="${courtlist}">
			<option value="${court.courtId}">${court.courtNum}</option>
		</c:forEach> 
		</select>
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