<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uname = request.getParameter("uname");
	String pwd = request.getParameter("pwd");
	String type=request.getParameter("type");
	String code = request.getParameter("code");
	if(code.equalsIgnoreCase((String)session.getAttribute("code"))){
		if(type.equals("teacher")&&uname.equals("teacher")&&pwd.equals("teacher")){
			response.sendRedirect("teacher.jsp");
		}else if(type.equals("student")&&uname.equals("student")&&pwd.equals("student")){
			response.sendRedirect("student.jsp");
		}
		else{
			out.print("<script>alert('请填写正确的信息');window.location.href='login.jsp'</script>");
		}
	}else{
		out.print("<script>alert('验证码输入错误');window.location.href='login.jsp'</script>");
	}	
%>