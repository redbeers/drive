<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
<body>
<table>
	<tr>
		<c:if test="${!empty suser}">
		<td><a href="main.jsp">메인 화면</a></td>
		<td><a href="suser.do">사용자관리</a></td>
		<td><a href="survey">설문관리</a></td>
		<td><a href="snotice_list">게시판</a></td>
		<td><a href="logout.do">로그아웃</a></td>
		</c:if>
		<c:if test="${empty suser}">
			<td><a href="login.do">로그인</a></td>
		</c:if>
		
	</tr>
	<tr>
		<td colspan="5"><img alt="" src="aaa.jpg"></td>
	</tr>
</table>

</body>
</html>
