<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="exp5.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 添加商品至购物车 -->
<%
	/* 将商品加入购物车，要区分登录用户与未登录用户 */
	//用户是否登录
	boolean isSignin = (Boolean) session.getAttribute("isSignin");
	//取出要加入购物车的商品id
	int gid = Integer.parseInt(request.getParameter("gid"));
	//取出商品数量
	int count = Integer.parseInt(request.getParameter("count"));
	/*若为登录用户，则将物品直接存入数据库*/
	if (isSignin) {
		//从session中获取用户id
		int uid = (Integer) session.getAttribute("uid");
		Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
		PreparedStatement select = conn.prepareStatement("select * from cart where uid = ? and gid = ?");
		PreparedStatement pstmt = conn.prepareStatement("update cart set count = ? where uid = ? and gid = ?;");
		//从数据库查询是否有uid用户的gid商品信息
		select.setInt(1, uid);
		select.setInt(2, gid);
		ResultSet rs = select.executeQuery();
		//购物车中存在相关商品信息则增加数量，否则插入新纪录
		if (rs.next()) {
			pstmt.setInt(1, rs.getInt(4) + count);
			pstmt.setInt(2, uid);
			pstmt.setInt(3, gid);
			pstmt.execute();
		} else {
			//插入新纪录
			PreparedStatement update = conn.prepareStatement("insert into cart values(?,?,?,?,?,?)");
			select = conn.prepareStatement("select * from goods where gid= ?");
			select.setInt(1, gid);
			ResultSet r = select.executeQuery();
			while (r.next()) {
				String gname = r.getString(2);
				double price = r.getDouble(3);
				String imgpath = r.getString(5);
				update.setInt(1, uid);
				update.setInt(2, gid);
				update.setString(3, r.getString(2));
				update.setInt(4, count);
				update.setFloat(5, r.getFloat(3));
				update.setString(6, r.getString(5));
				update.executeUpdate();
			}
		}
	} else {
		//若为未登录用户，则将商品信息存入session
		HashMap<String, Integer> tempCart = (HashMap<String, Integer>) session.getAttribute("tempcart");
		if (tempCart == null) {
			tempCart = new HashMap<String, Integer>();
		}
		//商品存在，则增加数量
		if (tempCart.containsKey(String.valueOf(gid))) {
			tempCart.put(String.valueOf(gid), tempCart.get(String.valueOf(gid)) + count);
		} else {
			//否则增加新商品信息
			tempCart.put(String.valueOf(gid), count);
		}
		session.setAttribute("tempcart", tempCart);
		//out.print(tempCart);
	}
	response.sendRedirect("ShoppingCart.jsp");
%>