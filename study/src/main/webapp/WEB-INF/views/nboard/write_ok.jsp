<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<html>
<head>
<script type="text/javascript">
	
	$(document).ready(function(){
		self.window.alert("저장되었습니다.");
		location.href = "index.jsp";
	});	
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<% 
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String memo = request.getParameter("memo");
		
		try {

			PreparedStatement pstmt = conn.prepareStatement(sqlInsert);
			
			pstmt.setString(1, name);
			pstmt.setString(2, password);
			pstmt.setString(3, title);
			pstmt.setString(4, memo);
			
			pstmt.execute();
			pstmt.close();
			
		} catch(SQLException e) {
			out.println(e.toString());
		}
	%>
</body>
</html>