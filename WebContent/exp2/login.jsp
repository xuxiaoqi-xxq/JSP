<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <title>用户登录</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script>
        function refresh(){
            document.getElementById('verifycode').src='code.jsp';
        }
    </script>
  </head>
  <body>
      <div class="container">
          <div class="row">
              <div class="col-lg-5">
                  <div class="card">
                      <div class="card-body">
                          <h4 class="card-title" style="text-align: center;">用户登录/LOGIN</h4>
                          <hr>
                        <form action="verify.jsp" method="POST">
                            <div class="form-group">
                              <label for="">用户名</label>
                              <input type="text"
                                class="form-control" name="uname" id="">
                                <label for="">密码</label>
                              <input type="password"
                                class="form-control" name="pwd" id="">
                                <label for="">验证码</label>
                              <input type="text"
                                class="form-control" name="code" id="">
                                <img src="code.jsp" alt="验证码">
                                <a href="" onclick="refresh()" class="my-4">看不清？换一张</a><br>
                                <input type="radio" class="mx-2" name="type" value="department">部门
                                <input type="radio" class="mx-2" name="type" value="teacher">教师
                                <input type="radio" class="mx-2" name="type" value="student">学生
                                <input type="radio" class="mx-2" name="type" value="guest">访客
                            </div>
                            <button type="submit" class="btn btn-primary mx-4">登录</button>
                            <button type="reset" class="btn btn-primary mx-4">重置</button>
                        </form>
                      </div>
                  </div>
              </div>
          </div>
      </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>