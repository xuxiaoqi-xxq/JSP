<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="exp5.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 购物车 -->
<!doctype html>
<html lang="en">

<head>
<title>Happy Shopping-我的购物车</title>
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
/* .border {
	border: 1px solid rgba(0, 0, 0, .125rem);
	border-radius: .25rem;
	padding: 5px;
	margin: 5px;
}

.image-center {
	text-align: center;
} */
.image {
	height: 100px;
	width: 100px;
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
				<li class="nav-item"><a class="nav-link" href="Show.jsp">首页</a>
				</li>
				<li class="nav-item active"><a class="nav-link"
					href="ShoppingCart.jsp">购物车<span class="sr-only">(current)</span></a>
				</li>
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
	<div class="col-lg-7 mt-4">
		<div class="card">
			<div class="container">
				<div class="row">
					<%
						/* 显示购物车 */
						String gname = "";
						double price = 0;
						int count = 0;
						String imgpath = "";
						int gid = 0;

						//登录用户显示信息
						if (isSignin) {
					%><form action="Pay.jsp" method="POST">
						<%
							//从session中获取用户id
								int uid = (Integer) session.getAttribute("uid");
								Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
								Statement stmt = conn.createStatement();
								ResultSet rs = stmt.executeQuery("select * from cart where uid=" + uid);
								while (rs.next()) {
									gid = rs.getInt(2);
									gname = rs.getString(3);
									price = rs.getDouble(5);
									count = rs.getInt(4);
									imgpath = rs.getString(6);
						%>

						<div class="col-lg-5">
							<div class="card-body">
								<img class="image" src="<%=imgpath%>">
							</div>
						</div>
						<div class="col-lg-7">
							<div class="card-body">
								<h6 class="card-title"><%=gname%></h6>
								<p class="card-text">
									¥<%=price%></p>
								<div class="form-group">
									<label for="">数量</label> <input type="text"
										class="form-control" name="count" value="<%=count%>" min="1"
										max="" style="width: 100px;" disabled>
									<button type="button" class="btn btn-danger px-4"
										onclick="location.href='Delete.jsp?gid=<%=gid%>'">删除</button>
								</div>
							</div>
						</div>

						<%
							}
						%>
						<button type="submit" class="btn btn-primary px-4"
							style="margin: 10px 20px;">结算</button>
					</form>
					<%
						}

						//未登录用户
						else {
					%><form action="Pay.jsp" method="POST">
						<%
							HashMap<String, Integer> tempCart = (HashMap) session.getAttribute("tempcart");
								if (tempCart != null) {
									Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
									Statement stmt = conn.createStatement();
									for (String g : tempCart.keySet()) {
										ResultSet rs = stmt.executeQuery("select * from goods where gid=" + g);
										while (rs.next()) {
											gname = rs.getString(2);
											price = rs.getDouble(3);
											count = tempCart.get(g);
											imgpath = rs.getString(5);
						%>
						<div class="col-lg-5">
							<div class="card-body">
								<img class="image" src="<%=imgpath%>">
							</div>
						</div>
						<div class="col-lg-7">
							<div class="card-body">
								<h6 class="card-title"><%=gname%></h6>
								<p class="card-text">
									¥<%=price%></p>
								<div class="form-group">
									<label for="">数量</label> <input type="text"
										class="form-control" name="count" min="1" value="<%=count%>"
										style="width: 100px;" disabled>
									<button type="button" class="btn btn-danger px-4"
										onclick="location.href='Delete.jsp?gid=<%=g%>'">删除</button>
								</div>
							</div>
						</div>
						<%
							}
									}
								}
						%>
						<button type="submit" class="btn btn-primary px-4"
							style="margin: 10px 20px;">结算</button>
					</form>
					<%
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