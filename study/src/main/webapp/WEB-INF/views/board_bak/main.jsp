<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
request.setCharacterEncoding("UTF-8");
Class.forName("com.mysql.jdbc.Driver");
String jdbcUrl = "jdbc:mysql://localhost:3306/study";
String dbId = "root";
String dbPass = "live5590";
%>