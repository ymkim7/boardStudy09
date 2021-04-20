<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int idx = Integer.parseInt(request.getParameter("idx")); %>
<% int pg = Integer.parseInt(request.getParameter("pg")); %>
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
		String password = "";
		
		try {
			String pw = request.getParameter("password");
			String title = request.getParameter("title");
			String memo = request.getParameter("memo");

			String sql = sqlPass + idx;
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
		location.href = "index.jsp?idx=<%=idx%>&pg=<%=pg%>";
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