<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int pg = Integer.parseInt(request.getParameter("pg")); %>
<html>
<head>
<script type="text/javascript">
	
	$(document).ready(function(){
		var formObj = $("form[name='searchForm']");
		
		$("#writeBtn").on("click", function(){
			window.location = "write.jsp?pg=<%=pg%>";
		});
		
		$("#boardBtn").on("click", function(){
			window.location = "index.jsp?pg=<%=pg%>";
		});
		
		$("#search_btn").on("click", function(){
			formObj.submit();
		});
	});	
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<hr/>
	<h4>게시판 목록</h4>
	<div>
		<button type="button" id="boardBtn" name="boardBtn">전체목록</button>
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
		String sk = request.getParameter("sk");
		String sv = request.getParameter("sv");
		String sql = "SELECT * FROM MP_BOARD WHERE "  + sk + " like '%" + sv  + "%' ORDER BY idx DESC;";
		  	 
		try {
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
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
	<hr/>
	
	<div style="text-align:center;">
		<form name="searchForm" method="post" action="index_search.jsp?pg=<%=pg%>">
			<!-- 검색키 : search key -->
			<select name="sk">
				<option value="title">제목</option>
				<option value="name">작성자</option>
			</select>
			
			<!-- 검색값 : search value -->
			<input type="text" name="sv" style="width:100px;"/>
			<button type="button" id="search_btn" name="search_btn">검색</button>
			<button type="button" id="writeBtn" name="writeBtn">글쓰기</button>
		</form>
	</div>
</body>
</html>