<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@page import="exp5.ConnectionDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 首页 -->
<!doctype html>
<html lang="en">

<head>
<title>Happy Shopping-首页</title>
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
#flex {
	display: flex;
	flex-wrap: wrap;
}

.border {
	border: 1px solid rgba(0, 0, 0, .125rem);
	border-radius: .25rem;
	padding: 5px;
	margin: 5px;
}

.image-center {
	text-align: center;
}

.image {
	height: 200px;
	width: 200px;
}
</style>
</head>

<body>
<%
	//设置第一次进入首页时，用户状态为未登录
	Object is = session.getAttribute("isSignin");
	if(is == null){
		session.setAttribute("isSignin", false);
	}
%>
	<jsp:useBean id="condb" class="exp5.ConnectionDB" scope="session" />
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
				<li class="nav-item active"><a class="nav-link" href="Show.jsp">首页
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="ShoppingCart.jsp">购物车</a></li>
				<li class="nav-item"><a class="nav-link" href="Order.jsp">我的订单</a>
				</li>
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
	<div class="container">
		<div class="row">
			<!-- 显示商品 -->
			<div class="col-lg-12">
				<div id="flex">
					<!-- <div class="border"> -->
					<%
						Connection conn = condb.getConnection();
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery("select * from goods");
						int id = 0;
						String name = "";
						double price = 0;
						int stock = 0;
						String imgpath = "";
						while (rs.next()) {
							id = rs.getInt(1);
							name = rs.getString(2);
							price = rs.getDouble(3);
							stock = rs.getInt(4);
							imgpath = rs.getString(5);
							String show1 = "<div class=\"border\"><a href=\"ChooseAndBuy.jsp?gid=" + id
									+ "\"><div style=\"width: 200px;\"><div class=\"image-center\">";
							String show2 = "<img src=\"" + imgpath + "\" class=\"image\"></div>";
							String show3 = "<p>" + name + "</p><span>¥" + price + "</span></div></a></div>";
							out.print(show1 + show2 + show3);
						}
					%>
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