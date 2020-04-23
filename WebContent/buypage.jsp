<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>我是顾客</title>
	<link rel="stylesheet" type="text/css" href="css/button.css"/>
	<script>
		history.go(1);
		function update() {
			location.reload();
			return true;
		}
	</script>
</head>
<body>
	<%
		String name = (String)request.getSession().getAttribute("name");
		if (name == null) {
			out.println("<script> alert(\"请先登录！\"); window.location.replace(\"login.html\"); </script>");
		}
	%>
		<h2>您好，顾客<%=name %>。</h2>
		<a href="logout.jsp"> 退出登录 </a>
		<a href="updatepasswd.jsp"> 修改密码 </a>
	<%	
		request.setCharacterEncoding("utf-8"); 	
    	Connection conn = null;
        
    	String Driver = "com.mysql.jdbc.Driver";
	    String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
	    String rootname="root";   //登录账号
	    String rootpass="Z4rpoJT<ydq+";  //登录密码
	    String Sql1 = "SELECT * FROM cart WHERE owner ='" + name + "';";
	    String Sql2 = "SELECT * FROM goods;";
		try {
			Class.forName(Driver);// 动态加载mysql驱动
			conn = DriverManager.getConnection(url, rootname, rootpass);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql1);
			
			%>
			<h2> 我的购物车： </h2> <br />
			<%
			
			int tot = 0;
			while (rs.next()) {
				tot++;
				String g = (String) rs.getObject("name");
				String p = (String) rs.getObject("price");
				%>
				<form method="post" action="deletecart.jsp" name="goodform2" >
					<input type="hidden" name="good" value="<%=g %>"/>
					<div><h3> <label>货物名称：</label> <%=g%> <label name="price">售价（元）：</label> <%=p %>
					<input type="submit" value="删除" /> </h3>  </div>
				</form>
				<%
			}
			
			if (tot == 0) {
				%>
				<h3>啊偶，购物车是空哒。</h3>
				<%
			}
			
			%>
			<h2> 商品列表： </h2> <br />
			<%
			
			ResultSet rs2 = stmt.executeQuery(Sql2);
			tot = 0;
			while (rs2.next()) {
				tot++;
				String g = (String) rs2.getObject("name");
				String p = (String) rs2.getObject("price");
				String owner = (String) rs2.getObject("owner");
				%>
				<form method="post" action="addcart.jsp" name="goodform1" >
					<input type="hidden" name="name" value="<%=g %>"/>
					<input type="hidden" name="price" value="<%=p %>"/>
					<div><h3> <label>货物名称：</label> <%=g%> <label name="price">售价（元）：</label> <%=p %>
					<label name="owner">卖家：</label> <%=owner %> <input type="submit" value="购买货物" /> </h3>  </div>
				</form>
				<%
			}
			
			if(tot == 0) {
				%>
				<h3>啊偶，还没有卖家上架货物呢，过一会再来看看吧。</h3>
				<%
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
	
	
	
</body>
</html>