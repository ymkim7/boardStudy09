<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int pg = Integer.parseInt(request.getParameter("pg"));
%>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){

		var formObj = $("form[name=writeForm]");
		var title = $("#title").val();
		var name = $("#name").val();
		var password = $("#password").val();
		var memo = $("#memo").val();
		
		$("#insertBtn").on("click", function(){
			if(fn_valiChk()) {
				return false;
			}
			$("input[name='insertBtn']");
			formObj.submit();
		});
		
		$("#cancelBtn").on("click", function(){
			window.history.back();
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
	<h4>게시글 등록화면</h4>
	<hr/>
	
	<form name="writeForm" method="post" action="write_ok.jsp?pg=<%=pg%>">
		<table>
			<tr>
				<td style="align:center;">제목</td>
				<td><input class="chk" id="title" name="title" maxlength="100" title="제목을 입력해주세요."/></td>
			</tr>
			
			<tr>
				<td style="align:center;">이름</td>
				<td><input class="chk" id="name" name="name" maxlength="50" title="이름을 입력해주세요."/></td>
			</tr>
			
			<tr>
				<td style="align:center;">비밀번호</td>
				<td><input class="chk" type="password" id="password" name="password" maxlength="50" title="비밀번호를 입력해주세요"/></td>
			</tr>
			
			<tr>
				<td style="align:center;">내용</td>
				<td><textarea class="chk" id="memo" name="memo" cols="50" rows="13" title="내용을 입력해주세요."></textarea></td>
			</tr>
		</table>
	</form>
	
	<div>
		<input type="button" id="insertBtn" name="insertBtn" value="등록"/>
		<input type="button" id="cancelBtn" name="cancelBtn" value="취소"/>
	</div>
</body>
</html>