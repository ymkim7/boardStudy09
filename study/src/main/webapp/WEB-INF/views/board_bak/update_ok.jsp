<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		self.window.alert("저장되었습니다.");
		location.href = "main.jsp";
	});	
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<% 
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/study";
		String dbId = "root";
		String dbPass = "live5590";
		String password = "";
		
		try {
			request.setCharacterEncoding("UTF-8");
			String pw = request.getParameter("password");
			String title = request.getParameter("title");
			String memo = request.getParameter("memo");
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			String sql = "SELECT password FROM MP_BOARD WHERE idx =" + idx;
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				password = rs.getString(1);
			}
			
			if(password.equals(pw)) {
				sql = "UPDATE MP_BOARD SET title='" + title + "', memo='" + memo + "' WHERE idx=" + idx;
				stmt.executeUpdate(sql);
	%>
	
	<script type="text/javascript">
	
		self.window.alert("글이 수정되었습니다.");
		location.href = "main.jsp?idx=<%=idx%>";
		
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