<%@page import="java.util.HashMap"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="exp5.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%!void saveCartinfo() {

	}%>
<!-- 验证用户登录或注册信息 -->
<%
	String name = request.getParameter("uname");
	String passwd = request.getParameter("passwd");
	Connection conn = ((ConnectionDB) session.getAttribute("condb")).getConnection();
	Statement stmt = conn.createStatement();
	boolean isExit = false;
	String pass = "";
	String uname = "";
	int uid = 0;
	//判断用户是否存在
	ResultSet rs = stmt.executeQuery("select id,uname,passwd from user;");
	while (rs.next()) {
		if (name.equalsIgnoreCase(rs.getString(2))) {
			uid = rs.getInt(1);
			session.setAttribute("uid", uid);
			uname = rs.getString(2);
			pass = rs.getString(3);
			isExit = true;
			break;
		}
	}
	//保存用户信息到session
	session.setAttribute("isSignin", true);
	session.setAttribute("name", name);
	//如果用户存在，登录并跳转到首页
	if (isExit) {
		if (!name.equalsIgnoreCase(uname) && passwd.equals(pass)) {
			response.sendRedirect("Signin.jsp");
		}
	} else {
		//用户不存在则将用户信息存到数据库
		PreparedStatement pstmt = conn.prepareStatement("insert into user(uname,passwd) values(?,?)");
		pstmt.setString(1, name);
		pstmt.setString(2, passwd);
		pstmt.executeUpdate();
		//查询用户id
		pstmt = conn.prepareStatement("select id from user where uname = ?");
		pstmt.setString(1, name);
		ResultSet r = pstmt.executeQuery();
		if (r.next()) {
			uid = r.getInt(1);
			//uid保存到session中
			session.setAttribute("uid", uid);
		} else {
			out.print("该用户不存在");
		}
	}
	//登录之后将临时购物车内容存进数据库
	HashMap<String, Integer> tempCart = (HashMap) session.getAttribute("tempcart");
	//购物车不为空才进行存储操作
	if (tempCart != null && !tempCart.isEmpty()) {
		PreparedStatement select = conn.prepareStatement("select gname,price,img from goods where gid=? ");
		PreparedStatement insert = conn
				.prepareStatement("insert into cart(uid,gid,gname,count,price,img) values(?,?,?,?,?,?)");
		for (String g : tempCart.keySet()) {
			//查出商品信息再将其存入购物车表
			select.setInt(1, Integer.parseInt(g));
			ResultSet rss = select.executeQuery();
			if (rss.next()) {
				insert.setInt(1, uid);
				insert.setInt(2, Integer.parseInt(g));
				insert.setString(3, rss.getString(1));
				insert.setInt(4, tempCart.get(g));
				insert.setFloat(5, rss.getFloat(2));
				insert.setString(6, rss.getString(3));
				insert.executeUpdate();
			}
		}
	}
	response.sendRedirect("Show.jsp");
%>