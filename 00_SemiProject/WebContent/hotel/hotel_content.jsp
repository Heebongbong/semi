<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="hoDTO" value="${HotelDTO }"/>
<c:set var="hpDTO" value="${HPDTO }"/>
<c:set var="roomList" value="${RoomList }"/>
<c:set var="reviewList" value="${ReviewList }"/>
<c:set var="user" value="${sessionScope.loginUser }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/css/hotel/hotel_content.css" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/hotel/hotel_content.js"></script>
</head>
<body>
	<div id="container">
		<jsp:include page="../include/header.jsp" />
		<div id="content">
		<c:if test="${!empty hoDTO }">
			<div id="hotel_all_info">
				<div id="hotel_info">
					<div id="hotel_info_img">
						<img alt="" src="<%=request.getContextPath() %>/image/hotel/${hoDTO.getHotel_photo_folder() }/main.jpg" width="250" height="250">
					</div>
					<div id="hotel_info_detail">
						${hoDTO.getHotel_name() }
						<%--jjim 표시 --%>
						<c:set var="check" value="-1" />
						<c:forEach items="${user.getUser_jjimList() }" var="jjim">
							<c:if test="${jjim==hoDTO.getHotel_no() }">
								<c:set var="check" value="1" />
							</c:if>
						</c:forEach>
						<c:if test="${check == 1}">
							<span class="hotel_like_check" onclick="likeDelete(this, ${hoDTO.getHotel_no() })"><i class="fa fa-heart" aria-hidden="true"></i></span>
						</c:if>
						<c:if test="${check == -1}">
							<span class="hotel_like_check" onclick="likeInsert(this, ${hoDTO.getHotel_no() })"><i class="fa fa-heart-o" aria-hidden="true"></i></span>
						</c:if>
						<%--jjim 표시 end --%>
						<br>
						<c:forEach begin="1" end="${hoDTO.getHotel_star() }">★</c:forEach> ${hoDTO.getHotel_point() }/10.0<br>
						<br>
						${hoDTO.getHotel_addr() }<br>
						<hr>
						<c:if test="${hpDTO.isHp_wifi() }">
							<i class="fa fa-wifi" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_tub() }">
							<i class="fa fa-bath" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_pool() }">
							<i class="fa fa-wifi" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_restaurant() }">
							<i class="fa fa-cutlery" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_parking() }">
							<i class="fa fa-car" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_fitness() }">
							<i class="fa fa-cutlery" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_bar() }">
							<i class="fa fa-beer" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_terrace() }">
							<i class="fa fa-cutlery" aria-hidden="true"></i>
						</c:if>
						<c:if test="${hpDTO.isHp_sauna() }">
							<i class="fa fa-cutlery" aria-hidden="true"></i>
						</c:if>
					</div>
				</div>
				<div id="room_info">
					<c:forEach items="${roomList }" var="roDTO">
						<div class="room_content">
							<div class="room_content_img">
								<div>
								<c:forEach begin="1" end="${roDTO.getRoom_photo_folder_size() }" var="i">
									<img onclick="nextSlideImg(this)" alt="" src="<%=request.getContextPath() %>/image/hotel${roDTO.getRoom_photo_folder() }${i }.jpg" width="100" height="100" onclick="">
								</c:forEach>
								</div>
								<span class="next_img">&#62;</span>
							</div>
							<div class="room_content_info">
								<div>
									${roDTO.getRoom_name() }<br>
									<i class="fa fa-bed" aria-hidden="true"></i>${roDTO.getRoom_bed() } / 숙박인원 ${roDTO.getRoom_people_min() }~${roDTO.getRoom_people_max() }<br>
									${roDTO.getRoom_size() }m<sup>2</sup>&nbsp;&nbsp;<c:if test="${roDTO.getRoom_breakfast()== 'Y' }"><i class="fa fa-cutlery" aria-hidden="true"></i></c:if><br>
									${roDTO. getRoom_checkin()}:00까지 체크인
									가격 : ${roDTO.getRoom_price() }원
								</div>
								<div class="room_reserv">
									<input value="예약하기" type="button" onclick="location.href='hotel_payment.do?room_no=${roDTO.getRoom_no() }&hotel_no=${hoDTO.getHotel_no() }'">
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			</c:if>
			<div id="hotel_review">
				<div>
					<c:if test="${!empty reviewList }">
					<div id="hotel_review_table">
						<c:forEach items="${reviewList }" var="reDTO">
						<div class="hotel_review_content">
							<div class="hotel_review_content_head">
								${reDTO.getReview_writer() }<br>
								투숙일 : ${reDTO.getReview_checkindate().substring(5,10) }<br>
								<c:forEach items="${roomList }" var="roDTO">
								<c:if test="${roDTO.getRoom_no() == reDTO.getReview_roomno() }">
									<i class="fa fa-bed" aria-hidden="true"></i>&nbsp;${roDTO.getRoom_name() }
								</c:if>
								</c:forEach>
								<c:if test="${reDTO.getReview_photo()!=null }">
								<br><img alt="" src="<%=request.getContextPath() %>/image/review/${reDTO.getReview_photo() }" width="80" height="80">
								</c:if>
							</div>
							<div class="hotel_review_content_body">
								<c:if test="${user.getUser_no() == reDTO.getReview_userno() }">
								<input class="hotel_review_content_delete" type="button" onclick="location.href='<%=request.getContextPath() %>/review_delete.do?review_no=${reDTO.getReview_no() }&hotel_no=${hoDTO.getHotel_no() }'" value="삭제">
								</c:if>
								<p>${reDTO.getReview_point() }/10<br>
								<% pageContext.setAttribute("newLine", "\r\n"); %>
									${fn:replace(reDTO.getReview_content(), newLine, '<br/>')}</p>
								<p>작성일 : ${reDTO.getReview_date().substring(2,10) }</p>
							</div>
						</div>
						</c:forEach>
					</div>
					</c:if>
					<c:if test="${empty reviewList }">
					<h3>리뷰가 없습니다.</h3>
					</c:if>
				</div>
				<div id="review_write">
					<c:if test="${user!=null }">
					<form action="<%=request.getContextPath() %>/review_insert.do" method="post" enctype="multipart/form-data" onsubmit="return confirm('리뷰를 등록하시겠습니까?')">
						<input type="hidden" value="${hoDTO.getHotel_photo_folder() }" name="review_hotelname">
						<input type="hidden" value="${hoDTO.getHotel_no() }" name="review_hotelno">
						<input type="hidden" value="${user.getUser_no() }" name="review_userno">
						<table id="review_write_table">
							<tr>
								<td colspan="2">
									Rating : <input type="number" name="review_point" min="0" max="10" value="10">
								</td>
							</tr>
							<tr>
								<th>
									<input value="${user.getUser_id() }" readonly="readonly" style="width: 50px;" name="review_userid">
								</th>
								<td>
									<textarea rows="5" cols="50" name="review_content"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="file" name="review_file">
								</td>
							</tr>
						</table>
						<div id="review_wirte_btn">
							<input type="submit" value="등록">&nbsp;&nbsp;
							<input type="reset" value="다시 작성">
						</div>
					</form>
					</c:if>
					<c:if test="${user==null }">
					<a href='<%=request.getContextPath()%>/user_login_page.do'>로그인을 하세요.</a>
					</c:if>
				</div>
			</div>
			<hr>
			<div id="hotel_detail">
				<h5>호텔 정보</h5>
				<table>
					<tr>
						<th>
							설립 연도 : ${hoDTO.getHotel_establish() }
						</th>
						<th>
							객실 수 : ${hoDTO.getHotel_room_count() }
						</th>
						<th>
							연락처 : ${hoDTO.getHotel_phone() }
						</th>
					</tr>
					<tr>
						<th>
							Email : ${hoDTO.getHotel_email() }
						</th>
						<th colspan="2">
							Address : ${hoDTO.getHotel_addr() }
						</th>
					</tr>
					<tr>
						<td>
							${hoDTO.getHotel_info() }
						</td>
					</tr>
				</table>
			</div>
			<hr>
			<c:if test="${!empty sessionScope.VisitList }">
			<c:set var="visitList" value="${sessionScope.VisitList }" />
			<div id="visit_hotel">
				<c:forEach items="${visitList }" var="visitDTO">
				<div id="visit_hotel_cont">
					<div class="visit_hotel_cont_img">
						<img alt="" src="<%=request.getContextPath() %>/image/hotel/${visitDTO.getHotel_photo_folder() }/main.jpg" width="150" height="150" onclick="location.href='<%=request.getContextPath() %>/hotel_get_Content.do?hotel_no=${visitDTO.getHotel_no() }'">
					</div>
					<div class="visit_hotel_cont_txt">
						<p><a href="<%=request.getContextPath() %>/hotel_get_Content.do?hotel_no=${visitDTO.getHotel_no() }">${visitDTO.getHotel_name() }</a><br>
						Classification : ${visitDTO.getHotel_star() }★<br>
						Rating : ${visitDTO.getHotel_point() }/10.0</p>
					</div>
				</div>
				</c:forEach>
			</div>
			</c:if>
		</div>
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>
</html>