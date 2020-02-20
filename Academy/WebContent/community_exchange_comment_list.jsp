<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="/Academy/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap-theme.min.css">
<%@ include file="../js/header.jsp" %>
</head>
<body>
<table class="table-borderless table-responsive">
<c:forEach var="row" items="${list}">
  <tr>
    <td>${row.writer}</td>
    <td rowspan="2" class="float-right">(${row.reg_date})</td>
  </tr>
  <tr>
  	<td colspan="2">${row.content}</td>
  </tr>
</c:forEach>
</table>
</body>
</html>