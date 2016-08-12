<!doctype html>
<header>
  <link rel="stylesheet" href="/css/bootstrap.min.css">
</header>
<html>
<body>
<jsp:include page="header.jsp" />
  <div class="container">

      <div class="row">
        <div class="col-md-12 col-sm-6 col-xs-12">
          <div class="panel panel-default">
            <div class="panel-heading clearfix">
              <i class="icon-calendar"></i>
              <h3 class="panel-title">Sign Up</h3>
            </div>

            <div class="panel-body">
              <form class="form-horizontal row-border" action="/register" method="post">
                <div class="form-group">
                  <label class="col-md-2 control-label">First Name</label>
                  <div class="col-md-10">
                    <input type="text" name="firstName" id="firstName" class="form-control" required autofocus>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Last Name</label>
                  <div class="col-md-10">
                    <input type="text" name="lastName" id="lastName" class="form-control" required>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Email Address</label>
                  <div class="col-md-10">
                    <input type="text" name="email" id="email" class="form-control" required>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Password</label>
                  <div class="col-md-10">
                    <input class="form-control" type="password" name="password" id="password" required>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-md-12">
                    <button class="btn btn-lg btn-primary btn-block center-block" style="width: 150px" type="submit">Register</button>
                  </div>
                </div>

                <!--div class="form-group">
                  <label class="col-md-2 control-label">With placeholder</label>
                  <div class="col-md-10">
                    <input class="form-control" type="text" name="placeholder" placeholder="placeholder">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Disabled field</label>
                  <div class="col-md-10">
                    <input type="text" name="disabled" disabled="disabled" value="disabled" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Read only field</label>
                  <div class="col-md-10">
                    <input class="form-control" type="text" name="readonly" readonly="" value="read only">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Help text</label>
                  <div class="col-md-10">
                    <input type="text" name="regular" class="form-control">
                    <span class="help-block">A block of help text that breaks onto a new line and may extend beyond one line.</span>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Predefined value</label>
                  <div class="col-md-10">
                    <input type="text" name="regular" value="http://" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">With icon</label>
                  <div class="col-md-10">
                    <input type="text" name="regular" class="form-control">
                    <i class="icon-pencil input-icon"></i>
                  </div>
                </div>
                <div class="form-group">
                  <label for="labelfor" class="col-md-2 control-label">Clickable label</label>
                  <div class="col-md-10">
                    <input type="text" name="labelfor" id="labelfor" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Column sizing</label>
                  <div class="col-md-10">
                    <div class="row">
                      <div class="col-xs-3">
                        <input type="text" class="form-control" placeholder=".col-xs-3">
                      </div>
                      <div class="col-xs-5">
                        <input type="text" class="form-control" placeholder=".col-xs-5">
                      </div>
                      <div class="col-xs-4">
                        <input type="text" class="form-control" placeholder=".col-xs-4">
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group has-success">
                  <label class="col-md-2 control-label">Input success</label>
                  <div class="col-md-10">
                    <input type="text" class="form-control" id="inputSuccess" placeholder="Input Success">
                    <i class="icon-pencil input-icon success"></i>
                  </div>
                </div>
                <div class="form-group has-warning">
                  <label class="col-md-2 control-label">Input warning</label>
                  <div class="col-md-10">
                    <input type="text" class="form-control" id="inputWarning" placeholder="Input Warning">
                    <i class="icon-pencil input-icon warning"></i>
                  </div>
                </div>
                <div class="form-group has-error">
                  <label class="col-md-2 control-label">Input error</label>
                  <div class="col-md-10">
                    <input type="text" class="form-control" id="inputError" placeholder="Input Error">
                    <i class="icon-pencil input-icon error"></i>
                  </div>
                </div-->
              </form>
            </div>
          </div>
        </div>
      </div>

    </div> <!-- /container -->
</body>
</html>
