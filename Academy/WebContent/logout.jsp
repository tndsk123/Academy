<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../js/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	var logout=confirm("로그아웃 하시겠습니까?");
	if(logout==true){
		location.href="${path}/userInfo_servlet/logout.do";	
	}else{
		window.history.back();
	}
	
})
</script>
</head>
<body>
</body>
</html>