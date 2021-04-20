<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<% int idx = Integer.parseInt(request.getParameter("idx")); %>
<% int pg = Integer.parseInt(request.getParameter("pg")); %>
<html>
<head>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#deleteChk").on("click", function(){
			var formObj = $("form[name='deleteForm']");
			var pw = $("#password").val();
			
			if(pw == '' || pw == null) {
				alert("비밀번호를 입력해주세요.");
				$("#password").focus();
			} else {
				formObj.submit();
			}
		});
		
		$("#cancelBtn").on("click", function(){
			window.history.back();
		});
		
	});
</script>
<meta charset="utf-8">
<title>게시판</title>
</head>
<body>
	<hr/>
	<h4>게시글 삭제화면</h4>
	<hr/>
	
	<form name="deleteForm" method="post" action="delete_ok.jsp?idx=<%=idx %>&pg=<%=pg%>">
		<table>
			<tr>
				<td colspan="2" style="align:center;">비밀번호를 입력해주세요</td>
			</tr>
			
			<tr>
				<td style="align:center; width:100px;">비밀번호</td>
				<td><input type="password" id="password" name="password" maxlength="100"/></td>
			</tr>
		</table>
	</form>
	<hr/>
	
	<div>
		<button type="button" id="deleteChk" name="deleteChk">확인</button>
		<button type="button" id="cancelBtn" name="cancelBtn">취소</button>
	</div>
</body>
</html>