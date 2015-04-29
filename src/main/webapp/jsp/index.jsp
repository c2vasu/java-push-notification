<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notification</title>
<script src="resources/jquery.min.js"></script>
<script type="text/javascript">
function start(){
	if(typeof(EventSource) !== "undefined") {
		 console.log("Event source available");
	   var source = new EventSource('/push');
	   source.addEventListener('message', function(e) {
	        console.log(e.data);
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

	function getQuoteClassicHttp(){
		$("div").addClass("modal");
		if(typeof(EventSource) !== "undefined") {
			 console.log("Event source available - Classic Http");
		   var source = new EventSource('/classicHttp');
		   source.addEventListener('message', function(e) {
	  			var data = JSON.parse(e.data);
	  			console.log(data.amount);
	  			console.log(data.branch);
	  			console.log(data.type);
	  			console.log(data.coverage);
	  			console.log(data.name);
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
	
	function getQuoteServerSentEvents(){
		$("div").addClass("modal");
		if(typeof(EventSource) !== "undefined") {
			 console.log("Event source available - Server Sent Events");
		   var source = new EventSource('/serverSentEvents');
		   source.addEventListener('message', function(e) {
	  			var data = JSON.parse(e.data);
	  			console.log(data.amount);
	  			console.log(data.branch);
	  			console.log(data.type);
	  			console.log(data.coverage);
	  			console.log(data.name);
	  			$("div").removeClass("modal");
	  			document.getElementById("output").innerHTML =document.getElementById("output").innerHTML+ "</br>" + "<b>Amount :</b>"+data.amount+ "</br>"+"<b>Branch :</b>"+data.branch+ "</br>"+"<b>Type :</b>"+data.type+ "</br>"+"<b>Coverage :</b>"+data.coverage+ "</br>"+"<b>Name :</b>"+data.name+ "</br>";
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

function getQuote(){
	if(typeof(EventSource) !== "undefined") {
		 console.log("Event source available");
	   var source = new EventSource('/pushQuote');
	   source.addEventListener('message', function(e) {
	   		var data = JSON.parse(e.data);
  			console.log(data.msg);
	    	console.log('in');
	        console.log(e.data.quoteType);
	        console.log(e.quoteType);
	        console.log('out');
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

<style type="text/css">
	/* Start by setting display:none to make this hidden.
	   Then we position it in relation to the viewport window
	   with position:fixed. Width, height, top and left speak
	   speak for themselves. Background we set to 80% white with
	   our animation centered, and no-repeating */
	.modal {
	    display:    block;
	    position:   fixed;
	    z-index:    1000;
	    top:        0;
	    left:       0;
	    height:     100%;
	    width:      100%;
	    background: rgba( 255, 255, 255, .8 ) 
	                url('http://i.stack.imgur.com/FhHRx.gif') 
	                50% 50% 
	                no-repeat;
	}
	
	/* When the body has the loading class, we turn
	   the scrollbar off with overflow:hidden */
	body.loading {
	    overflow: hidden;   
	}
	
	/* Anytime the body has the loading class, our
	   modal element will be visible */
	body.loading .modal {
	    display: block;
	}
</style>
</head>
<body>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button onclick="getQuoteClassicHttp()">Classic Http</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button onclick="getQuoteServerSentEvents()">Server Sent Events</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


<div id="output">
	<!-- Place at bottom of page -->
	
</div>

</body>
</html>