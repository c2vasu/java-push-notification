<!DOCTYPE html>
<html>
<head>
    <title>Calculator App Using Spring 4 WebSocket</title>
    <script src="resources/sockjs-0.3.4.js"></script>
    <script src="resources/stomp.js"></script>
    <script type="text/javascript">
	
        var stompClient = null; 
		var stompClient1 = null; 
        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('calculationDiv').style.visibility = connected ? 'visible' : 'hidden';
            document.getElementById('calResponse').innerHTML = '';
        }
        function setConnected1(connected) {
            //document.getElementById('connect').disabled = connected;
            //document.getElementById('disconnect').disabled = !connected;
            //document.getElementById('calculationDiv').style.visibility = connected ? 'visible' : 'hidden';
            document.getElementById('calResponse1').innerHTML = '';
        }

        function connect() {
            var socket = new SockJS('/add');
            var socket1 = new SockJS('/delete');
			stompClient = Stomp.over(socket);
			stompClient1 = Stomp.over(socket1);
            stompClient.connect({}, function(frame) {
                setConnected(true);
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/showResult', function(calResult){
                	showResult(JSON.parse(calResult.body).name);
                });                
            });
            stompClient1.connect({}, function(frame) {
                setConnected1(true);
                console.log('Connected: ' + frame);
                 stompClient1.subscribe('/topic/showResult1', function(calResult){
                	showResult(JSON.parse(calResult.body).name);
                });
            });
        }

        function disconnect() {
            stompClient.disconnect();
            stompClient1.disconnect();
            setConnected(false);
            setConnected1(false);
            console.log("Disconnected");
        }

        function sendNum() {
            var num1 = document.getElementById('num1').value;
            var num2 = document.getElementById('num2').value;
            stompClient.send("/calcApp/add", {}, JSON.stringify({ 'num1': num1, 'num2': num2 }));
            stompClient.send("/calcApp/delete", {}, JSON.stringify({ 'num1': num1, 'num2': num2 }));
        }

        function showResult(message) {
            var response = document.getElementById('calResponse');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            response.appendChild(p);
        }
        function showResult1(message) {
            var response = document.getElementById('calResponse1');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            response.appendChild(p);
        }
    </script>
</head>
<body>
<noscript><h2>Enable Java script and reload this page to run Websocket Demo</h2></noscript>
<h1>Calculator App Using Spring 4 WebSocket</h1>
<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button><br/><br/>
    </div>
    <div id="calculationDiv">
        <label>Number One:</label><input type="text" id="num1" /><br/>
        <label>Number Two:</label><input type="text" id="num2" /><br/><br/>
        <button id="sendNum" onclick="sendNum();">Send to Add</button>
        <p id="calResponse"></p>
        <p id="calResponse1"></p>
    </div>
</div>
</body>
</html>