<%@page import="userInfomation.dto.UserInfomationDTO"%>
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
	<%@ include file="js/header.jsp" %>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="${path}/js/popper.js"></script>
	<!-- 부스스트랩 자바스크립트 추가하기 -->
	<script src="${path}/js/bootstrap.min.js"></script>
	<%@ include file="js/header.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnUpdate").click(function() {
		var id=$("#id").val();
		var passwd= $("#passwd").val();
		var repasswd= $("#repasswd").val();
		var birth=$("#birth").val();
		var name=$("#name").val();
		if(passwd==""){
			alert("비밀번호를 입력해주세요");
			passwd.focus();
			return;
		}
		if(passwd!=repasswd){
			alert("비밀번호를 동일하게 입력해주세요");
			repasswd.focus();
			return;
		}
		if(name==""){
			alert("이름을 입력해주세요");
			name.focus();
			return;
		}
		if(birth==""){
			alert("생년월일 입력해주세요");
			return;
		}
		document.form1.action="${path}/userInfo_servlet/update.do?id="+id;
		document.form1.submit();
	});
	$("#btnDelete").click(function() {
		var id=$("#id").val();
		var result=confirm("정말로 계정을 삭제하시겠습니까?");
		if(result==true){
			document.form1.action="${path}/userInfo_servlet/delete.do?id="+id;
			document.form1.submit();
		}
		/* if(confirm("정말로 계정을 삭제하시겠습니까?")){
			document.form1.action="${path}/userInfo_servlet/delete.do?id="+id;
			document.form1.submit();
		}	 */
	});
});
function passwdCheck() {
	var passwd=document.getElementById("passwd").value;
	var repasswd=document.getElementById("repasswd").value;
	if(passwd.length < 4 || passwd.length >8){
		window.alert('비밀번호는 4글자 이상, 8글자 이하만 이용 가능합니다.');
		passwd=document.getElementById("repasswd").value='';
		document.getElementById('passwdCheck').innerHTML='';
	}
	if(passwd!='' && repasswd!=''){
		if(passwd==repasswd){
			document.getElementById('passwdCheck').innerHTML='비밀번호가 일치합니다.';
			document.getElementById('passwdCheck').style.color='blue';
		}
	}else{
		document.getElementById('passwdCheck').innerHTML='비밀번호가 일치하지 않습니다.';
		document.getElementById('passwdCheck').style.color='red';
	}
}
var img_file;
$(document).ready(function() {
	$("#input_img").on("change", handleImgFileSelect);
});
function handleImgFileSelect(e) {
	var files= e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f) {
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_file = f;
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$("#img").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}
</script>
<title>모바일 아카데미</title>
<!-- 부트스트랩 CSS 추가하기 -->
<!-- <link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/bootstrap.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap-theme.min.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="${path}/css/custom.css">
<c:if test="${message == 'update'}">
    <script>
      alert("회원정보가 수정되었습니다.");
    </script>
