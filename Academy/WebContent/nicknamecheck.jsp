<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function nicknamecheck(){
 
 if(document.check.nickname.value==""){ 
 alert("닉네임을 입력하세요");         
 document.check.nickname.focus();    
 exit;
 }
 document.check.submit();
}
function returnnickname() {
	document.check.action="idn.do";
	document.check.submit();

}
</script>
</head>
<body>
<script>
<% String path=request.getContextPath();%>
<% String result2 = (String)request.getAttribute("result2");
   String nickname = (String)request.getAttribute("nickname");
   if(result2=="이미 사용중인 닉네임 입니다."){%>
	document.getElementById("nickname").val="";
 <% }else{%>
    document.getElementById("nicknmae").val="<%=nickname%>";
 <%}%>
</script> 
<form action="<%=path%>/userInfo_servlet/nicknamecheck.do" name="check" id="check" method="post">
아이디<input type="text" name="nickname" id="nickname" value='<%=nickname%>'>
<input type="button" value="중복검사" onclick="nicknamecheck()" ><br>
<input type="hidden" name="result2" id="result2" value='<%=result2%>'>
<%=result2 %><br> 
<input type="button" value="사용하기" onclick="returnnickname()" >
</form>
</body>
</html>