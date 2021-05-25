<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>

<form name="frm" id="frm" method="post" action="login.do">
	<table>
		<tr>
			<td>아이디</td>
			<td><input name="userId" id="userId" type="text"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input name="pwd" id="pwd" type="password"></td>
		</tr>
	</table>
	<input type="submit" value="로그인">
</form>

</body>
</html>