<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 제이쿼리 자바스크립트 추가하기 -->
	<!-- <script src="js/jquery-3.4.1.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<%@ include file="js/header.jsp" %>
	<script src="${path}/js/popper.js"></script>
	<!-- 부스스트랩 자바스크립트 추가하기 -->
	<script src="${path}/js/bootstrap.min.js"></script>	
<title>모바일 아카데미</title>
<!-- 부트스트랩 CSS 추가하기 -->
<!-- <link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/bootstrap.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="${path}/css/custom.css">
</head>
<body>
<c:redirect url="/main_servlet/list.do">
</c:redirect>
</body>
</html>