<%@page import="suser.model.SuserVO"%>
<%@page import="suser.service.SuserListService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%
SuserListService service = SuserListService.getInstance();
    List<SuserVO> suserList =  service.getSuserList();
%>    
<c:set var="suserList" value="<%=suserList %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<td>회원명</td>
	</tr>
	<c:forEach var="suser" items="${suserList}">
		<tr>
			<td>${suser.userName}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>