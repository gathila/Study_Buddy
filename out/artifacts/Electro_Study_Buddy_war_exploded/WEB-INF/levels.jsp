<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
           prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />


<html>
<head>
    
    <script type="application/javascript" language="JavaScript">
        window.onload = details;
        
        function details() {

        }
    </script>
    
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
            width: 90%;
            height: 90%;
        }

        #background1{
            flex: 1 1 auto;
        }

        #background2{
            width:500px;
            height:400px;
            margin-top: 50px
        }

        #label{
            position: relative;
            width: 10%;
            height: 20%;
            float: left;
            font-size: 20px;

        }
        .image{
            -webkit-filter: blur(5px);
            -moz-filter: blur(5px);
            -o-filter: blur(5px);
            -ms-filter: blur(5px);
            filter: blur(3px);
        }
        .score{
            position: absolute;
            top: 65%;
            left:27%;
            color:white;
            font-size: 20px;
        }
    </style>
</head>

<body>

<ul>
    <div class="logoutbt">
        <li><a href="/logout">Logout</a></li>
    </div>
</ul>

<div class="content1">
    <p>
        <c:forEach var="i" begin="1" end="10">
            <c:choose>
                    <c:when test="${i <= maxLevel}">
                        <div id="label" align="center"><div class="score">Score: <c:out value="${scoreForEachLevel[i-1]}"/></div>
                            <a href="/moveTo?level=${i}&username=${username}"><img src="/images/BulbOn1.jpg">Level <c:out value="${i}"/></a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="label" align="center"><img class="image" src="/images/BulbOn1.jpg">Level <c:out value="${i}"/></div>
                    </c:otherwise>
            </c:choose>
        </c:forEach>
    </p>
</div>

</body>
</html>