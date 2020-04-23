<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	HttpSession HS = request.getSession();
	String name = (String)request.getSession().getAttribute("name");
	if (name == null) {
		out.println("<script> alert(\"请先登录！\"); window.location.replace(\"login.html\"); </script>");
	}
	
	request.setCharacterEncoding("utf-8");
	
    Connection conn = null;
    String Sql = "INSERT INTO goods (owner, name, price) VALUES (?, ?, ?)";
    String Driver = "com.mysql.jdbc.Driver";
    String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
    String rootname="root";   //登录账号
    String rootpass="Z4rpoJT<ydq+";  //登录密码
    String goodName = request.getParameter("goodname");
    String goodPrice = request.getParameter("goodprice");
    
    
    try {
        Class.forName(Driver);// 动态加载mysql驱动
        conn = DriverManager.getConnection(url,rootname,rootpass);
        PreparedStatement stmt = (PreparedStatement) conn.prepareStatement(Sql);
        stmt.setString(1, name);
        stmt.setString(2, goodName);
        stmt.setString(3, goodPrice);
        stmt.executeUpdate();
        
        //out.print("<script>alert('添加成功！'); history.back(-1);</script>");
        response.sendRedirect("mypage.jsp");
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