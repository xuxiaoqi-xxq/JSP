<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 处理私聊信息 -->
<%
	String msg = request.getParameter("primsg");
	String reciver = request.getParameter("priuser");
	String sender = (String) session.getAttribute("userName");
	ArrayList<String> messages = (ArrayList) application.getAttribute("privateMsgs");
	if (messages == null) {
		messages = new ArrayList<String>();
	}
	msg = sender + "&nbsp;" + reciver + "&nbsp;"
			+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + "<br>" + msg;
	messages.add(msg);
	application.setAttribute("privateMsgs", messages);
	response.sendRedirect("room1.jsp");
%>