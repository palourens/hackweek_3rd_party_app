<%@ page import="com.dotloop.demo.domain.User" %>
<%@ page import="com.dotloop.demo.domain.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-inverse navbar-default navbar-static-top">
    <c:if test="${sessionScope.user != null}">
    <p style="float: right; color: white; margin-right:70px; margin-top:10px;font-size:18px;"><c:out value="${sessionScope.user.firstName}"/></p>
    </c:if>
</nav>
<header style="display: block">
    <img src="/mandp.png"/>
</header>

