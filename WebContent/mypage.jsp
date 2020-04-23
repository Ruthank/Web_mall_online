<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
// 	response.setDateHeader("Expires", 0);
// 	response.setHeader("Cache-Control", "no-cache");
// 	response.setHeader("Pragma", "no-cache");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>我是卖家</title>
	<link rel="stylesheet" type="text/css" href="css/button.css"/>

	<script>
	
		history.go(1);
		
		function update() {
			var goodname = document.getElementById("goodname").value;
			var forbiddenArray =['\'','<','>','#','\'','\''];
			var re = '';
			for(var i=0;i<forbiddenArray.length;i++){
				if(i==forbiddenArray.length-1) re+=forbiddenArray[i];
				else re += forbiddenArray[i]+"|";
			}
			var pattern = new RegExp(re,"g");
			if(pattern.test(goodname)){
				alert("货物名称包含非法字符！");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<%

		HttpSession HS = request.getSession();
		String name = (String)request.getSession().getAttribute("name");
		if (name == null) {
			out.println("<script> alert(\"请先登录！\"); window.location.replace(\"login.html\"); </script>");
		}
		request.setCharacterEncoding("utf-8"); 	 
	%>
	
	<h2>您好，卖家<%=name %>。</h2>
	<a href="logout.jsp"> 退出登录 </a>
	<a href="updatepasswd.jsp"> 修改密码 </a>
	
	<form method="post" name="myform" action="addgood.jsp;" onsubmit="return update();">
		<div>
			<label for="goodname">货物名称</label>
			<input type="text" id="goodname" name="goodname" placeholder="名称" value="" />
		</div>
		<div>
			<label for="goodprice">货物价格</label>
			<input type="number" id="goodprice" name="goodprice" placeholder="价格" value="" />
		</div>
		<div>
			<input type="submit" value="上架货物" /> 
		</div>
	</form>
	
	
	<h2> 我上架的商品： </h2>
	
	<%
        
    	Connection conn = null;
    
    	String Driver = "com.mysql.jdbc.Driver";
	    String url="jdbc:mysql://127.0.0.1:3306/javademo?serverTimezone=UTC";
	    String rootname="root";   //登录账号
	    String rootpass="Z4rpoJT<ydq+";  //登录密码
	    String Sql = "SELECT * FROM goods WHERE owner ='" + name + "';";

		try {
			Class.forName(Driver);// 动态加载mysql驱动
			conn = DriverManager.getConnection(url, rootname, rootpass);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql);
			while (rs.next()) {
				String g = (String) rs.getObject("name");
				String p = (String) rs.getObject("price");
				%>
				<form method="post" action="deletegood.jsp" name="goodform" >
					<input type="hidden" name="good" value="<%=g %>"/>
					<div><h3> <label>货物名称：</label> <%=g%> <label name="price">售价（元）：</label> <%=p %>
					<input type="submit" value="删除货物" /> </h3>  </div>
				</form>
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