</c:if>
</head>
<body>
	<%String nickname=(String)session.getAttribute("nickname"); %>
	<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #E95420;"><!-- bg-light 밝은 배경 -->
	<a class="navbar-brand" href="${path}/index.jsp" style="color: #ffffff;">Mobile Academy</a><!-- 로고 출력용 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		<span class="navbar-toggler-icon"></span><!-- 오른쪽 위 3줄 토글-->
	</button>
	<div id="navbar" class="collapse navbar-collapse">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active" >
				<a class="nav-link" href="${path}/index.jsp" style="color: #ffffff;">메인</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${path}/reference_servlet/list.do?nickname=<%=nickname%>" style="color: #ffffff;">자료실</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown" style="color: #ffffff;">
				게시판</a>
				<div class="text-center dropdown-menu" aria-labelledby="dropdown">					
					<a class="dropdown-item" href="${path}/community_main_servlet/list.do?nickname=<%=nickname%>">자유게시판</a>
					<a class="dropdown-item mt-2" href="${path}/community_exchange_servlet/list.do?nickname=<%=nickname%>">정보교환</a>
					<a class="dropdown-item mt-2" href="${path}/community_job_servlet/list.do?nickname=<%=nickname%>">구인구직</a>
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${path}/question_servlet/list.do?nickname=<%=nickname%>" style="color: #ffffff;">고객센터</a>
			</li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<li class="nav-item">
				<%String img=(String)session.getAttribute("img"); %>	
				<a class="nav-link" href="#" ><img src="${path}/images/user_img/<%=img %>" width="30px" height="30px"></a>			
			</li>
			<li class="nav-item dropdown">					
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown" style="color: #ffffff; text-align: right;">
				${sessionScope.nickname }님</a>
				<div class="text-center dropdown-menu" aria-labelledby="dropdown">
					<a class="dropdown-item mt-2" href="${path}/userInfo_servlet/userlist.do">나의정보</a>
					<a class="dropdown-item mt-2" href="${path}/logout.jsp">로그아웃</a>
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="http://qr.kakao.com/talk/TnfcrBGx7nHn5Yr2HL8OeRO6uQo-" ><img src="${path}/images/카카오톡.png" width="30px" height="30px"></a>	
			</li>
			<li class="nav-item">
				<a class="nav-link" href="https://www.instagram.com/armyyoungsu/"><img src="${path}/images/인스타그램.png" width="30px" height="30px"></a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="https://www.facebook.com/profile.php?id=100003495337261" ><img src="${path}/images/페이스북.png" width="30px" height="30px"></a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="https://www.youtube.com/channel/UCY1iMjTpcu8K_nkNGDdAUmw?view_as=subscriber" ><img src="${path}/images/유튜브.png" width="30px" height="30px"></a>
			</li>
		</ul>
		<form class="form-inline my-2 my-lg-0" name="search" id="search" action="${path}/main_servlet/search.do">
			<input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" name="keyword" aria-label="Search">
			<button class="btn btn-outline-success my-2 sm-0" type="submit" style="color: #ffffff; border-color: #ffffff;">확인</button>
		</form>
	</div>
	</nav>
	<section class="container mt-3">
		<h2 class="title">정보수정</h2>
		<form method="post" name="form1" id="form1" action="" enctype="multipart/form-data">
			<div class="form-group">
				<label>프로필사진</label>
				<div class="img_wrap">
					<img src="${path}/images/user_img/<%=img %>"  width="150px" height="150px" style="border: 3px solid black" id="img">
				</div>
				<div class="mt-3">
					<input type="file" name="file" size=40 id="input_img">
					<span class="ml-2 mt-2" style="color: blue">파일 크기는 10MB 까지만 됩니다.</span>
				</div>
			</div>
			<div class="form-group">
				<label>아이디</label>
				<input name="id" id="id" class="form-control" value="${dto.id}" disabled="disabled">
				<span class="ml-2 mt-2" style="color: red">아이디는 변경이 불가합니다.</span>
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="passwd" id="passwd" class="form-control" placeholder="비밀번호를 입력하세요." onchange="passwdCheck()">
			</div>
			<div class="form-group">
				<label>비밀번호 재입력</label>
				<input type="password" name="repasswd" id="repasswd" class="form-control" placeholder="비밀번호를 재입력하세요."  onchange="passwdCheck()">
				<span class="mt-2 ml-1" id="passwdCheck"></span>
			</div>
			<div class="form-group">
				<label>이름</label>
				<input type="text" id="name" name="name" class="form-control" value="${dto.name}">
			</div>
			<div class="form-group">
				<label>닉네임</label>
				<input name="nickname" id="nickname" class="form-control" value="${dto.nickname}" disabled="disabled">
				<span class="ml-2 mt-2" style="color: red">닉네임은 변경이 불가합니다.</span>
			</div>
			<div class="form-group">
				<label>이메일</label>
				<input type="email" id="email" name="email" class="form-control" value="${dto.email}">
				<c:choose>
					<c:when test="${dto.email_check==0}">
						<span class="ml-2 mt-2" style="color: red">이메일 인증이 필요합니다.</span>
						<a class="btn btn-info" type="button" href="${path}/userInfo_servlet/emailcheck.do?nickname=${dto.nickname}">인증하기</a>
					</c:when>
					<c:otherwise>
						<span class="ml-2 mt-2" style="color: blue">이메일 인증한 회원 입니다.</span>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group">
				<label>전화번호</label>
				<input type="text" id="hp" name="hp" class="form-control" value="${dto.hp}">
			</div>
			<div class="form-group">
				<label>생년월일</label>
				<input type="date" id="birth" name="birth" class="form-control" value="${dto.birth}">
			</div>
			<div class="form-group">
				<label>주소</label>
				<input type="text" id="address" name="address" class="form-control" value="${dto.address}">
			</div>
			<div class="form-group" align="center">
				<button type="button" class="btn btn-primary mx-1 mt-2" id="btnUpdate">정보수정</button>
				<button type="button" class="btn btn-primary mx-1 mt-2" onclick="location.href='${path}/index.jsp'">홈으로</button>
				<button type="button" class="btn btn-danger mx-1 mt-2" id="btnDelete">회원탈퇴</button>
			</div>
		</form>
	</section>
	<footer class="page-footer font-small mt-1 p-3 text-center">
		<div class="container-fluid text-center text-md-left">
			<div class="row">
				<div class=col-md-6>
					<h5 class="text-uppercase">Mobile Academy</h5>
					<p>Copyright &copy; 2020 Mobile Academy All Rights Reserved</p>
				</div>
				<hr class="clearfix w-100 d-md-none pb-3">
				<div class="col-md-3 mb-md-0 mb-3">
        			<h5 class="text-uppercase">Manager</h5>
        				<ul class="list-unstyled">
          					<li>
            					전화번호 : 010-1111-2222
          					</li>
          					<li>
            					이메일 : tndsk123@gmail.com
         		 			</li>
        				</ul>
      			</div>
      			<div class="col-md-3 mb-md-0 mb-3">
        			<h5 class="text-uppercase">고객지원</h5>
        				<ul class="list-unstyled">
          					<li>
            					<a href="${path}/question_servlet/list.do?nickname=<%=nickname%>">고객센터</a>
          					</li>
          					<li>
            					<a href="https://map.naver.com/v5/?c=14152401.7786572,4514123.2166359,18,0,0,0,dh">주소보기</a>
         		 			</li>
        				</ul>
      			</div>
			</div>
		</div>
	</footer>
</body>
</html>