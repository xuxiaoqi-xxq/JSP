<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user = request.getParameter("user");
	HashSet<String> allUsers = (HashSet)application.getAttribute("allUsers");
	if(allUsers == null){
		allUsers = new HashSet<String>();
	}
	if(allUsers.contains(user)){
		response.sendRedirect("login.jsp");
	}else {
		allUsers.add(user);
		application.setAttribute("allUsers", allUsers);
		session.setAttribute("userName", user);
		session.setAttribute("loginTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		response.sendRedirect("select.jsp");
	}
%>