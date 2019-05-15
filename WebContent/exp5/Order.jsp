<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="exp5.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<!-- 订单 -->
<head>
<title>Happy Shopping-我的订单</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
.image {
	height: 200px;
	width: 200px;
}
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="Show.jsp">Happy-Shopping</a>
		<button class="navbar-toggler d-lg-none" type="button"
			data-toggle="collapse" data-target="#collapsibleNavId"
			aria-controls="collapsibleNavId" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavId">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li class="nav-item"><a class="nav-link"
					href="Show.jsp">首页</a></li>
				<li class="nav-item"><a class="nav-link"
					href="ShoppingCart.jsp">购物车</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="Order.jsp">我的订单<span class="sr-only">(current)</span></a></li>
				<%
					boolean isSignin = (Boolean) session.getAttribute("isSignin");
					if (isSignin) {
						out.print("<li class=\"nav-item\"><a class=\"nav-link\" href=\"Order.jsp\">"
								+ (String) session.getAttribute("name") + "</a></li>");
					} else {
				%>
				<li class="nav-item"><a class="nav-link" href="Signin.jsp">登录</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="login.jsp">注册</a>
				</li>
				<%
					}
				%>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="text"
					placeholder="搜索其实很简单">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">搜索</button>
			</form>
		</div>
	</nav>
	<!-- 显示信息 -->
	<div class="col-lg-7 mt-4">
		<div class="card">
			<div class="container">
				<div class="row">
					<%
						//登录用户订单信息
						if (isSignin) {
							int uid = (Integer) session.getAttribute("uid");
							Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
							//查询订单信息
							PreparedStatement pstmt = conn.prepareStatement("select gid,buytime,count from uorder where uid = ?");
							pstmt.setInt(1, uid);
							ResultSet rs = pstmt.executeQuery();
							//查询商品信息
							PreparedStatement stmt = conn.prepareStatement("select gname,price,img from goods where gid = ?");
							while (rs.next()) {
								int gid = rs.getInt(1);
								Date buytime = rs.getDate(2);
								int count = rs.getInt(3);
								stmt.setInt(1, gid);
								ResultSet r = stmt.executeQuery();
								if (r.next()) {
									String gname = r.getString(1);
									double price = r.getDouble(2);
									String imgpath = r.getString(3);
					%>
					<div class="col-lg-5">
						<div class="card-body">
							<img class="image" src="<%=imgpath%>">
						</div>
					</div>
					<div class="col-lg-7">
						<div class="card-body">
							<h4 class="card-title"><%=gname%></h4>
							<p class="card-text">
								¥<%=price%></p>

							<div class="form-group">
								<span class="form-text text-muted">购买数量:<%=count%></span> <span
									class="form-text text-muted">购买时间:<%=buytime%></span> <span
									class="form-text text-muted">总金额:<%=price * count%></span>
							</div>

						</div>
					</div>
					<%
						}
							}
						} else {
							out.print("您还未登录哦<br><a href='Signin.jsp'>点此登录</a>");
						}
					%>

				</div>
			</div>
		</div>
	</div>


	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
</body>

</html>