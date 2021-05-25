<%@page import="suser.model.SuserVO"%>
<%@page import="suser.service.SuserListService"%>
<%@page import="java.util.List"%>
<%@ taglib prefix ="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src='js/jquery-3.5.1.js'></script>
<script type="text/javascript">

function setData(suserList.userId, suserList.pwd, suserList.userName, suserList.mobile, suserList.email, suserList.birth ){
	
	
	$("#user_id").val(user_id);
	$("#pwd").val(user_id);
	$("#user_name").val(user_id);
	$("#mobile").val(user_id);
	$("#email").val(user_id);
	$("#birth").val(user_id);
	
}

function suserUpdate{
	
	var user_id = $("#user_id").val();
	var pwd = $("#pwd").val();
	var user_name = $("#user_name").val();
	var mobile = $("#mobile").val();
	var email = $("#email").val();
	var birth = $("#birth").val();
	
	var param = ""
		param += "&user_id=" + user_id
		param += "&pwd=" + pwd
		param += "&user_name=" + user_name
		param += "&mobile=" + mobile
		param += "&email=" + email
		param += "&birth=" + birth
}

</script>

<meta charset="UTF-8">
<title>사용자 관리</title>
</head>
<body>
<table border="1">
	<tr>
		<td>
			<table border="1">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>휴대전화</th>
					<th>이메일</th>
				</tr>
				<c:forEach var="suserList" items="${suserList}">
				<tr>
					<td><a href="javascript:setData('${suserList.userId}','${suserList.pwd }','${suserList.userName}','${suserList.mobile}','${suserList.email}','${suserList.birth}' )">${suserList.userId}</a></td>
					<td>${suserList.userName }</td>
					<td>${suserList.mobile }</td>
					<td>${suserList.email }</td>
				</tr>
				</c:forEach>
			</table>
		</td>
		<td>
			<form name="frm" id="frm" method="post" action="suserInsert.do">
				<table border="1">
					<tr>
						<th>아이디</th>
						<td><input name="userId" type="text"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input name="pwd" type="text"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input name="userName" type="text"></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td><input name="mobile" type="text"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input name="email" type="text"></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input name="birth" type="text"></td>
					</tr>
				</table>
				<input type="submit" value="등록">
				<input type="button" value="수정" onclick="suserUpdate()">
				<input type="button" value="삭제" onclick="suserDelete()">
			</form>
		</td>
	</tr>
</table>
</body>
</html>