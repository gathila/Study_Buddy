<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
           prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />

<!DOCTYPE HTML>
<html>
<head>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
    <script type="application/javascript"  language="javascript">

        window.onload = draw;
        /*window.onload = function () {
         var twintysec = 20,
         display = document.querySelector('#time');
         startTimer(twintysec, display);
         };*/
        var ctx;
        var ctx2;
        var ctx3;
        var isCanvasF;
        var isCanvasOneFilled = false;
        var isCanvasTwoFilled = false;
        var canvas1Image;
        var canvas2Image;
        var canvas3Image;
        var timer = 20, minutes, seconds;
        var points = 0;
        var isUserWin;
        var timeout;
        var iteration = 0;
        var timerDuration = 20;
        function startTimer(duration, display) {

            timeout = setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                display.textContent = minutes + ":" + seconds;

                if (--timer < 0) {
                    timer = 0;
                }
            }, 1000);
        }

        function stopTimer(){
            clearTimeout(timeout);
        }

        function draw(){
            var canvas = document.getElementById("canvas1");
            var canvas2 = document.getElementById("canvas2");
            var canvas3 = document.getElementById("canvas3");
            ctx = canvas.getContext("2d");
            ctx2 = canvas2.getContext("2d");
            ctx3 = canvas3.getContext("2d");


            timerDuration = 20,
                    display = document.querySelector('#time');

        }

        function drawCircuit(color){



            ctx.beginPath();
            ctx.moveTo(50, 20);
            ctx.lineTo(100, 20);
            ctx.lineWidth = 1;
            ctx.strokeStyle = color;
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(50, 100);
            ctx.lineTo(90, 100);
            ctx.strokeStyle = color;
            ctx.stroke();
            ctx.closePath();

            ctx.beginPath();
            ctx.moveTo(50, 20);
            ctx.lineTo(50, 100);
            ctx.strokeStyle = color;
            ctx.stroke();
            ctx.closePath();

            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(110, 20);
            ctx.lineTo(160, 20);
            ctx.strokeStyle = color;
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(120, 100);
            ctx.lineTo(160, 100);
            ctx.strokeStyle = color;
            ctx.stroke();
            ctx.closePath();

            ctx.beginPath();
            ctx.moveTo(160, 20);
            ctx.lineTo(160, 100);
            ctx.strokeStyle = color;
            ctx.stroke();
            ctx.closePath();

            ctx.beginPath();
            ctx.arc(105, 100, 15, 0, 2 * Math.PI);
            ctx.strokeStyle = color;
            ctx.stroke();
        }

        function allowDrop(ev) {
            ev.preventDefault();
        }

        function drag(ev, id) {
            elementId = id;

            ev.dataTransfer.setData("text", ev.target.id);

        }

        function drop(ev, id) {

            var offset = $('#'+elementId).offset();
            var x = ev.pageX - offset.left;
            var y = ev.pageY - offset.top;
            ev.preventDefault();
            var data = ev.dataTransfer.getData("text");

            var dropElement = document.getElementById(elementId);

            ev.target.appendChild(document.getElementById(elementId));
            /*if(!isCanvasOneFilled){
             alert("ctx1");
             ctx.drawImage(dropElement, 100, 0, 100, 100);
             isCanvasOneFilled = true;
             isDropCalled = true;
             }else if(!isCanvasTwoFilled){
             alert("ctx2");
             ctx2.drawImage(dropElement, 100, 0, 120, 120);

             }*/
            iteration++;
            if(y < 300 && x<1100 && iteration != 2 && iteration != 4 && !isCanvasOneFilled){

                ctx.drawImage(dropElement, 127, 16, 130, 120);
                isCanvasOneFilled = true;
                canvas1Image = elementId;
            }
            else if(y<300 && iteration != 2 && iteration != 4 && !isCanvasTwoFilled){
                //alert("ctx2");
                ctx3.drawImage(dropElement, 50, 15, 120, 120);
                canvas3Image  = elementId;
                isCanvasTwoFilled = true;
            }
            else if(iteration != 2 && iteration != 4 && iteration != 6){
                //alert("ctx2");
                ctx2.drawImage(dropElement, 80, 20, 150, 120);
                canvas2Image  = elementId;
            }
        }

        function evaluate(){
            var playIcon = document.getElementById("playpause");
            if(playIcon.className == "playpause"){
                alert("Click on play icon before play");
                reloadPage();
                return;
            }
            if((canvas1Image == "res3") && (canvas2Image == "battery3") && (canvas3Image == "res5") && timer >0){
                isUserWin = true;
                showWinImg();
            }else if((canvas1Image == "res5") && (canvas2Image == "battery3") && (canvas3Image == "res3") && timer >0){
                isUserWin = true;
                showWinImg();
            }else if((canvas1Image == "battery3") && (canvas2Image == "res5") && (canvas3Image == "res3") && timer >0){
                isUserWin = true;
                showWinImg();
            }else if((canvas1Image == "battery3") && (canvas2Image == "res3") && (canvas3Image == "res5") && timer >0){
                isUserWin = true;
                showWinImg();
            }else if((canvas1Image == "res3") && (canvas2Image == "res5") && (canvas3Image == "battery3") && timer >0){
                isUserWin = true;
                showWinImg();
            }else if((canvas1Image == "res5") && (canvas2Image == "res3") && (canvas3Image == "battery3") && timer >0){
                isUserWin = true;
                showWinImg();
            }else{
                isUserWin = false;
                showLossImg();
            }
        }

        function showWinImg() {
            var lightbulb = document.getElementById("bulb");
            //alert(lightbulb);
            lightbulb.src = "<c:url value="/images/resistor.svg" />"
            var img = document.getElementById('win');
            var marks = document.getElementById('scoreBest');
            var next= document.getElementById('next');
            img.style.visibility = 'visible';
            marks.style.visibility = 'visible';
            next.style.visibility = 'visible';
        }
        function showLossImg() {
            var img = document.getElementById('loss');
            var marks = document.getElementById('scoreLose');
            img.style.visibility = 'visible';
            marks.style.visibility = 'visible';
        }
        function reloadPage(){
            location.reload();
        }

        function toggle() {
            var image = document.getElementById("playpause");
            display = document.querySelector('#time');
            if(image.className != "pause"){
                image.src = "<c:url value="/images/pause.png" />"
                image.className = "pause";
                startTimer(timerDuration, display);
            }
            else {
                image.src = "<c:url value="/images/playIcon.png" />"
                image.className = "playpause";
                timerDuration = seconds;
                stopTimer();
            }
        }

    </script>
    <style>
        #container{
            margin: 50px;
            background-color:  #10f28c ;
        }

        body{
            background-color:   #046444  ;
        }

        .playIcon{
            margin: 80px;
            width:100px;
            height:80px;
        }

        #leftCol{
            float:left; width:400px; height:600px; border:1px solid #aaaaaa; background-color:   #ffffff  ; margin-top:70px; border-radius: 15px;
        }
        #rightCol{
            float:right; width:900px; height:600px; border:1px solid #aaaaaa; background-color:  #ffffff  ; margin-top:70px; border-radius: 15px;
        }
        #canvas1{
            width:200px; height:110px;
        }

        #bulb{
            width:100px;
            height:100px;
            padding: 10px;
        }
        #battery1{
            width:100px;
            height:100px;
            padding: 10px;
        }
        #battery3{
            width:100px;
            height:100px;
            padding: 10px;
        }
        #resistor{
            width: 100px;
        }

        #canvas2{
            width:200px; height:110px;
        }
        #canvas3{
            width:200px; height:110px;
        }

        #raw1{height:200px; display: inline-block; padding: 6px;}
        #raw2{height:200px; display: inline-block; padding: 6px;}
        #raw3{height:200px; display: inline-block; padding: 6px;}

        #circuit1{
            width: 800px;
            height:550px;
            margin-left: 75px;
            margin-top: 40px;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color:    #051b5c  ;
            font-size: 30px;
            height: 90px;
        }


        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        li a:hover {
            background-color: #111;
        }
        .logoutbt{
            float:right;
        }
        .menubarImg{
            width: 100px;
        }

        #time{
            font-weight: bold;
            color:  #feffff ;
            font-size: 50px;
            display: block;
            position: absolute;
            left: 50%;
            top: 2%
        }

        #showlevel{
            position: absolute;
            left: 25%;
            top: 13%;
            color:     #fafa38    ;
            font-size: 40px;
            font-style: italic;
        }
        #topic{
            position: absolute;
            left: 45%;
            top: 13%;
            color:    #fafa38   ;
            font-size: 40px;
            font-style: italic;

        }
        #run{
             position: absolute;
             color: #f81616;
             font-size: 10px;
             width: 82px;
             left: 1400px;
             top: 120px;
             border-radius: 5px;
         }
        #play{
            position: absolute;
            color: #f81616;
            font-size: 10px;
            width: 60px;
            left: 1315px;
            top: 120px;
            border-radius: 5px;
        }
        #retry{
            position: absolute;
            left: 100px;
            top: 120px;
            color: #f81616;
            font-size: 10px;
            width: 70px;
            border-radius: 5px;
        }
        #playpause{
            width:45px;
            height:45px;

        }

        #next{
            visibility:hidden;
            position: absolute;
            left: 1520px;
            top: 120px;
            color: #f81616;
            font-size: 10px;
            width: 70px;
            border-radius: 5px;
        }
        .row1{
            display:inline-block;
        }
        .row2{
            display:inline-block;
        }
        .row3{
            display:inline-block;
        }

    </style>
