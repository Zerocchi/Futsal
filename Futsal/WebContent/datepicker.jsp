<!DOCTYPE html> 
<html lang="en"> 
<head> 
<meta charset="utf-8"> 
<title>jQuery AJAX form submit using twitter bootstrap modal</title> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<link href="http://www.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap-combined.min.css" rel="stylesheet"> 
<script src="http://www.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="http://tarruda.github.com/bootstrap-datetimepicker/assets/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script> 
<script type="text/javascript" src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://tarruda.github.com/bootstrap-datetimepicker/assets/js/bootstrap-datetimepicker.min.js"></script>
</head>
<body>
<div class="container">
<h4>Demo Page</h4>
	<div id="thanks"><p><a data-toggle="modal" href="#form-content" class="btn btn-primary">Check Availability</a></p></div>
	
	<!-- model content -->	
	<div id="form-content" class="modal hide fade in" style="display: none; ">
	        <div class="modal-header">
	              <a class="close" data-dismiss="modal">×</a>
	              <h3>Check Availability</h3>
	        </div>
	<div>
	
	<form class="check">
	<fieldset>
    <div class="modal-body">
   	<ul class="nav nav-list">
	<li class="nav-header">Date</li>
	<li>
	
	<%-- date and time field --%>
	<div id="datetimepicker" class="input-append date">
      <input type="text" name="datetime" readonly></input>
      <span class="add-on">
        <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
      </span>
    </div>
    
   <%-- DatePicker JQuery --%>
	<script type="text/javascript">
	    $('#datetimepicker').datetimepicker({
	      format: 'dd/MM/yyyy hh:mm',
	      language: 'en',
	      pick12HourFormat: true
	    });
	</script>
	</li>
	<li><div id="thanks"></div></li>
	</ul> 
	</div>
	</fieldset>
	</form>
	</div>
    <div class="modal-footer">
        <button class="btn btn-success" id="submit">Check</button>
        <a href="#" class="btn" data-dismiss="modal">Close</a>
  	</div>
	</div>
 </div>
 
 
<script>
 $(function() {
//twitter bootstrap script
	$("button#submit").click(function(){
	   $.ajax({
    	   type: "POST",
	url: "Check",
	data: $('form.check').serialize(),
        	success: function(msg){
           	  $("#thanks").html(msg)	
         },
	error: function(){
	alert("failure");
	}
      	});
	});
});
</script>

</body>
</html>