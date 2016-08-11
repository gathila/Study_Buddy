<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
           prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />


<html>
<head>
    <style>
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color:    #051b5c  ;
            font-size: 30px;
            height: 90px;
        }

        body{
            background-color:  #ebf5fb ;
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
        .play{
            float:left;
            overflow:hidden;
        }

        .playIcon{
            width:40px;
            height:40px;
            margin-top: 50px
        }

        .content1{
            flex: 1 1 auto;
        }
        .content1 img{
            display: block;
            width: 100%;
            height: 100%;
        }

        #background1{
            flex: 1 1 auto;
        }

        #background2{
            width:500px;
            height:400px;
            margin-top: 50px
        }
    </style>
</head>

<body>

<ul>
    <li><a class="active" href="#home">Home</a></li>
    <li><a href="#Game">Game</a></li>
    <li><a href="#news">Vision</a></li>
    <li><a href="#contact">Quessionaries</a></li>
    <li><a href="#Comments">Comments</a></li>
    <li><a href="/levels?username=${username}">Levels</a></li>
    <div class="logoutbt">
        <li><a href="/logout">Logout</a></li>
    </div>
</ul>

<div class="content1">
    <p>
        <img src='<c:url value='/images/electricity.jpg'/>' id="background1"/>
    </p>
</div>



<a href="/level1?username=${username}"><img src='<c:url value='/images/play.png'/>' style="position: absolute; top: 120px; left: 30px;" width="130px"/></a>

</body>
</html>