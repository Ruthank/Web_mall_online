<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>删除货物</title>
</head>
<body>

	<%
		request.setCharacterEncoding("utf-8");
		String goodName = request.getParameter("good");
	
		Connection conn = null;
		String Sql = "delete from cart where name='" + goodName + "';";
		
		String Driver = "com.mysql.jdbc.Driver";
		String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
		String rootname="root";   //登录账号
		String rootpass="Z4rpoJT<ydq+";  //登录密码
		
		try {
	        Class.forName(Driver);
	        conn = DriverManager.getConnection(url,rootname,rootpass);
	        Statement stmt = conn.createStatement();
	        stmt.executeUpdate(Sql);
	        //out.print("<script>alert('删除成功！'); </script>");
	        response.sendRedirect("buypage.jsp");
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