<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int idx = Integer.parseInt(request.getParameter("idx")); %>
<% int pg = Integer.parseInt(request.getParameter("pg")); %>
<% 
	String name = "";
	String title = "";
	String memo = "";
	String password = "";
	
	try {
		String sql = sqlUpdate + idx;
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			name = rs.getString(1);
			title = rs.getString(2);
			memo = rs.getString(3);
			password = rs.getString(4);
		}
		
		rs.close();
		stmt.close();
		conn.close();
	} catch(SQLException e) {
		out.println(e.toString());
	}
%>
<html>
<head>
<script type="text/javascript">
	
	$(document).ready(function(){

		var formObj = $("form[name='updateForm']");
		
		$("#updateBtn").on("click", function(){
			if(fn_valiChk()) {
				return false;
			}
			
			formObj.submit();
		});
		
	});
	
	function fn_valiChk() {
		
		var updateForm = $("form[name='updateForm'] .chk").length;
		
		for(var i = 0; i < updateForm; i++) {
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
		
	}
	
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<hr/>
	<h4>게시글 수정화면</h4>
	<hr/>
	
	<form name="updateForm" method="post" action="update_ok.jsp?idx=<%=idx %>&pg=<%=pg%>">
		<table>
			<tr>
				<td style="align:center;">이름</td>
				<td><input class="chk" type="text" id="name" name="name" value="<%=name %>" title="이름을 입력해주세요."/></td>
			</tr>
			
			<tr>
				<td style="align:center;">제목</td>
				<td><input class="chk" type="text" id="title" name="title" value="<%=title %>" title="제목을 입력해주세요."/></td>
			</tr>
			
			<tr>
				<td style="colspan:2; height:200px;">내용</td>
				<td><textarea class="chk" id="memo" name="memo" cols="50" rows="13" title="내용을 입력해주세요." style="resize:none;"><%=memo %></textarea></td>
			</tr>
			
			<tr>
				<td style="align:center;">비밀번호</td>
				<td><input class="chk" type="password" id="password" name="password" title="비밀번호를 입력해주세요."/></td>
			</tr>
		</table>
	</form>
	<hr/>
	
	<div>
		<button type="button" id="updateBtn" name="updateBtn">수정</button>
		<button type="button" id="cancelBtn" name="cancelBtn">취소</button>
	</div>
</body>
</html>