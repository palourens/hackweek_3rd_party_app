<!doctype html>
<%@ page import="com.dotloop.demo.domain.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<header>
  <link rel="stylesheet" href="/css/bootstrap.min.css">
</header>
<body>
<jsp:include page="header.jsp" />
    <div class="container">
        <c:choose>
            <c:when test="${sessionScope.user == null}">
      <div class="row">
        <div class="col-md-12 col-sm-6 col-xs-12">
          <div class="panel panel-default">
            <div class="panel-heading clearfix">
              <h2 class="panel-title">Sign In</h2>
            </div>

            <div class="panel-body">
              <form class="form-signin" method="post" action="/signin">
                <label for="email" class="sr-only">Email address</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="Email address" required autofocus value="pierrel@dotloop.com">
                <label for="password" class="sr-only">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Password" required value="password">
                <button class="btn btn-lg btn-primary btn-block" style="width: 150px; margin: 20px" type="submit">Sign in</button>
                <div class="alert-link">
                  <p style="padding:20px">
                    Don't have an account yet, <a href="/register">Sign Up</a> here!
                  </p>
                </div>
              </form>
              </div>
            </div>
          </div>
      </div>
            </c:when>
            <c:otherwise>
        <div class="row">
            <div class="col-md-12 col-sm-6 col-xs-12">
                <div class="panel-body">
                    <div style="float:right;"><img src="/loopit-button.png" onclick="openPopup()" style="cursor: pointer;margin: 20px;border: 3px solid #61B6FF;border-radius: 15px;"><c:if test="${sessionScope.user != null && sessionScope.user.token != null}"><a href="/revoke"><button class="btn btn-warning" style="width: 150px; margin: 20px;">Delete Token</button></a></c:if></div>


                    <div>
                        <img src="150page.png">
                    </div>
                    </div>
                </div>

            </div>
        </div>
                <script>
                    var popup = null;

                    function openPopup() {
                        window.location.href = "http://mandp.com:9999";
                        <c:choose>
                        <c:when test="${sessionScope.user != null && sessionScope.user.token == null}">
                            popup = window.open("http://localhost:8080/oauth2/authorize?response_type=code&scopes=loops:*,profiles:*&client_id=<c:out value="${ sessionScope.clientId }"/>&redirect_uri=<c:out value="${sessionScope.redirectUrl}"/>");
                        </c:when>
                        <c:otherwise>
                            popup = window.open("http://mandp.com:9999/loopit", "_self");
                        </c:otherwise>
                        </c:choose>

                        return true;
                    }

                </script>
            </c:otherwise>
        </c:choose>
    </div> <!-- /container -->

</body>
</html>
