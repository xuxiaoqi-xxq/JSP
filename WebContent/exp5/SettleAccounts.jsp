<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="exp5.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 结账 -->
<%
	//获取输入的金额
	double total = Double.parseDouble(request.getParameter("pay"));
	//获取实际应付金额
	double realTotal = (Double) session.getAttribute("total");
	if (total == realTotal) {
		/*登录用户结账*/
		int uid = (Integer) session.getAttribute("uid");
		//从数据库取出用户购物车信息
		Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
		PreparedStatement pstmt = conn.prepareStatement("select * from cart where uid = ?");
		pstmt.setInt(1, uid);
		ResultSet rs = pstmt.executeQuery();
		//预更新语句，购买后将商品库存相应减少
		PreparedStatement update = conn.prepareStatement("update goods set stock = ? where gid = ?");
		//预查询语句，查询商品库存
		PreparedStatement select = conn.prepareStatement("select stock from goods where gid=?");
		//将信息存入数据库订单表
		PreparedStatement insert = conn.prepareStatement("insert into uorder(uid,gid,buytime,count) values(?,?,?,?)");
		//Date now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(new Date().toString());
		while (rs.next()) {
			int gid = rs.getInt(2);
			int count = rs.getInt(4);
			//更新订单表
			insert.setInt(1, uid);
			insert.setInt(2, gid);
			insert.setObject(3, new Date());
			insert.setInt(4, count);
			insert.executeUpdate();
			//查出商品库存，并减少相应商品库存
			select.setInt(1, gid);
			ResultSet r = select.executeQuery();
			if(r.next()){
				int stock = r.getInt(1);
				update.setInt(1, stock-count);
				update.setInt(2, gid);
				update.executeUpdate();
			}
		}
		//删除购物车中商品
		PreparedStatement del = conn.prepareStatement("delete from cart where uid = ?");
		del.setInt(1, uid);
		del.executeUpdate();
		response.sendRedirect("Order.jsp");
	} else {
		//输入金额错误则重新输入
		response.sendRedirect("Pay.jsp");
	}
%>