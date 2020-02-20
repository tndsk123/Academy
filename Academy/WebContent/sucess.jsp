<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ include file="js/header.jsp" %>
<c:if test="${param.message == 'join' }">
	<script>
		alert('회원가입이 완료되었습니다.\n로그인 후 사용바랍니다.');
		location.href="${path}/login.jsp";
	</script>
</c:if>
<c:if test="${param.message == 'update' }">
	<script>
		alert('회원님의 정보가 수정되었습니다.');
		location.href="${path}/userInfo_servlet/userlist.do";	
	</script>
</c:if>
</head>
<body>
</body>
</html>