<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--退出登录  -->
<%
	HashSet<String> allUsers = (HashSet)application.getAttribute("allUsers");
	allUsers.remove((String)session.getAttribute("userName"));
	session.invalidate();
	response.sendRedirect("login.jsp");
%>