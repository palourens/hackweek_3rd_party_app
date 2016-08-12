<!doctype html>
<html>
<header>
  <link rel="stylesheet" href="/css/bootstrap.min.css">
</header>
<body>
<jsp:include page="header.jsp" />
  <div class="container">

      <form class="form-signin" method="post" action="/signin">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <div class="alert-link">
          <label>
            <a href="/register">Sign Up</a>
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->
</body>
</html>
