
<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@page import="java.sql.*" %>
<%@page import="java.security.MessageDigest"%>

<%
	request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String initpwd = request.getParameter("password");
    
	MessageDigest md5 = MessageDigest.getInstance("md5");
	String MD5pwd = "";
	byte[] by = md5.digest(initpwd.getBytes());
	for (int i = 0; i < by.length; i++) {
		MD5pwd += Byte.toString(by[i]);
	}
        
    Connection conn = null;
    
    String Driver = "com.mysql.jdbc.Driver";
    String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
    String rootname="root";   //登录账号
    String rootpass="Z4rpoJT<ydq+";  //登录密码
    String Sql = "SELECT * FROM logincheck WHERE ID ='" + username + "';";
    String Sql2 = "SELECT * FROM IDENTITY WHERE ID ='" + username + "';";

	try {
		Class.forName(Driver);// 动态加载mysql驱动
		conn = DriverManager.getConnection(url, rootname, rootpass);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql);
		if (rs.next()) {
			if (MD5pwd.equals(rs.getObject("password"))) {
				String flag1 = "test";
	            session.setAttribute("flag",flag1);
	            request.getSession().setAttribute("name",username);
	            
	            ResultSet rs2 = stmt.executeQuery(Sql2);
	            String iden = "customer";
	            
	            if (rs2.next()) {
	            	if ("seller".equals(rs2.getObject("iden"))) iden = "seller";
	            }
	            
	            if (iden.equals("seller")) {
	            	request.getRequestDispatcher("mypage.jsp").forward(request, response);
	            } else {
	            	request.getRequestDispatcher("buypage.jsp").forward(request, response);
	            }
			} else {
				out.print("<script>alert('密码错误！');history.back(-1);</script>");
			}
		} else {
			out.print("<script>alert('用户不存在！');history.back(-1);</script>");
		}
		
		
	} catch (SQLException e) {
		out.println("MySQL操作错误！");
		e.printStackTrace();
	} catch (Exception e) {
		out.println("数据库连接错误！");
		e.printStackTrace();
	} finally {
		if (conn != null)
			conn.close();
	}
%>
