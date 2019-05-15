<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 退出聊天室 -->
<%
	HashSet<String> presentUsers = (HashSet)application.getAttribute("presentUsers");
	presentUsers.remove((String)session.getAttribute("userName"));
	response.sendRedirect("select.jsp");
%>