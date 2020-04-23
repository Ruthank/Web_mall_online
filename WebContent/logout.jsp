<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.getSession().removeAttribute("name");
	out.println("<script> window.location.replace(\"login.html\"); </script>");
%>

</by>
</html>