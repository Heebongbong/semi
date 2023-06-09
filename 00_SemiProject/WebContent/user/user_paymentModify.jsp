<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="user_dto" value="${sessionScope.loginUser }" />
<c:set var="pay_dto" value="${dtoPayment }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 수단 수정</title>
<link href="<%=request.getContextPath() %>/image/icon/title.png" rel="shortcut icon" type="image/x-icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	let pay_com = "${pay_dto.getPay_cardcom() }";
</script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/user/user_paymentModify.js"></script>
<link href="<%=request.getContextPath() %>/css/user/user_paymentModify.css" rel="stylesheet">
</head>
<body>
	<div id="container">
		<jsp:include page="../include/header.jsp" />
    	<div id="content">
    		<jsp:include page="../user/user_mypage_header.jsp"/>
			<div id="modifyPayment_table">
	    		<h2>내 결제수단: ${pay_dto.getPay_name()} 정보 수정</h2>
				<form method="post" action="<%=request.getContextPath()%>/user_paymentModifyOk.do" onsubmit="return modifyPaymentFormCheck()">
					<input type="hidden" name="user_no" value="${user_dto.getUser_no() }">
		    		<input type="hidden" name="pay_no" value="${pay_dto.getPay_no() }">
		    		<table>
						<tr>
							<th>카드 이름</th>
							<td>
								<input name="pay_name" id="pay_name" value="${pay_dto.getPay_name() }">
								<br>
								<span id="pay_name_check"></span>
							</td>
						</tr>
						<tr>
							<th>카드 번호</th>
							<td>
								<div id="pay_cardno">
									<input name="pay_cardno1" id="pay_cardno1" class="moveNumber" maxlength="4" value="${pay_dto.getPay_cardno().substring(0,4) }" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									<div class="card_number_txt">&nbsp;-&nbsp;</div>
									<input name="pay_cardno2" id="pay_cardno2" class="moveNumber" maxlength="4" value="${pay_dto.getPay_cardno().substring(5,9) }" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									<div class="card_number_txt">&nbsp;-&nbsp;</div>
									<input type="password" name="pay_cardno3" id="pay_cardno3" class="moveNumber" maxlength="4" value="${pay_dto.getPay_cardno().substring(10,14) }" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									<div class="card_number_txt">&nbsp;-&nbsp;</div>
									<input type="password" name="pay_cardno4" id="pay_cardno4" class="moveNumber" maxlength="4" value="${pay_dto.getPay_cardno().substring(15) }" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
								</div>
								<span id="pay_cardno_check"></span>
							</td>
						</tr>
						<tr>
							<th>카드사</th>
							<td>
								<select name="pay_cardcom" id="pay_cardcom" onchange="etc_card(this)">
									<option value="우리카드">우리카드</option>
									<option value="KB국민카드">KB국민카드</option>
									<option value="BC카드">BC카드</option>
									<option value="삼성카드">삼성카드</option>
									<option value="신한카드">신한카드</option>
									<option value="하나카드">하나카드</option>
									<option value="현대카드">현대카드</option>
									<option value="롯데카드">롯데카드</option>
									<option value="etc" id="etc_option">직접입력</option>
							    </select>
							    <input id="etc" placeholder="직접입력" style="display: none;" onchange="etc_func()" value="${pay_dto.getPay_cardcom() }">
								<br>
								<span id="pay_cardcom_check"></span>
							</td>
						</tr>
						<tr>
							<th>CVC번호(3자리)</th>
							<td>
								<input type="password" name="pay_cvc" id="pay_cvc" maxlength="3" value="${pay_dto.getPay_cvc() }" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
								<br>
								<span id="pay_cvc_check"></span>
							</td>
						</tr>
						<tr>
							<th>카드 비밀번호(앞 2자리)</th>
							<td>
								<input type="password" name="pay_pwd" id="pay_pwd" maxlength="2" value="${pay_dto.getPay_pwd() }" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">＊＊
								<br>
								<span id="pay_pwd_check"></span>
							</td>
						</tr>
						<tr>
							<th>유효기간</th>
							<td>
								<input type="date" name="pay_date" id="pay_date" value="${pay_dto.getPay_date() }">
								<br>
								<span id="pay_date_check"></span>
							</td>
						</tr>
					</table>
					<div id="pay_submit_button_div">
						<input type="submit" id="pay_submit_button" value="결제수단 수정">
					</div>
				</form>
			</div>
	    </div>
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>
</html>