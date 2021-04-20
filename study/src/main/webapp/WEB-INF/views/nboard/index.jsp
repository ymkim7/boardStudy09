<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<%
	//한페이지에 보일 게시물수 수
	final int ROWSIZE = 10;
	//아래에 보일 페이지 최대개수
	final int BLOCK = 10;
	//기본 페이지값
	int pg = 1;
	//받아온 pg값이 있을때, 다른페이지일때
	if(request.getParameter("pg") != null) {
		//pg값 저장
		pg = Integer.parseInt(request.getParameter("pg"));
	}
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
		
		$("#write_btn").on("click", function(){
			window.location = "write.jsp";
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
	
	<%
		try {
			ResultSet rs = stmt.executeQuery(sqlCount);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			allPage = (int)Math.ceil(total/(double)ROWSIZE);
			
			if(endPage > allPage) {
				endPage = allPage;
			}
			
			String sql = sqlPaging + start + "," + ROWSIZE;
			rs = stmt.executeQuery(sql);
	%>
	<hr/>
	
	<table>
		<tr>
			<td style="width:5%;">번호</td>
			<td style="width:20%;">제목</td>
			<td style="width:20%;">작성자</td>
			<td style="width:20%;">작성일</td>
		</tr>

		<%
			while(rs.next()) {
				int idx = rs.getInt(1);
				String name = rs.getString(2);
				String title = rs.getString(3);
				String time = rs.getString(4);
		%>
		
		<tr style="height:25px; align:center">
			<td><%=idx %></td>
			<td style="align:left;"><a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=title %></a></td>
			<td style="align:center;"><%=name %></td>
			<td style="align:center;"><%=time %></td>
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
				[<a href="index.jsp?pg=1">◀◀</a>]
				[<a href="index.jsp?pg=<%=startPage-1%>">◀</a>]
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
					[<a href="index.jsp?pg=<%=i %>"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage < allPage) {
		%>
				[<a href="index.jsp?pg=<%=endPage+1%>">▶</a>]
				[<a href="index.jsp?pg=<%=allPage%>">▶▶</a>]
		<%
			}
		%>
	</div>
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
			<button type="button" id="write_btn" name="write_btn">글쓰기</button>
		</form>
	</div>
</body>
</html>