</head>
<body background='<c:url value=''/>'>

<ul>
    <li><img class="menubarImg" src='<c:url value='/images/globe.jpg'/>'/></li>
    <li><a class="active" href="/home?username=${username}">Home</a></li>
    <li><a href="/instruction?level=2">Instructions</a></li>
    <li><a href="#news">Hints</a></li>
    <li><a href="/levels">Level</a></li>
    <li><span id="time"></span></li>
    <div class="logoutbt">
        <li><a href="/logout">Logout</a></li>
    </div>
</ul>

<img  id="win" src="<c:url value="/images/win.svg" />"style="position:absolute; top:40%; right:57%; visibility:hidden"  width=250px"/>
<img  id="loss" src="<c:url value="/images/lose.svg" />"style="position:absolute; top:40%; right:57%; visibility:hidden"  width=250px"/>
<h2 id="scoreBest" style="position:absolute; top:38%; right:62%; visibility:hidden"  width="400px"> Score : 20 </h2>
<h2 id="scoreBetter" style="position:absolute; top:38%; right:62%; visibility:hidden"  width="300px"> Score : 10 </h2>
<h2 id="scoreLose" style="position:absolute; top:38%; right:62%; visibility:hidden" ; width="400px"> Score : 0 </h2>
<a href="javascript:reloadPage();"><button type="button" id="retry"><h2 > Retry </h2></button></a>
<a href="/nextLevel?level=2&score=20&username=${username}"><button type="button" id="next"><h2 > Next </h2></button></a>
<button type="button" id="play" onclick="toggle();"><img id="playpause" class="playpause" src="<c:url value="/images/playIcon.png" />" ></button>
<a href="javascript:evaluate();"><button type="button" id="run"><h2> Simulate</h2></button></a>
<div id="container">
    <div id="leftCol">
        <div id="raw1">
            <img class="row1" id="bulb" class="playIcon" src="<c:url value="/images/bulb.svg" />" draggable="true" ondragstart="drag(event, this.id)" style="float: left" width="110px">
            <img class="row1" id="battery1" class="playIcon" src="<c:url value="/images/battery1.svg" />" draggable="true" ondragstart="drag(event, this.id)" style="float: left" width="120px">
            <img class="row1" id="battery3" class="playIcon" src="<c:url value="/images/battery3.svg" />" draggable="true" ondragstart="drag(event, this.id)" style="float: left" width="120px">
        </div>
        <div id="raw2">
            <img class="row2" id="res3" class="playIcon" src="<c:url value="/images/res3.svg" />" draggable="true" ondragstart="drag(event, this.id)" width="120px"/>
            <img class="row2" id="res5" class="playIcon" src="<c:url value="/images/res5.svg" />" draggable="true" ondragstart="drag(event, this.id)" width="120px"/>
            <img class="row2" id="res6" class="playIcon" src="<c:url value="/images/res6.svg" />" draggable="true" ondragstart="drag(event, this.id)" width="120px"/>
        </div>
        <div id="raw3">
            <img class="row3" id="res10" class="playIcon" src="<c:url value="/images/res10.svg" />" draggable="true" ondragstart="drag(event, this.id)" width="120px"/>
            <img class="row3" id="not" class="playIcon" src="<c:url value="/images/NOT.jpg" />" draggable="true" ondragstart="drag(event, this.id)" width="120px"/>
            <img class="row3" id="resistor" class="playIcon" src="<c:url value="/images/or.svg" />" draggable="true" ondragstart="drag(event, this.id)" width="120px"/>
        </div>

    </div>
    <div id="rightCol" ondrop="drop(event)" ondragover="allowDrop(event)">
        <img id="circuit1" src="<c:url value="/images/circuitne2.svg" />" />
        <canvas id="canvas1" ondrop="drop(event)" ondragover="allowDrop(event)" style="position:absolute; top:300px; left:57%"></canvas>
        <canvas id="canvas2" ondrop="drop(event)" ondragover="allowDrop(event)" style="position:absolute; top:645px; left:1093px" ></canvas>
        <canvas id="canvas3" ondrop="drop(event)" ondragover="allowDrop(event)" style="position:absolute; top:300px; left:69%"></canvas>
        </canvas>
    </div>
</div>
</body>
</html>
