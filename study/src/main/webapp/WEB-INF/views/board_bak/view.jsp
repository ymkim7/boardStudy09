<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% 
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/study";
	String dbId = "root";
	String dbPass = "live5590";
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String sql = "SELECT name, title, memo, time, hit FROM MP_BOARD WHERE idx =" + idx;
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			String name = rs.getString(1);
			String title = rs.getString(2);
			String memo = rs.getString(3);
			String time = rs.getString(4);
			int hit = rs.getShort(5);
			hit++;
%>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){

		$("#listBtn").on("click", function(){
			window.location = "main.jsp";
		});
		
		$("#updateBtn").on("click", function(){
			var updateYN = confirm("수정하시겠습니까?");
            
            if(updateYN == true) {
	            location.href = "update.jsp?idx=<%=idx%>";
            }
		});

		$("#deleteBtn").on("click", function() {
			var deleteYN = confirm("삭제하시겠습니까?");
            
            if(deleteYN == true) {
	            location.href = "delete.jsp?idx=<%=idx%>";
            }
		});
		
	});
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<h4>게시글 상세화면</h4>
	<hr/>
	
	<table>
		<tr>
			<td style="align:center;">글번호</td>
			<td><%=idx %></td>
		</tr>
		
		<tr>
			<td style="align:center;">조회수</td>
			<td><%=hit %></td>
		</tr>
		
		<tr>
			<td style="align:center;">이름</td>
			<td><%=name %></td>
		</tr>
		
		<tr>
			<td style="align:center;">작성일</td>
			<td><%=time %></td>
		</tr>
		
		<tr>
			<td style="align:center;">제목</td>
			<td><%=title %></td>
		</tr>
		
		<tr>
			<td style="colspan:2; height:200px;">내용</td>
			<td><%=memo %></td>
		</tr>
		
<%
			sql = "UPDATE MP_BOARD SET hit =" + hit + " WHERE idx =" + idx;
			stmt.executeUpdate(sql);
			rs.close();
			stmt.close();
			conn.close();
		}
	} catch(SQLException e) {
		out.println(e.toString());
	}
%>
	</table>
	<br/>
	
	<div>
		<input type="button" id="listBtn" name="listBtn" value="목록"/>
		<input type="button" id="updateBtn" name="updateBtn" value="수정"/>
		<input type="button" id="deleteBtn" name="deleteBtn" value="삭제"/>
	</div>
</body>
</html>