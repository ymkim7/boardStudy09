<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int idx = Integer.parseInt(request.getParameter("idx")); %>
<% int pg = Integer.parseInt(request.getParameter("pg")); %>
<% 
	try {
		
		String sql = sqlView + idx;
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
<script type="text/javascript">
	
	$(document).ready(function(){

		$("#listBtn").on("click", function(){
			window.location = "index.jsp";
		});
		
		$("#updateBtn").on("click", function(){
			var updateYN = confirm("수정하시겠습니까?");
            
            if(updateYN == true) {
	            location.href = "update.jsp?idx=<%=idx%>&pg=<%=pg%>";
            }
		});

		$("#deleteBtn").on("click", function() {
			var deleteYN = confirm("삭제하시겠습니까?");
            
            if(deleteYN == true) {
	            location.href = "delete.jsp?idx=<%=idx%>&pg=<%=pg%>";
            }
		});
		
	});
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<hr/>
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
			String sqlTwo = "UPDATE MP_BOARD SET hit =" + hit + " WHERE idx =" + idx;
			stmt.executeUpdate(sqlTwo);
			rs.close();
			stmt.close();
			conn.close();
		}
	} catch(SQLException e) {
		out.println(e.toString());
	}
%>
	</table>
	<hr/>
	
	<div>
		<button type="button" id="listBtn" name="listBtn">목록</button>
		<button type="button" id="updateBtn" name="updateBtn">수정</button>
		<button type="button" id="deleteBtn" name="deleteBtn">삭제</button>
	</div>
</body>
</html>