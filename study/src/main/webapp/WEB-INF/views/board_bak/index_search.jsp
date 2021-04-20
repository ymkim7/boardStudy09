<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int pg = Integer.parseInt(request.getParameter("pg"));
%>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	var cnt = 0;
	
	$(document).ready(function(){
		var idx = $("#idx").val();
		
		$("#writeBtn").on("click", function(){
			window.location = "write.jsp?pg=<%=pg%>";
		});
		
		$("#boardBtn").on("click", function(){
			window.location = "index.jsp?pg=<%=pg%>";
		});
	});	
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<br/>
	<div>
		<input type="button" id="boardBtn" name="boardBtn" value="전체목록"/>
	</div>
	<hr/>

	<table>
		<tr>
			<td style="width:20%;">번호</td>
			<td style="width:20%;">제목</td>
			<td style="width:20%;">작성자</td>
			<td style="width:20%;">작성일</td>
		</tr>
	
	<% 
		request.setCharacterEncoding("UTF-8");
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn= null;
		Statement stmt = null;
		ResultSet rs = null;
		int total = 0;
	  
		String jdbcUrl = "jdbc:mysql://localhost:3306/study";
		String dbId = "root";
		String dbPass = "live5590";
		String sk = request.getParameter("sk");
		String sv = request.getParameter("sv");
		String sql = "SELECT * FROM MP_BOARD WHERE "  + sk + " like '%" + sv  + "%' ORDER BY idx DESC;";
		  	 
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
	%>
		
		<tr style="height:25px; align:center">
			<td><%=rs.getString("idx") %></td>
			<td style="align:left;"><a href="view.jsp?idx=<%=rs.getString("idx") %>&pg=<%=pg%>"><%=rs.getString("title") %></a></td>
			<td style="align:center;"><%=rs.getString("name") %></td>
			<td style="align:center;"><%=rs.getString("time") %></td>
		</tr>
	
	<%
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch(SQLException e) {
			out.println(e.toString());
		}
	%>
	
	</table>
	
	<br/>
	
	<div style="text-align:center;">
		<form name="searchForm" method="post" action="index_search.jsp?pg=<%=pg%>">
			<!-- 검색키 : search key -->
			<select name="sk">
				<option value="title">제목</option>
				<option value="name">작성자</option>
			</select>
			
			<!-- 검색값 : search value -->
			<input type="text" name="sv"/>
			<input type="submit" value="검색버튼"/>
			<input type="button" id="writeBtn" name="writeBtn" value="글쓰기"/>
		</form>
	</div>
</body>
</html>