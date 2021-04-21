<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int idx = Integer.parseInt(request.getParameter("idx")); %>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<% 
		String password = null;
		String pw = request.getParameter("password");
		
		try {
			String sql = sqlPass + idx;
			ResultSet rs = stmt.executeQuery(sql);
			
			
			if(rs.next()) {
				password = rs.getString(1);
			}
			
			if(password.equals(pw)) {
				sql = sqlDelete + idx;
				stmt.executeUpdate(sql);
	%>
	
	<script type="text/javascript">
		self.window.alert("삭제 완료");
		window.close();
	</script>
	
	<%
		rs.close();
		stmt.close();
		conn.close();
		
			} else {
	%>
	
	<script type="text/javascript">	
		self.window.alert("비밀번호를 틀렸습니다.");
		location.href="javascript:history.back()";	
	</script>
	
	<%
			}
		} catch(SQLException e) {
			out.println(e.toString());
		}
	%>
</body>
</html>