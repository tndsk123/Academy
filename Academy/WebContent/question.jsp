<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 제이쿼리 자바스크립트 추가하기 -->
	<%@ include file="js/header.jsp" %>
	 <script src="${path}/js/jquery-3.4.1.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="${path}/js/popper.js"></script>
	<!-- 부스스트랩 자바스크립트 추가하기 -->
	<script src="${path}/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#writecommit").click(function(){
		var writer=$("#writer").val();
		var subject=$("#subject").val();
		var content=$("#content").val();
		var passwd= $("#passwd").val();
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
		document.write.action="${path}/question_servlet/insert.do?writer="+writer;
		document.write.submit();
	});
	$("#writeboard").click(function() {
		var accesswrite=$("#accesswrite").val();
		if(accesswrite!=<%=session.getAttribute("nickname")%>){
			alert("로그인이 필요한 메뉴입니다.");
			$("#writeboard").prop('href', '');
		}
	}); 
});

function list_change(page) {
	var sequence=$("#sequence option:selected").val();
	location.href="${path}/question_servlet/list.do?curPage="+page+"&sequence="+sequence;	
}
function list_view() {
	document.list.action="${path}/question_servlet/list.do";
	document.list.submit();
}
</script>
<title>모바일 아카데미</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap-theme.min.css">
<!-- 커스텀 CSS 추가하기 -->
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
      		 	<h2>고객센터</h2>
      		 	<hr>
      		 	<div class="col-sm-push-9 mb-4">
      		 		<a class="btn btn-outline-success mx-1 mt-2" id="writeboard" data-toggle="modal" href="#writemodal">글쓰기</a>
      		 		<input type="hidden" value="<%=nickname%>" id="accesswrite">	
      		 	</div>
      		 	<div class="col-md-12 mb-4">
      		 		<form method="post" name="list" action="">
      		 			<select onchange="list_view()" style="width: 200px" name="sequence" id="sequence">
      		 				<c:choose>
      		 					<c:when test="${list_view == 'basic'}">
      		 				 		<option disabled selected="selected" value="basic">최신순</option>
      		 					</c:when>
      		 					<c:when test="${list_view == 'readcount'}">
      		 				 		<option disabled selected="selected" value="readcount">조회순</option>
      		 					</c:when>
      		 					<c:otherwise>
      		 						<option disabled="disabled" selected="selected" value="null">선택하세요</option>
      		 					</c:otherwise>
      		 				</c:choose>      		 				
      		 				<option value="basic">최신순</option>
      		 				<option value="readcount">조회순</option>			
      		 			</select>
      		 	  </form>
      		 	</div>
      		 	<table class="table table-striped table-hover table-responsive-sm">
      		 		<tr class="table-info">
   						<th>번호</th>
    					<th>닉네임</th>
    					<th width="40%">제목</th>
    					<th>조회수</th>
    					<th>첨부파일</th>
    					<th>다운로드</th>
    					<th>등록일자</th>
  					</tr>
      		 		<c:forEach var="dto" items="${list}">  		 		   
      		 		   			  <c:choose>
      		 		   			  	<c:when test="${dto.writer == '관리자' }">
      		 		   	 				<tr style="background: rgb(228,228,228);">
      		 								<td><font color="red">답변</font></td>
      		 								<td>${dto.writer}</td>
      		 								<td>
      		 									<c:forEach var="i" begin="1" end="${dto.re_level}">
         											&nbsp;&nbsp;
      											 </c:forEach>
      		 									<a href="${path}/question_servlet/view.do?num=${dto.num}" style="color: blue;">${dto.subject}</a>
      		 									<c:if test="${dto.comment_count > 0}">
    												<span style="color: red;">(${dto.comment_count})</span>
   												</c:if>
      		 								</td>
      		 								<td>${dto.readcount}</td> 		 						
      		 								<td align="center">
      											<c:if test="${dto.filesize > 0}">
      												<a href="${path}/question_servlet/download.do?num=${dto.num}" style="color: black;">
        												<img src="/Academy/images/file.gif">
      												</a>
     					 						</c:if>
   				 							</td>
   				 							<td id="reload">${dto.down}</td>
   				 							<td>${dto.reg_date}</td>
      					 		 		</tr>
      		 		   		  		</c:when>  		 		   		  	
      		 		   		  		<c:otherwise>
      		 		   		  		  <c:choose>
    				   			  	 	 <c:when test="${dto.show == 'y'}">
      		 							  <tr>
      		 							  	  <td>${dto.num}</td>
      		 								  <td>${dto.writer}</td>
      		 								  <td>
      		 									  <a href="${path}/question_servlet/view.do?num=${dto.num}" style="color: blue;">${dto.subject}</a>
      		 									  <c:if test="${dto.comment_count > 0}">
    												  <span style="color: red;">(${dto.comment_count})</span>
   												  </c:if>
      		 								  </td>
      		 								  <td>${dto.readcount}</td>      		 								   		 								  
      		 								  <td align="center">
      											  <c:if test="${dto.filesize > 0}">
      												  <a href="${path}/question_servlet/download.do?num=${dto.num}">
        												  <img src="/Academy/images/file.gif">
      												  </a>
     					 						  </c:if>
   				 							  </td>
   				 							  <td id="reload">${dto.down}</td>
   				 							  <td>${dto.reg_date}</td>
      					 				  </tr>
   				 					  </c:when>
    							  <c:otherwise>
    					 			  <tr>
        				 			  	  <td>${dto.num}</td>
										  <td colspan="7" align="center">삭제된 게시물입니다.</td>
      								  </tr>
					    		 </c:otherwise>
					    	  </c:choose>
					       </c:otherwise>
  					    </c:choose>		 			
      		 		</c:forEach>     
      		 	</table>
      		 	<hr/>
      		 	<div class="container">
      		 		<ul class="pagination pagination-sm mx-auto" style="justify-content: center;">
      		 			<li class="page-item">
      		 				<c:if test="${page.curBlock > 1 }">
       							<button type="button" class="page-link" onclick="list_change('1')">처음</button>
     					 	</c:if>
      		 			</li>
      		 			<li class="page-item">
      		 				<c:if test="${page.curBlock > 1}">
      					 		<button type="button" class="page-link" onclick="list_change('${page.prevPage}')">이전</button>
     					 	</c:if>
      		 			</li>
      		 			<c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
       						<c:choose>
         						<c:when test="${num == page.curPage}">
           							<li><span class="page-link" style="color: red">${num}</span></li>
         						</c:when>
         						<c:otherwise>
           							<li><button type="button" class="page-link" onclick="list_change('${num}')">${num}</button></li>
        						</c:otherwise>
       						</c:choose>
     					 </c:forEach>
     					 <li class="page-item">
     					 	<c:if test="${page.curBlock < page.totBlock}">
       					 		<button type="button" class="page-link" onclick="list_change('${page.nextPage}')">다음</button>
    					 	</c:if>
     					 </li>
     					 <li class="page-item">
     					 	<c:if test="${page.curBlock < page.totBlock}">
       							<button class="page-link" type="button" onclick="list_change('${page.totPage}')">끝</button>
    					 	</c:if>
     					 </li>
      		 		</ul>
      		 	</div>
       		 </div>
   	 	   </div>
	</section>
	<div class="modal fade" id="writemodal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">글쓰기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="${path}/question_servlet/insert.do" id="write" name="write" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>닉네임</label>
							<input name="writer" id="writer" class="form-control" value="<%=session.getAttribute("nickname")%>" disabled="disabled">
							<% session.setAttribute("writer", session.getAttribute("nickname")); %>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input name="subject" id="subject" class="form-control">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="content" id="content" class="form-control" maxlength="2048" style="height: 200px;">							
							</textarea>
						</div>
						<div class="form-group">
							<label>첨부파일</label>
							<input name="file" type="file" id="file">							
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input name="passwd" class="form-control" type="password" id="passwd">							
						</div>
						<div class="modal-footer" align="center">
							<button type="button" class="btn btn-primary" id="writecommit">확인</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
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