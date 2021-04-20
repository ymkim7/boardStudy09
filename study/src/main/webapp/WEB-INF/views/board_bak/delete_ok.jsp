<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
		String password = null;
		String pw = request.getParameter("password");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			String sql = "SELECT password FROM MP_BOARD WHERE idx =" + idx;
			ResultSet rs = stmt.executeQuery(sql);
			
			
			if(rs.next()) {
				password = rs.getString(1);
			}
			
			if(password.equals(pw)) {
				sql = "DELETE FROM MP_BOARD WHERE idx =" + idx;
				stmt.executeUpdate(sql);
	%>
	
	<script type="text/javascript">
	
		self.window.alert("삭제 완료");
		location.href = "main.jsp";
		
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