<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set  var="promotion_list" value = "${Promotion}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로모션 리스트</title>
<link href="<%=request.getContextPath() %>/image/icon/title.png" rel="shortcut icon" type="image/x-icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/slick/slick.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/slick/slick-theme.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/promotion/promotion.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/promotion/promotion.js"></script>
</head>
<body>
	<div id="container">
		<jsp:include page="../include/header.jsp" />
		<div id="content">
			<c:if test="${!empty Promotion}">
	        <div class="promotion_title">Promotion</div>
	        	<script type="text/javascript" src="<%=request.getContextPath()%>/js/slick/slick.js"></script>
	        	<script src="<%=request.getContextPath()%>/js/promotion/promotion.js"></script>
	        	<div class="promotion_list">
	       		 <c:forEach items="${Promotion}" var="dto">
					<div id = "promotion_content" class="promotion_content">
						<div>
							<img onclick="openContent(${dto.getProm_no()})" class="promotion_image" src="<%=request.getContextPath()%>/image/promotion/${dto.getProm_folder()}/main.jpg">
						</div>
						<div class="post_name">
						 	<span class = "promotion_font">${dto.getProm_name()}</span>
						</div>
						<div class="post_info">
						 	<span class = "promotion_font">${dto.getProm_info()}</span>
						</div>
					</div><!--promotion content content가 한 슬라이드가 됩니다.  안에는 테이블로 해도 상관은 없을듯. 메인 안에 컨텐츠가 되는 내용의 div 내부 태그는 노상관인듯.  class end  -->
					</c:forEach>
				</div><!--promotion_list  -->
			</c:if>
			<c:if test="${empty Promotion}">
			<h3>프로모션 정보가 없습니다.</h3>
			</c:if>	
		</div>
		<jsp:include page="../include/footer.jsp" />
	</div><!--container -->
</body>
</html>