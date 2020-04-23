<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.security.MessageDigest"%>
<%
	MessageDigest md5 = MessageDigest.getInstance("md5");
	String MD5pwd = "";
	byte[] by = md5.digest(initpwd.getBytes());
	for (int i = 0; i < by.length; i++) {
		MD5pwd += Byte.toString(by[i]);
	}
%>