<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat"%>
<%@ include file="main.jsp" %>
<%
	//한페이지에 보일 게시물 수
	final int ROWSIZE = 10;
	//총 페이지 최대개수
	final int BLOCK = 10;
	//기본 페이지값
	int pg = 1;
	
	if(request.getParameter("pg") != null) {
		//pg값을 저장
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	//해당 페이지에서 시작번호(step2)
	int start = (pg * ROWSIZE) - (ROWSIZE - 1);
	//해당페이지에서 끝버호(step2)
	int end = (pg * ROWSIZE);
	//전체 페이지수
	int allPage = 0;
	//시작블럭 숫자
	int startPage = ((pg - 1)/BLOCK * BLOCK) + 1;
	//끝 블럭 숫자
	int endPage = ((pg - 1)/BLOCK * BLOCK) + BLOCK;	
	//받아온 pg값이 있을때, 다른페이지일때
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
	});	
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<br/>
	<% 
		request.setCharacterEncoding("UTF-8");
		Connection conn= null;
		
		int total = 0;

		String sql = "";
		  	 
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			Statement stmtTwo = conn.createStatement();
			
			stmt = conn.createStatement();
			
			String sqlCount = "SELECT COUNT(*) FROM MP_BOARD";
			ResultSet rs = stmt.executeQuery(sqlCount);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}

			int sort = 1;
			String sqlSort = "SELECT idx FROM MP_BOARD ORDER BY idx DESC";
			rs = stmt.executeQuery(sqlSort);
			
			while(rs.next()) {
				int stepidx = rs.getInt(1);
				sql = "UPDATE MP_BOARD SET step =" + sort + " WHERE idx =" + stepidx;
				stmtTwo.executeUpdate(sql);
				sort++;
			}
			
			allPage = (int)Math.ceil(total/(double)ROWSIZE);
			
			if(endPage > allPage) {
				endPage = allPage;
			}
			
			out.println("총 게시물 : " + total + "개");
			
			String sqlList = "SELECT idx, name, title, time, hit, indent FROM MP_BOARD ORDER BY idx desc limit " + start + "," + end;
			rs = stmt.executeQuery(sqlList);
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
			if(total == 0) {
		%>
		
		<tr style="align:center; bgcolor:#FFFFFF; height:30px;">
			<td style="colspan:6px;">등록된 글이 없습니다.</td>
		</tr>
		
		<%
			} else {
				while(rs.next()) {
					int idx = rs.getInt(1);
					String name = rs.getString(2);
					String title = rs.getString(3);
					String time = rs.getString(4);
					int hit = rs.getInt(5);
					
					Date date = new Date();
					SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
					String year = (String) simpleDate.format(date);
					String yea = time.substring(0,10);
		%>
		
		<tr style="height:25px; align:center">
			<td><%=idx %></td>
			<td style="align:left;"><a href="view.jsp?idx=<%=idx %>&pg=<%=pg%>"><%=title %></a></td>
			<td style="align:center;"><%=name %></td>
			<td style="align:center;"><%=time %></td>
		</tr>
		
		<%
					}
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
	
	<div style="text-align:center;">
		<form name="searchForm" method="post" action="index_search.jsp?pg=<%=pg%>">
			<!-- 검색키 : search key -->
			<select name="sk">
				<option value="title">제목</option>
				<option value="name">작성자</option>
			</select>
			
			<!-- 검색값 : search value -->
			<input type="text" name="sv" style="width:100px;"/>
			<input type="submit" value="검색"/>
			<input type="button" id="writeBtn" name="writeBtn" value="글쓰기"/>
		</form>
	</div>
</body>
</html>