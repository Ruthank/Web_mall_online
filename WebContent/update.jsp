<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.sql.*" %>
 <%@page import="java.security.MessageDigest"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改密码</title>
</head>
<body>
	<%
		String name = (String)request.getSession().getAttribute("name");
		if (name == null) {
			out.println("<script> alert(\"请先登录！\"); window.location.replace(\"login.html\"); </script>");
		}
		request.setCharacterEncoding("utf-8"); 	
		
		String newpasswd = request.getParameter("password");
		MessageDigest md5 = MessageDigest.getInstance("md5");
		String MD5pwd = "";
		byte[] by = md5.digest(newpasswd.getBytes());
		for (int i = 0; i < by.length; i++) {
			MD5pwd += Byte.toString(by[i]);
		}
	      
		
		Connection conn = null;
		String Sql = "delete from logincheck where ID='" + name + "';";
		String Sql2 = "INSERT INTO logincheck (ID, password) VALUES (\"" + name + "\", \"" + MD5pwd + "\");";
		String Driver = "com.mysql.jdbc.Driver";
		String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
		String rootname="root";   //登录账号
		String rootpass="Z4rpoJT<ydq+";  //登录密码
		
		try {
	        Class.forName(Driver);
	        conn = DriverManager.getConnection(url,rootname,rootpass);
	        Statement stmt = conn.createStatement();
	        stmt.executeUpdate(Sql);
	        stmt.executeUpdate(Sql2);
	        response.sendRedirect("logout.jsp");
	    } catch (SQLException e) {
	        out.println("MySQL操作错误！");
	        e.printStackTrace();
	    } catch (Exception e) {
	    	out.println("数据库连接错误！");
	        e.printStackTrace();
	    } finally {
	        if(conn != null) conn.close();
	    }
	%>

</body>
</html>