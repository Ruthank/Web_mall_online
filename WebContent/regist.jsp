<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.security.MessageDigest"%>

<%  
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String initpwd = request.getParameter("password");
    String repeat_pass = request.getParameter("password2");
    String iden = request.getParameter("identity");
    
    
	MessageDigest md5 = MessageDigest.getInstance("md5");
	String MD5pwd = "";
	byte[] by = md5.digest(initpwd.getBytes());
	for (int i = 0; i < by.length; i++) {
		MD5pwd += Byte.toString(by[i]);
	}
    //out.println(iden);
    
    Connection conn = null;
    String Sql1 = "INSERT INTO logincheck (ID, password) VALUES (?, ?)";
    String Sql2 = "INSERT INTO IDENTITY (ID, iden) VALUES (?, ?)";
    String Driver = "com.mysql.jdbc.Driver";
    String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
    String rootname="root";   //登录账号
    String rootpass="Z4rpoJT<ydq+";  //登录密码
    
    
    try {
        Class.forName(Driver);// 动态加载mysql驱动
        conn = DriverManager.getConnection(url,rootname,rootpass);
        PreparedStatement stmt = (PreparedStatement) conn.prepareStatement(Sql1);
        //String createUser = "CREATE TABLE logincheck(ID varchar(255), password varchar(255))";
        stmt.setString(1, username);
        stmt.setString(2, MD5pwd);
        stmt.executeUpdate();
        
        stmt = (PreparedStatement) conn.prepareStatement(Sql2);
        stmt.setString(1, username);
        stmt.setString(2, iden);
        stmt.executeUpdate();
        
        out.print("<script>alert('注册完成！'); window.location.replace(\"login.html\");</script>");
        
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