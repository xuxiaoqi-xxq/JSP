<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.awt.BasicStroke"%>
<%@page import="java.awt.Stroke"%>
<%@page import="java.util.Random"%>
<%@page import="java.awt.Font"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Color"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 获取随机颜色 -->
<%!Color getRandomColor() {
		int r = (int) (Math.random() * 100000 % 255);
		int g = (int) (Math.random() * 100000 % 255);
		int b = (int) (Math.random() * 100000 % 255);
		r = r < 80 ? 80 : r;
		g = g < 80 ? 80 : g;
		b = b < 80 ? 80 : b;
		return new Color(r, g, b);
	}%>
<!-- 随机验证码 -->
<%!String getVerifyCode() {
		String code = "";
		int[] chars = new int[62];
		for (int i = 0; i < 10; i++) {
			chars[i] = i + 48;
		}
		for (int i = 10; i < 36; i++) {
			chars[i] = i + 55;
			chars[i + 26] = i + 87;
		}
		for (int i = 0; i < 4; i++) {
			code += String.valueOf((char) chars[(int) (Math.random() * 100000 % 62)]);
		}
		return code;
	}%>

<%
	//设置浏览器不缓存验证码图片
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);

	int width = 60, height = 25;
	//在内存中创建图片
	BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	Graphics2D g = (Graphics2D) image.getGraphics();
	g.setColor(Color.WHITE);
	g.fillRect(0, 0, width, height);
	//画干扰线
	Random random = new Random();
	//设置干扰线的格式
	float[] interval = { 0.03f, 0.02f };
	Stroke stroke = new BasicStroke(0.02f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND, 6.0f, interval, 0);
	for (int i = 0; i < 30; i++) {
		int x1 = (int) (Math.random() * 100000 % 60);
		int x2 = (int) (Math.random() * 100000 % 60);
		int y1 = (int) (Math.random() * 100000 % 60);
		int y2 = (int) (Math.random() * 100000 % 60);
		g.setColor(getRandomColor());
		g.drawLine(x1, y1, x2, y2);
	}
	//写验证码到session
	String code = getVerifyCode();
	session.setAttribute("code", code);
	//写验证码到image
	char[] ch = new char[4];
	for (int i = 0; i < 4; i++) {
		ch[i] = code.charAt(i);
	}
	g.setFont(new Font("Times New Roman", Font.BOLD, 18));
	g.setColor(Color.RED);
	for (int i = 0; i < 4; i++) {
		g.drawString(String.valueOf(ch[i]), 10 + i * 12, 15);
	}
	//输出图像到页面
	ImageIO.write(image, "PNG", response.getOutputStream());
	out.clear();
	out = pageContext.pushBody();
%>