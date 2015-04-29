<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Spring 4 WebSocket demo</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="resources/css/demo.css">
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/sockjs-0.3.4.js"></script>
<script src="resources/js/stomp.js"></script>
<script type="text/javascript">
        var stompClient = null; 
        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('calculationDiv').style.visibility = connected ? 'visible' : 'hidden';
        }
        function connect() {
            var socket = new SockJS('/demoPush');
			stompClient = Stomp.over(socket);
            stompClient.connect({}, function(frame) {
                setConnected(true);
                console.log('Connected: ' + frame);
                 stompClient.subscribe('/topic/showResult/Dimond', function(calResult){
                	 showResultDimond(JSON.parse(calResult.body));
                }); 
                 stompClient.subscribe('/topic/showResult/Gold', function(calResult){
                	 showResultGold(JSON.parse(calResult.body));
                }); 
                 stompClient.subscribe('/topic/showResult/Silver', function(calResult){
                	 showResultSilver(JSON.parse(calResult.body));
                });              
            });
        }

        function disconnect() {
            stompClient.disconnect();
            setConnected(false);
            console.log("Disconnected");
        }

        function sendNum() {
            stompClient.send("/demoApp/demoPush/Dimond", {}, JSON.stringify({ 'type': 'Dimond' }));
            stompClient.send("/demoApp/demoPush/Gold", {}, JSON.stringify({ 'type': 'Gold' }));
            stompClient.send("/demoApp/demoPush/Silver", {}, JSON.stringify({ 'type': 'Silver' }));
        }
        function showResultDimond(message) {
           $("div#sectionA").html("<h3>"+ message.name +"</h3><p> Branch : "+message.branch +"</br> Coverage : "+ message.coverage +"</br> Type : "+message.type +"</br> Amount : "+message.amount+"</p></div>");
           $("li#secA a").text(message.name +" "+ message.amount);
           $("li#secA").removeClass("hidden");
        }
        function showResultGold(message) {
           $("div#sectionB").html("<h3>"+ message.name +"</h3><p> Branch : "+message.branch +"</br> Coverage : "+ message.coverage +"</br> Type : "+message.type +"</br> Amount : "+message.amount+"</p></div>");
           $("li#secB a").text(message.name +" "+ message.amount);
           $("li#secB").removeClass("hidden");
        }
        function showResultSilver(message) {
           $("div#sectionC").html("<h3>"+ message.name +"</h3><p> Branch : "+message.branch +"</br> Coverage : "+ message.coverage +"</br> Type : "+message.type +"</br> Amount : "+message.amount+"</p></div>");
           $("li#secC a").text(message.name +" "+ message.amount);
           $("li#secC").removeClass("hidden");
        }
</script>
<script type="text/javascript">
$(document).ready(function(){ 
    $("#myTab li:eq(0) a").tab('show');
});
</script>
</head>
<body>
<noscript><h2>Enable Java script and reload this page to run Websocket Demo</h2></noscript>
<h1>Spring 4 WebSocket Demo</h1>
<div class="bs-example">
	<div>
	    <div>
	        <button id="connect" onclick="connect();">Connect</button>
	        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button><br/><br/>
	    </div>
	    <div id="calculationDiv">
	    	<br>
	        <button id="sendNum" onclick="sendNum();">Get Quote</button>
	    </div>
	</div>
	<br>
    <ul class="nav nav-tabs" id="myTab">
        <li id=secA class="hidden"><a data-toggle="tab" href="#sectionA">Section A</a></li>
        <li id=secB class="hidden"><a data-toggle="tab" href="#sectionB">Section B</a></li>
        <li id=secC class="hidden"><a data-toggle="tab" href="#sectionC">Section C</a></li>
    </ul>
    <div class="tab-content">
        <div id="sectionA" class="tab-pane fade in active">
        </div>
        <div id="sectionB" class="tab-pane fade">
        </div>
        <div id="sectionC" class="tab-pane fade">
        </div>
    </div>
</div>
</body>
</html>