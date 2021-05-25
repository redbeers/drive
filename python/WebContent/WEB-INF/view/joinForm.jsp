<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
</head>
<body>

<form id="frm" name="frm" method="post" action="join.do">
<p>
	아이디 : <input type="text" name="id" value="${param.id}"/><br/>
	<c:if test="${errors.id}">ID를 입력하세요.</c:if> 
	<c:if test="${errors.duplicateId}">이미 사용중인 ID입니다.</c:if>
</P>
<p>
	이름: <input type="text" name="name" value="${param.name}"/><br/>
	<c:if test="${errors.name}">이름을 입력하세요.</c:if> 
</P>

<p> 
	비밀번호 : <input type="text" name="password"/><br/>
	<c:if test="${errors.password}">비밀번호를 입력하세요.</c:if>
</p>

<p>
	비밀번호 확인 : <br/> <input type="password" name="confirmPassword"/><br/>
	<c:if test="${errors.confirmPassword}">확인을 입력하세요</c:if>
	<c:if test="${errors.notMatch}">비밀번호가 일치하지 않습니다.</c:if>
</p>
<input type="submit" value="가입" />
</form>
</body>
</html>