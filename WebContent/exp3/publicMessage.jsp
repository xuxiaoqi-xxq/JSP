<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  处理公聊信息-->
<%
	String msg = request.getParameter("pubmsg");
	String user = (String) session.getAttribute("userName");
	ArrayList<String> messages = (ArrayList) application.getAttribute("publicMsgs");
	if (messages == null) {
		messages = new ArrayList<String>();
	}
	msg = user + "&nbsp;&nbsp;&nbsp;&nbsp;" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
			+ "<br>" + msg + "<br><br>";
	messages.add(msg);
	application.setAttribute("publicMsgs", messages);
	response.sendRedirect("room1.jsp");
%>