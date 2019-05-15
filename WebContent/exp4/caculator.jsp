<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="exp4.Caculate" %>
<!doctype html>
<html lang="en">

<head>
    <title>简易计算器</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
<jsp:useBean id="caculate" class="exp4.Caculate" />
<jsp:setProperty name="caculate" property="*" />
    <div class="container">
        <div class="row">
            <div class="col-lg-5">
                <div class="jumbotron">
                    <h4 class="text-center">简易计算器</h4>
                    <hr class="my-2">
                    <form action="" method="POST">
                        <div class="form-group">
                            <label for="">第一个参数</label>
                            <input type="text" class="form-control" name="first">
                        </div>
                        <div class="form-check my-4">
                            <label class="form-check-label mx-3">
                                <input type="radio" class="form-check-input" name="op" value="+">➕
                            </label>
                            <label class="form-check-label mx-3">
                                <input type="radio" class="form-check-input" name="op" value="-">➖
                            </label>
                            <label class="form-check-label mx-3">
                                <input type="radio" class="form-check-input" name="op" value="*">✖️
                            </label>
                            <label class="form-check-label mx-3">
                                <input type="radio" class="form-check-input" name="op" value="/">➗
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="">第二个参数</label>
                            <input type="text" class="form-control" name="second">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">计算</button>
                    </form>
                    <div class="form-group my-4">
                        <label for="">计算结果</label>
                        <span class="form-control" ><%=caculate.getResult()%></span>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>

</html>