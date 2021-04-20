<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include.jsp" %>
<html>
<head>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var formObj = $("form[name='writeForm']");
		
		$("#insertBtn").on("click", function(){
			
			if(fn_valiChk()) {
				return false;
			}
			
			formObj.attr("action", "write_ok.jsp");
			formObj.attr("method", "post");
			formObj.submit();
		});
		
		$("#cancelBtn").on("click", function(){
			location.href = "index.jsp";
		});
		
	});
	
	function fn_valiChk() {
		
		var regForm = $("form[name='writeForm'] .chk").length;
		
		for(var i = 0; i < regForm; i++) {
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
	<h4>게시판 글쓰기</h4>
	<hr/>
	
	<form name="writeForm">
		<table>
			<tr>
				<td>제목</td>
				<td><input class="chk" id="title" name="title" maxlength="100" title="제목을 입력해주세요."/></td>
			</tr>
			
			<tr>
				<td>이름</td>
				<td><input class="chk" id="name" name="name" maxlength="50" title="이름을 입력해주세요."/></td>
			</tr>
			
			<tr>
				<td>비밀번호</td>
				<td><input class="chk" type="password" id="password" name="password" maxlength="50" title="비밀번호를 입력해주세요"/></td>
			</tr>
			
			<tr>
				<td>내용</td>
				<td><textarea class="chk" id="memo" name="memo" cols="50" rows="13" title="내용을 입력해주세요."></textarea></td>
			</tr>
		</table>
	</form>
	<hr/>
	
	<div>
		<button type="button" id="insertBtn" name="insertBtn">등록</button>
		<button type="button" id="cancelBtn" name="cancelBtn">취소</button>
	</div>
</body>
</html>