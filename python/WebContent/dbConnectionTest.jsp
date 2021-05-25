<%@page import="java.sql.SQLException"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연결 테스트</title>
</head>
<body>

<%
	try(Connection conn = ConnectionProvider.getConnection()){
		out.print("연결 성공");
	}catch(SQLException e){
		out.print("연결 실패 : " + e.getMessage());
	}
%>
</body>
</html>