<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int pg = Integer.parseInt(request.getParameter("pg")); %>
<%
	//한페이지에 보일 게시물수 수
	final int ROWSIZE = 10;
	//아래에 보일 페이지 최대개수
	final int BLOCK = 10;
	//해당 페이지 시작번호
	int start = (pg - 1) * ROWSIZE;
	//해달 페이지 끝번호
	int end = (pg * ROWSIZE);
	//전체 페이지수
	int allPage = 0;
	//시작 블럭수
	int startPage = ((pg - 1) / BLOCK * BLOCK) + 1;
	//끝 블럭
	int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK;
	
	int total = 0;
%>
<html>
<head>
<script type="text/javascript">
	
	$(document).ready(function(){
		var formObj = $("form[name='searchForm']");
		
		$("#writeBtn").on("click", function(){
			window.location = "write.jsp?pg=<%=pg%>";
		});
		
		$("#boardBtn").on("click", function(){
			window.location = "index.jsp";
		});
		
		$("#search_btn").on("click", function(){
			formObj.attr("action", "index_search.jsp?pg=1");
			formObj.attr("method", "post");
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
	<hr/>

	<table>
		<tr>
			<td style="width:5%;">번호</td>
			<td style="width:20%;">제목</td>
			<td style="width:20%;">작성자</td>
			<td style="width:20%;">작성일</td>
		</tr>
	
	<% 
		String sk = request.getParameter("sk");
		String sv = request.getParameter("sv");
		ResultSet rs = null;
		String sql = sqlSearchA + sk + " like '%" + sv + "%'" + " ORDER BY idx DESC LIMIT " + start + "," + ROWSIZE;
		  	 
		try {
			String sqlCnt = sqlSearchB + sk + " like '%" + sv + "%'";
			rs = stmt.executeQuery(sqlCnt);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			allPage = (int)Math.ceil(total/(double)ROWSIZE);
			
			if(endPage > allPage) {
				endPage = allPage;
			}
			
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
	
	<div style="text-align:center;">
		<%
			if(pg > BLOCK) {
		%>
				[<a href="index_search.jsp?pg=1&sk=<%=sk%>&sv=<%=sv%>">◀◀</a>]
				[<a href="index_search.jsp?pg=<%=startPage-1%>&sk=<%=sk%>&sv=<%=sv%>">◀</a>]
		<%
			}
		%>
		
		<%
			for(int i = startPage; i <= endPage; i++) {
				if(i == pg) {
		%>
					<a style="text-decoration:underline;"><b>[<%=i %>]</b></a>
		<%
				} else {
		%>
					[<a href="index_search.jsp?pg=<%=i %>&sk=<%=sk%>&sv=<%=sv%>"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage < allPage) {
		%>
				[<a href="index_search.jsp?pg=<%=endPage+1%>&sk=<%=sk%>&sv=<%=sv%>">▶</a>]
				[<a href="index_search.jsp?pg=<%=allPage%>&sk=<%=sk%>&sv=<%=sv%>">▶▶</a>]
		<%
			}
		%>
	</div>
	<hr/>
	
	<div style="text-align:center; display:inline-block;">
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
	
	<div style="float:right;">
		<button type="button" id="boardBtn" name="boardBtn">전체목록</button>
	</div>
</body>
</html>