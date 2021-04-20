<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int pg = Integer.parseInt(request.getParameter("pg"));
%>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		self.window.alert("저장되었습니다.");
		location.href = "index.jsp?pg=<%=pg%>";
	});	
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<% 
		//받아노는 값을 UTF-8로 인코딩
		request.setCharacterEncoding("UTF-8");
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/study";
		String dbId = "root";
		String dbPass = "live5590";
		
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String memo = request.getParameter("memo");
		
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
			String sql = "INSERT INTO MP_BOARD (name, password, title, memo) VALUES (?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
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