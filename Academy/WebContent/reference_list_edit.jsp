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
	<script src="/Academy/js/popper.js"></script>
	<!-- 부스스트랩 자바스크립트 추가하기 -->
	<script src="/Academy/js/bootstrap.min.js"></script>	
<script type="text/javascript">
$(function(){
	$("#btnUpdate").click(function(){
		var writer=$("#writer").val();
		var division=$("#division").val();
		var subject=$("#subject").val();
		var content=$("#content").val();
		var passwd= $("#passwd").val();
		if(division==""){
			alert("자료 구분을 선택해주세요");
			division.focus();
			return;
		}
		if(subject==""){
			alert("제목을 입력해주세요");
			subject.focus();
			return;
		}
		if(content==""){
			alert("내용을 입력해주세요");
			content.focus();
			return;
		}
		if(passwd==""){
			alert("비밀번호를 입력해주세요");
			passwd.focus();
			return;
		}
		document.form1.action="${path}/reference_servlet/reference_update.do";
		document.form1.submit();
	});
	$("#btnDelete").click(function(){
		if(confirm("정말 삭제 하시겠습니까?")){
			document.form1.action="${path}/reference_servlet/reference_delete.do";
			document.form1.submit();
		}else{
			return;
		}
	});
	$("#btnList").click(function(){
		location.href="${path}/reference_servlet/list.do";
	});
});

</script>
<title>모바일 아카데미</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="${path}/css/custom.css">
</head>
<body>
	<%String nickname=(String)session.getAttribute("nickname"); %>
	<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #E95420;">
	<a class="navbar-brand" href="${path}/index.jsp" style="color: #ffffff;">Mobile Academy</a>
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
			<% if(nickname==null){%>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown" style="color: #ffffff; text-align: right;">
				회원관리</a>
				<div class="text-center dropdown-menu" aria-labelledby="dropdown">
					<a class="dropdown-item" href="${path}/login.jsp">로그인</a>
					<a class="dropdown-item mt-2" href="${path}/join.jsp">회원가입</a>
				</div>
			<%}else{ %>
			<% String img=(String)session.getAttribute("img");%>
			<li class="nav-item">
				<a class="nav-link" href="#" style="color: #ffffff;"><img src="${path}/images/user_img/<%=img %>" width="30px" height="30px"></a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown" style="color: #ffffff; text-align: right;">
				<%=nickname %>님</a>
				<div class="text-center dropdown-menu" aria-labelledby="dropdown">
					<a class="dropdown-item mt-2" href="${path}/userInfo_servlet/userlist.do">나의정보</a>
					<a class="dropdown-item mt-2" href="${path}/logout.jsp">로그아웃</a>
				</div>
			<%} %>
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
		<div class="container">
  		  <div class="row">
      		 <div class="col-sm-12 mt-2">
      		 	<h2>게시물 수정/삭제</h2>
      		 	<hr>  		 		
      		 	<form method="post" name="form1" id="form1" action="" enctype="multipart/form-data">
      		 	<table class="table table-bordered" >
      		 		<tr class="table-info">
      		 			<th colspan="4">자료실 > 세부자료실 > 게시물수정/삭제</th>
      		 		</tr>
      		 		<tr>
    					<td>날짜</td>
    					<td><input name="reg_date" value="${dto.reg_date}" disabled style="border: none; background-color: white;"></td>
    					<td>조회수</td>
    					<td><input name="readcount" value="${dto.readcount}" disabled style="border: none; background-color: white;"></td>
  					</tr>
  					<tr>
    					<td>이름</td>
    					<td colspan="3"><input name="writer" value="${dto.writer}" disabled style="border: none; background-color: white;"></td>
  					</tr>
  					<tr>
    					<td>자료구분</td>
    					<td colspan="3">
    						<select name="division" id="division">
      		 				 	<option selected="selected" value="${dto.division}">${dto.division}</option>	 						     		 				
      		 					<option value="JAVA">JAVA</option>
      		 					<option value="JavaScript">JavaScript</option>
      		 					<option value="HTML">HTML</option>
      		 					<option value="JSP">JSP</option>
      		 					<option value="DB">DB</option>
      		 					<option value="others">others</option>  			
      		 				</select>
    					</td>
  					</tr>
  					<tr>
    					<td>제목</td>
    					<td colspan="3"><input name="subject" id="subject" value="${dto.subject}"></td>
  					</tr>
  					<tr height="300px">
    					<td>본문</td>
    					<td colspan="3">
    						<textarea name="content" id="content" class="form-control" maxlength="2048" style="height: 200px;">${dto.content}</textarea>
    					</td>
 					</tr>
  					<tr>
    					<td>비밀번호</td>
    					<td colspan="3">
     						<input type="password" name="passwd" id="passwd">
    					</td>
 					</tr>
  					<tr>
    					<td>첨부파일</td>
    					<td colspan="3">
      						<c:if test="${dto.filesize > 0}">
       							${dto.filename}( ${dto.filesize} bytes )
        						<input type="checkbox" name="fileDel">첨부파일 삭제<br>
      						</c:if>
      						<input type="file" name="file" id="file">
    					</td>
  					</tr>				
  				</table> 
  					<input type="hidden" name="num" value="${dto.num}">
				<div align="center">
					<button type="button" class="btn btn-danger mx-1 mt-2" id="btnList" >목록</button>
					<button type="button" class="btn btn-primary mx-1 mt-2" id="btnUpdate" >수정</button>	
					<button type="button" class="btn btn-danger mx-1 mt-2" id="btnDelete" >삭제</button>	
				</div>
				</form>
       		 </div>
   	 	   </div>
		</div>
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