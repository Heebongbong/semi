<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="list" value="${id_List }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="<%=request.getContextPath() %>/image/icon/title.png" rel="shortcut icon" type="image/x-icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	let contextPath = "<%=request.getContextPath() %>";
</script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login/login_search.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/login/login_search.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Red+Hat+Display&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
</head>
<body>
	<div id="content">
		<form method="post" id="id_form">
			<div class="search_title">아이디 찾기</div>
			<div class="search_body">
				<span>
					<c:if test="${empty name}">
						<input type="text" name="name" class="name_inp" placeholder="이름 :">
					</c:if>
					<c:if test="${!empty name}">
						<input type="text" name="name" class="name_inp" value="${name }" readonly>
					</c:if>
				</span>
				<br>
				<span>
					<c:if test="${empty mail}">
						<input type="text" name="email" class="mail_inp" placeholder="E-mail :">
					</c:if>
					<c:if test="${!empty mail}">
						<input type="text" name="email" class="mail_inp" value="${mail }" readonly>
					</c:if>
				</span>
			</div>
			<div class="search_foot">
				<c:if test="${empty name }">
					<div id="result_send">
						<input type="button" id="result_send_btn" value="메일 전송" onclick="id_check(1)">
					</div>
				</c:if>
				<c:if test="${check==1 }">
					<div id="result_btn">
						<input type="text" placeholder="코드 입력" id="check_code" name="check_code">
						<input type="button" id="result_button" value="인증 확인" onclick="id_check(2)">
					</div>
				</c:if>
				<c:if test="${check==2 }">
					<div id="result_List">
						<h4>일치하는 아이디 리스트</h4>
						<c:if test="${!empty list }">
							<c:forEach items="${list }" var="dto">
								<p>${dto }</p>
							</c:forEach>
						</c:if>
					</div>
				</c:if>
			</div>
		</form>
	</div>
</body>
</html>