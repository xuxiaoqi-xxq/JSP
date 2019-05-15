<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="exp5.ConnectionDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 删除购物车商品 -->
<%
	int gid = Integer.parseInt(request.getParameter("gid"));
	boolean isSignin = (Boolean) session.getAttribute("isSignin");
	//非登录用户删除购物车商品
	if (!isSignin) {
		HashMap<String, Integer> tempCart = (HashMap) session.getAttribute("tempcart");
		tempCart.remove(String.valueOf(gid));
		out.print(tempCart);
		session.setAttribute("tempcart", tempCart);
	} else {
		//登录用户删购物车商品
		int uid = (Integer) session.getAttribute("uid");
		Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
		PreparedStatement pstmt = conn.prepareStatement("delete from cart where uid = ? and gid=?");
		pstmt.setInt(1, uid);
		pstmt.setInt(2, gid);
		pstmt.execute();
	}
	response.sendRedirect("ShoppingCart.jsp");
%>