<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/study?"
			+ "useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "live5590";
	Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
	Statement stmt = conn.createStatement();
	
	String sqlCount = "SELECT COUNT(*) FROM MP_BOARD";
	String sqlSort = "SELECT idx FROM MP_BOARD ORDER BY idx DESC";
	String sqlList = "SELECT idx, name, title, time, hit FROM MP_BOARD ORDER BY idx desc";
	String sqlInsert = "INSERT INTO MP_BOARD (name, password, title, memo) VALUES (?,?,?,?)";
	String sqlView = "SELECT name, title, memo, time, hit FROM MP_BOARD WHERE idx =";
	String sqlPass = "SELECT password FROM MP_BOARD WHERE idx =";
	String sqlDelete = "DELETE FROM MP_BOARD WHERE idx =";
	String sqlUpdate = "SELECT name, title, memo, password FROM MP_BOARD WHERE idx=";
	String sqlPaging = "SELECT idx, name, title, time FROM MP_BOARD ORDER BY idx DESC LIMIT ";
	String sqlSearchA = "SELECT idx, name, title, time FROM MP_BOARD WHERE ";
	String sqlSearchB = "SELECT COUNT(*) FROM MP_BOARD WHERE ";
%>

<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
</head>
<body>

</body>
</html>