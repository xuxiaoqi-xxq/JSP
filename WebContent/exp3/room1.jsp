<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
    <title>欢迎来到聊天室</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="alert alert-light alert-dismissible fade show" role="alert">
                    <span class="badge badge-primary"><%= (String)session.getAttribute("userName")%></span>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="location.href='exitRoom.jsp'">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
        </div>
        <div class="row">

            <!-- 在线用户 -->
            <div class="col-lg-2">

                <div class="card" style="height:605px;overflow: scroll;">
                    <div class="card-body">
                        <h6 class="card-title">在线用户</h6>
                        <hr>
                        <%
                        	response.setHeader("refresh", "10");
                        	//显示所有在线用户
                        	String user = (String)session.getAttribute("userName");
                        	HashSet<String> presentUsers = (HashSet)application.getAttribute("presentUsers");
                        	if(presentUsers==null){
                        		presentUsers = new HashSet<String>();
                        	}
                        	presentUsers.add(user);
                        	application.setAttribute("presentUsers", presentUsers);
                        	for(String u:presentUsers){
                        		out.print(" <span class=\"badge badge-light\">"+u+"</span><br>");
                        	}
                        %>
                    </div>
                </div>
            </div>

            <!-- 公聊窗口 -->
            <div class="col-lg-5">
                <!-- 显示消息 -->
                <div class="card" style="height: 400px;overflow: scroll;">
                    <div class="card-body">
                        <span class="badge badge-primary">公聊窗口</span>
                        <br>
						<%
							ArrayList<String> messages = (ArrayList)application.getAttribute("publicMsgs");
							if(messages != null){
								//获取用户登录时间
								Date loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse((String)session.getAttribute("loginTime"));
								for(int i=0;i<messages.size();i++){
									String msg = messages.get(i);
									//获取消息发送时间
									int index1 = msg.indexOf("&nbsp;");
									int index2 = msg.indexOf("<br>");
									Date sendTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(msg.substring(index1+24, index2));
									if(loginTime.before(sendTime)){
										out.print(msg);
									}else{
										out.print("");
									}
								}
							}
						%>
                    </div>
                </div>
                
                <!-- 发送消息 -->
                <div class="card">
                    <div class="card-body">
                        <form action="publicMessage.jsp" method="POST">
                            <div class="form-group">
                                <label for=""></label>
                                <textarea class="form-control" name="pubmsg" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">发送消息</button>
                        </form>
                    </div>
                </div>

            </div>
            <!-- 私聊窗口 -->
            <div class="col-lg-5">
                <!-- 显示消息 -->
                <div class="card" style="height: 400px;overflow: scroll;">
                    <div class="card-body">
                        <span class="badge badge-primary">私聊窗口</span>
                        <br>
                        <%
                        	ArrayList<String> pmsgs = (ArrayList)application.getAttribute("privateMsgs");
                       		if(pmsgs != null) {
                       			for(int i=0;i<pmsgs.size();i++){
                       				String pmsg = pmsgs.get(i);
                       				String sender = pmsg.substring(0,pmsg.indexOf("&nbsp;"));
                       				String reciver = pmsg.substring(pmsg.indexOf("&nbsp;")+6,pmsg.lastIndexOf("&nbsp;"));
                       				String time = pmsg.substring(pmsg.lastIndexOf("&nbsp;")+6,pmsg.indexOf("<br>"));
                       				String rmsg = pmsg.substring(pmsg.indexOf("<br>")+4,pmsg.length());
                       				if(reciver.equals(user)){
                       					out.print(time+"&nbsp;&nbsp;"+sender+"&nbsp;对你说:<br>"+rmsg+"<br><br>");
                       				}
                       				if(sender.equals(user)){
                       					out.print(time+"&nbsp;&nbsp;你对&nbsp;"+reciver+"&nbsp;说:<br>"+rmsg+"<br><br>");
                       				}
                       			}
                       		}
                        %>
                    </div>
                </div>
                <!-- 选择用户 -->
                <div class="card">
                    <div class="card-body">
                        <form action="privateMessage.jsp" method="POST">
                            <div class="form-group">
                                <textarea class="form-control" name="primsg" rows="2"></textarea>
                                <select class="form-control" name="priuser">
                                    <%
                                    	if(presentUsers.size() != 1){
                                    		for(String u : presentUsers){
                                        		if(!u.equals(user)){
                                        			out.print("<option>"+u+"</option>");
                                        		}
                                        	}
                                    	}else{
                                    		out.print("<option disabled>当前无可私聊用户</option>");
                                    	}
                                    %>
                                </select>
                                <button type="submit" class="btn btn-primary mt-2">发送消息</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>

</html>