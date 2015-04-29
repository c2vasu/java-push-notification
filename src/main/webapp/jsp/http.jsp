<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Classic HTTP demo</title>
<link rel="stylesheet" href="resources/css/demo.css">
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function getQuoteClassicHttp(){
		$("div").addClass("modal");
		if(typeof(EventSource) !== "undefined") {
			console.log("Event source available - Classic Http");
		   	var source = new EventSource('/classicHttp');
		   	source.addEventListener('message', function(e) {
	  			var data = JSON.parse(e.data);
	  			$("div").removeClass("modal");
	  			document.getElementById("output").innerHTML = "<b>Amount :</b>"+data.amount+ "</br>"+"<b>Branch :</b>"+data.branch+ "</br>"+"<b>Type :</b>"+data.type+ "</br>"+"<b>Coverage :</b>"+data.coverage+ "</br>"+"<b>Name :</b>"+data.name+ "</br>"+"</br></br>"+"<b>Amount :</b>"+data.amount+ "</br>"+"<b>Branch :</b>"+data.branch+ "</br>"+"<b>Type :</b>"+data.type+ "</br>"+"<b>Coverage :</b>"+data.coverage+ "</br>"+"<b>Name :</b>"+data.name+ "</br>"+"</br></br>"+"<b>Amount :</b>"+data.amount+ "</br>"+"<b>Branch :</b>"+data.branch+ "</br>"+"<b>Type :</b>"+data.type+ "</br>"+"<b>Coverage :</b>"+data.coverage+ "</br>"+"<b>Name :</b>"+data.name+ "</br>";
		   });
	
		   source.addEventListener('open', function(e) {
		        console.log("Connection was opened.");

		   }, false);
		   
		   source.addEventListener('error', function(e) {
		        if (e.readyState == EventSource.CLOSED) {
		            console.log("Connection was closed.");
		        } else {
		            console.log(e.readyState);   
		        }
		   }, false);
		   
		}else{
			 console.log("No notification feature available");
		}
	}
</script>
</head>
<body>
<noscript><h2>Enable Java script and reload this page to run this Demo</h2></noscript>
<h1>Classic HTTP Demo</h1>

<div>
	<button onclick="getQuoteClassicHttp()">Get Quote</button>
	
	<div id="output">
	<!-- content updated here -->
	</div>
</div>


</body>
</html>