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
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script type="text/javascript">
$(function (){
	$("#btnLogin").click(function() {
		var id=$("#id").val();
		var passwd= $("#passwd").val();
		if(!id){
			alert("아이디를 입력해주세요");
			id.focus();
			return false;
		}
		if(!passwd){
			alert("비밀번호를 입력해주세요");
			passwd.focus();
			return false;
		}
		document.form1.submit();
	});
});
</script>
<c:if test="${param.message == 'fail'}">
    <script>
      alert("아이디나 패스워드가 잘못 입력되었습니다.");
    </script>
</c:if>
<title>모바일 아카데미</title>
<!-- 부트스트랩 CSS 추가하기 -->
<!-- <link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/bootstrap.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap-theme.min.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="${path}/css/custom.css">
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
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown" style="color: #ffffff; text-align: right;">
				회원관리</a>
				<div class="text-center dropdown-menu" aria-labelledby="dropdown">
					<a class="dropdown-item" href="${path}/login.jsp">로그인</a>
					<a class="dropdown-item mt-2" href="${path}/join.jsp">회원가입</a>
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
	<section class="container mt-3" style="max-width: 560px;">
		<h2 class="title">로그인</h2>
		<form method="post" name="form1" id="form1" action="${path}/userInfo_servlet/login.do">
			<div class="form-group">
				<label>아이디</label>
				<input name="id" id="id" class="form-control" placeholder="아이디를 입력하세요.">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="passwd" id="passwd" class="form-control" placeholder="비밀번호를 입력하세요.">
			</div>
			<div class="form-group" align="center">
				<button type="button" class="btn btn-primary mt-3" id="btnLogin" >로그인</button>
				<button type="button" class="btn btn-info ml-4 mt-3" onclick="location.href='look_for.jsp'">아이디/비밀번호 찾기</button>
				<button type="button" class="btn btn-danger ml-4 mt-3" onclick="location.href='join.jsp'">회원가입</button>
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