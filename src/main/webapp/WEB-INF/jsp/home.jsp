<!doctype html>
<%@ page import="com.dotloop.demo.domain.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<header>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/jquery-ui.min.css">
    <link rel="stylesheet" href="/css/selectize.bootstrap3.css"
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/favicon.ico" type="image/x-icon">
</header>
<body>
<style>
    .alert-fixed {
        position:fixed;
        top: 0px;
        left: 0px;
        width: 100%;
        z-index:9999;
        border-radius:0px
    }
</style>
<jsp:include page="header.jsp" />
        <div id="alert" class="alert alert-success alert-dismissible hidden alert-fixed" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <span id="alertText"></span>
        </div>
        <c:remove var="loop" scope="session" />
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
            <div class="col-md-12">
                <div style="float:right;"><img id="loopit" src="/loopit-button.png" style="cursor: pointer;margin: 20px;border: 3px solid #61B6FF;border-radius: 15px; display:block;"><button id="deletetoken" style="border-radius: 15px; width: 170px;" class="btn btn-warning hidden">Delete Token</button></div>

                <div>
                <div class="panel-body" style="display:flex;">
                    <form class="form-horizontal row-border">
                        <div class="form-group">
                            <label class="col-md-2 control-label">Search Addresses</label>
                            <div class="col-md-6">
                                <input id="addresses" class="form-control" style="width: 450px;"/><input id="addressName" class="hidden"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Contacts</label>
                            <div class="col-md-6">
                                <input id="contacts" class="form-control" style="width: 450px;"/><input id="contactEmail" class="hidden"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Role</label>
                            <div class="col-md-6">
                                <input id="roles" type="text" class="form-control" style="width: 450px;"/><input id="role" class="hidden"/>
                            </div>
                        </div>
                    </form>

                </div>
                    <div>
                        <img id="zillow" width="1200" style="margin-top: 30px; clear:both;">

                        </img>
                    </div>
                <!--div class="panel-body">
                    <div style="float:right;"><img id="loopit" src="/loopit-button.png" style="cursor: pointer;margin: 20px;border: 3px solid #61B6FF;border-radius: 15px; display:block;"><a href="/revoke"><button id="deletetoken" class="btn btn-warning hidden" style="width: 150px; margin: 20px;">Delete Token</button></a></div>

                    <div>
                        <div class="control-group">
                            <p style="display:inline;">Search Addresses</p><input id="addresses" class="input-lg" style="width: 450px;"/><input id="addressName" class="hidden"/>
                        </div>
                    </div>
                    <div>
                        <div class="control-group">
                            <p style="display:inline;">Contacts</p><input id="contacts" class="input-lg" style="width: 450px;"/><input id="contactEmail" class="hidden"/>
                        </div>
                        <div class="control-group">
                            <p style="display:inline;">Role</p><input id="roles" type="text" class="input-lg" style="width: 450px;"/><input id="role" class="hidden"/>
                        </div>
                    </div>

                    <div>
                        <img id="zillow" width="1200" style="margin-top: 30px;">

                        </img>
                    </div>
                    </div>
                </div-->

            </div>
        </div>
                <script>
                </script>
            </c:otherwise>
        </c:choose>
    </div> <!-- /container -->

    <script src="/js/jquery-3.1.0.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/selectize.js"></script>
    <script>
        var token = '<c:out value="${sessionScope.token}"/>',
            clientId = '<c:out value="${ sessionScope.clientId }"/>',
            redirectUrl = '<c:out value="${sessionScope.redirectUrl}"/>';

        $(document).ready(function() {
            $('#loopit').click(openPopup);
            $('#deletetoken').click(revokeToken);
            if(token) {
                setupButtons();
            }
        });
    </script>
    <script src="/js/home.js"></script>
</body>
</html>
