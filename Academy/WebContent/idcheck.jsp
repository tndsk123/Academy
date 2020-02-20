<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../js/header.jsp" %>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	  window.resizeTo(620, 690);
	 });
$(function() {
	window.resizeTo(620, 690);
	$("#idcheck").click(function() {
		if(document.check.id.value==""){ 
 			alert("아이디를 입력하세요");        
 			document.check.id.focus();    
 			return;
 		}
 		document.check.submit();		
	});
	$("#returnid").click(function() {
		var result=$("#result").val();
		var id=$("#id").val();
		if(result=="이미 사용중인 아이디 입니다."){
			alert("이미 사용중인 아이디 입니다.");
			document.getElementById("id").value="";
			return;
		 }else if(id==null){
			alert("아이디를 입력하세요");
		 }else{
			document.check.action="idc.do";
			document.check.submit();
		 }
	});
});
</script>
</head>
<body>
<form action="${path}/userInfo_servlet/idcheck.do" name="check" id="check" method="post">
아이디<input type="text" name="id" id="id" value="${id}">
<button type="button" id="idcheck">중복검사</button><br>
<input type="hidden" name="result" id="result" value="${result}">
${result}<br> <!-- 아이디가 중복인지 아닌지 상태  -->
<button type="button" id="returnid">사용하기</button><br>
</form>
</body>
</html>