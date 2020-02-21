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
<c:if test="${param.message == 'logout'}">
    <script>
      alert("로그아웃되었습니다.");
    </script>
</c:if>
<c:if test="${param.message == 'login'}">
    <script>
      alert("로그인 되었습니다.");
    </script>
</c:if>
<c:if test="${param.message == 'delete'}">
    <script>
      alert("회원탈퇴가 되었습니다.");
    </script>
</c:if>  
<body>
	<% String nickname=(String)session.getAttribute("nickname"); %>
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
	<section class="container-fluid" >
		<div class="container-fluid">
   			<div class="row p-4">
   				<div class="col-sm-12">
   					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  						<ol class="carousel-indicators">
    						<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  						</ol>
  						<div class="carousel-inner">
    						<div class="carousel-item active">
    							<a href="${path}/community_main_servlet/list.do?nickname=<%=nickname%>">
      								<img class="d-block w-100" src="${path}/images/community.png" alt="First slide" style="max-height: 800px">
      							</a>
    						</div>
   	 						<div class="carousel-item">
   	 							<a href="${path}/community_job_servlet/list.do?nickname=<%=nickname%>">
      								<img class="d-block w-100" src="${path}/images/job.png" alt="Second slide" style="max-height: 800px">
      							</a>
    						</div>
    						<div class="carousel-item">
    							<a href="${path}/reference_servlet/list.do?nickname=<%=nickname%>">
     				 				<img class="d-block w-100 " src="${path}/images/reference.png" alt="Third slide" style="max-height: 800px">
     				 			</a>
    						</div>
 	 					</div>
  						<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
   							<span class="sr-only">Previous</span>
  						</a>
  						<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    						<span class="carousel-control-next-icon" aria-hidden="true"></span>
    						<span class="sr-only">Next</span>
  						</a>
					</div>
   				</div>
        		<div class="col-md-6 mt-4" id="community_main">
        			<h2><a href="${path}/community_main_servlet/list.do?nickname=<%=nickname%>">자유게시판</a></h2>
        			<hr>
        			<table class="table table-striped table-hover table-responsive-sm">
      		 		<tr class="table-info">
   						<th scope="col">번호</th>
    					<th scope="col">닉네임</th>
    					<th scope="col">제목</th>
    					<th scope="col">조회수</th>
    					<th scope="col">추천수</th>
    					<th scope="col">첨부파일</th>
    					<th scope="col">다운로드</th>
    					<th scope="col">등록일자</th>
  					</tr>
      		 		<c:forEach var="dto" items="${main}">
      		 		    <c:choose>
      		 		    	<c:when test="${dto.writer == '관리자' }">     		 		  
      		 		   		 </c:when>
      		 		   		 <c:otherwise>
      		 							  <tr>
      		 							  	  <td scope="row">${dto.num}</td>
      		 								  <td>${dto.writer}</td>
      		 								  <td>
      		 									  <a href="${path}/community_main_servlet/view.do?num=${dto.num}">${dto.subject}</a>
      		 									  <c:if test="${dto.comment_count > 0}">
    												  <span style="color: red;">(${dto.comment_count})</span>
   												  </c:if>
      		 								  </td>
      		 								  <td>${dto.readcount}</td>      		 								   		 								  
      		 								  <td>${dto.good }</td>
      		 								  <td align="center">
      											  <c:if test="${dto.filesize > 0}">
      												  <a href="${path}/community_main_servlet/download.do?num=${dto.num}">
        												  <img src="/Academy/images/file.gif">
      												  </a>
     					 						  </c:if>
   				 							  </td>
   				 							  <td id="reload">${dto.down}</td>
   				 							  <td>${dto.reg_date}</td>
      					 				  </tr>
					       </c:otherwise>
  					    </c:choose>		 			
      		 		</c:forEach>
      		 	</table>
        		</div>
        		<div class="col-md-6 mt-4" id="community_exchange">
        			<h2><a href="${path}/community_exchange_servlet/list.do?nickname=<%=nickname%>">정보교환 게시판</a></h2>
        			<hr>
        			<table class="table table-striped table-hover table-responsive-sm">
      		 		<tr class="table-info">
   						<th scope="col">번호</th>
    					<th scope="col">닉네임</th>
    					<th scope="col">제목</th>   					
    					<th scope="col">조회수</th>
    					<th scope="col">추천수</th>
    					<th scope="col">첨부파일</th>
    					<th scope="col">다운로드</th>
    					<th scope="col">등록일자</th>
  					</tr>
      		 		<c:forEach var="dto" items="${exchange}">
      		 		    <c:choose>
      		 		    	<c:when test="${dto.writer == '관리자' }">	   	 		
      		 		   		</c:when>
      		 		   		<c:otherwise>
      		 							  <tr>
      		 							  	  <td scope="row">${dto.num}</td>
      		 								  <td>${dto.writer}</td>
      		 								  <td>
      		 									  <a href="${path}/community_exchange_servlet/view.do?num=${dto.num}">${dto.subject}</a>
      		 									  <c:if test="${dto.comment_count > 0}">
    												  <span style="color: red;">(${dto.comment_count})</span>
   												  </c:if>
      		 								  </td>
      		 								  <td>${dto.readcount}</td>
      		 								  <td>${dto.good }</td>
      		 								  <td align="center">
      											  <c:if test="${dto.filesize > 0}">
      												  <a href="${path}/community_exchange_servlet/download.do?num=${dto.num}">
        												  <img src="/Academy/images/file.gif">
      												  </a>
     					 						  </c:if>
   				 							  </td>
   				 							  <td id="reload">${dto.down}</td>
      		 								  <td>${dto.reg_date}</td>
      					 				  </tr>
      					 	</c:otherwise>
  					    </c:choose>		 			
      		 		</c:forEach>
      		 	</table>
        		</div>
        		<div class="col-md-6" id="community_job">
        			<h2><a href="${path}/community_job_servlet/list.do?nickname=<%=nickname%>">구인구직 게시판</a></h2>
        			<hr>
        			<table class="table table-striped table-hover table-responsive-sm">
      		 		<tr class="table-info">
   						<th scope="col">번호</th>
    					<th scope="col">닉네임</th>
    					<th scope="col">모집분야</th>
    					<th scope="col">회사명</th>
    					<th scope="col">조회수</th>
    					<th scope="col">추천수</th>
    					<th scope="col">첨부파일</th>
    					<th scope="col">다운로드</th>
    					<th scope="col">등록일자</th>
  					</tr>
      		 		<c:forEach var="dto" items="${job}">
      		 							  <tr>
      		 							  	  <td scope="row">${dto.num}</td>
      		 								  <td>${dto.writer}</td>
      		 								  <td>${dto.job_area}</td>
      		 								  <td>
      		 									  <a href="${path}/community_job_servlet/view.do?num=${dto.num}">${dto.subject}</a>
      		 								  </td>
      		 								  <td>${dto.readcount}</td>      		 								   		 								  
      		 								  <td>${dto.good }</td>
      		 								  <td align="center">
      											  <c:if test="${dto.filesize > 0}">
      												  <a href="${path}/community_job_servlet/download.do?num=${dto.num}">
        												  <img src="/Academy/images/file.gif">
      												  </a>
     					 						  </c:if>
   				 							  </td>
   				 							  <td id="reload">${dto.down}</td>
   				 							  <td>${dto.reg_date}</td>
      					 				  </tr>	
      		 		</c:forEach>
      		 	</table>
        		</div>
        		<div class="col-md-6" id="reference">
        			<h2><a href="${path}/reference_servlet/list.do?nickname=<%=nickname%>">자료실</a></h2>
        			<hr>
        			<table class="table table-striped table-hover table-responsive-sm">
      		 		<tr class="table-info">
   						<th scope="col">번호</th>
    					<th scope="col">닉네임</th>
    					<th scope="col">자료구분</th>
    					<th scope="col">제목</th>   					
    					<th scope="col">조회수</th>
    					<th scope="col">추천수</th>
    					<th scope="col">첨부파일</th>
    					<th scope="col">다운로드</th>
    					<th scope="col">등록일자</th>
  					</tr>
      		 		<c:forEach var="dto" items="${reference}">
      		 		    <c:choose>
      		 		    	<c:when test="${dto.writer == '관리자' }">      		 		   	 		
      		 		   		</c:when>
      		 		   		<c:otherwise>
      		 							  <tr>
      		 							  	  <td scope="row">${dto.num}</td>
      		 								  <td>${dto.writer}</td>
      		 								  <td>${dto.division}</td>
      		 								  <td>
      		 									  <a href="${path}/reference_servlet/view.do?num=${dto.num}">${dto.subject}</a>
      		 									  <c:if test="${dto.comment_count > 0}">
    												  <span style="color: red;">(${dto.comment_count})</span>
   												  </c:if>
      		 								  </td>
      		 								  <td>${dto.readcount}</td>
      		 								  <td>${dto.good }</td>
      		 								  <td align="center">
      											  <c:if test="${dto.filesize > 0}">
      												  <a href="${path}/reference_servlet/download.do?num=${dto.num}">
        												  <img src="/Academy/images/file.gif">
      												  </a>
     					 						  </c:if>
   				 							  </td>
   				 							  <td id="reload">${dto.down}</td>
      		 								  <td>${dto.reg_date}</td>
      					 				  </tr>
					       </c:otherwise>
  					    </c:choose>		 			
      		 		</c:forEach>
      		 	</table>
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