<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${Board_site }" var="dto" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객문의-사이트</title>
<link href="<%=request.getContextPath() %>/image/icon/title.png" rel="shortcut icon" type="image/x-icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/board/board_site_content.css">
<script type="text/javascript">
	let board_no = "${dto.getInqsi_no() }";
</script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/board/board_site_content.js"></script>
</head>
<body>
	<div id="container">
		<jsp:include page="../include/header.jsp" />
		<div id="content">
			<form action="<%=request.getContextPath() %>/board_site_modify.do" method="post" onsubmit="return modify_check()" name="form">
		    	<input type="hidden" value="${dto.getInqsi_no() }" name="site_no">
		    	<div id="board_main">
		    		<table class="board_list">
		    			<tr>
		    				<th style="width: 100px;">
		    					작성자
		    				</th>
		    				<td>
		    					${dto.getInqsi_writer() }
		    				</td>
		    				<c:if test="${empty dto.getInqsi_update() }">
		    				<th style="width: 100px;">
		    					작성일&nbsp;<i class="fa fa-calendar" aria-hidden="true"></i>
		    				</th>
		    				<td style="width: 150px;">
		    					${dto.getInqsi_date().substring(0,10) }
		    				</td>
		    				</c:if>
		    				<c:if test="${!empty dto.getInqsi_update() }">
		    				<th style="width: 100px;">
		    					갱신일&nbsp;<i class="fa fa-calendar" aria-hidden="true"></i>
		    				</th>
		    				<td style="width: 150px;">
		    					${dto.getInqsi_update().substring(0,10) }
		    				</td>
		    				</c:if>
		    			</tr>
		    			<tr>
		    				<th style="width: 100px;">
		    					제목
		    				</th>
		    				<td colspan="3"> 
		    					${dto.getInqsi_title() }
		    				</td>
		    			</tr>
		    			<tr>
		    				<th>
		    					문의내용
		    				</th>
		    			</tr>
		    			<tr>
		    				<td class="board_list_content" colspan="4">
			    				<% pageContext.setAttribute("newLine", "\r\n"); %>
								${fn:replace(dto.getInqsi_content(), newLine, '<br/>')}
		    				</td>
		    			</tr>
		    			<tr>
		    				<td colspan="4">
		    					<div id="board_reply">
		    					<p id = "reply_title"><b><i class="fa fa-comments-o" aria-hidden="true"></i>&nbsp;comment</b></p>
		    						<div id="reply_view">
		    						</div>
		    						<div id="reply_write">
		    							<div id="reply_write_head">
		    								댓글 입력
		    							</div>
		    							<div id="reply_write_body">
		    								<textarea rows="" cols=""></textarea>
		    							</div>
		    							<div id="reply_write_btn">
		    								<input type="button" value="댓글 등록" onclick="insert_reply()">
		    							</div>
		    						</div>
		    					</div>
		    				</td>
		    			</tr>
		    		</table>
		    		<table class="board_list" id="modify_board_list">
		    			<tr>
		    				<td colspan="4"><i class="fa fa-exclamation-circle" aria-hidden="true"></i>
		    				&nbsp;변경사항을 입력해주세요.&nbsp;
		    				<i class="fa fa-exclamation-circle" aria-hidden="true"></i></td>
		    			</tr>
		    			<tr>
		    				<th style="width: 100px;">
		    					작성자
		    				</th>
		    				<td> 
		    					${dto.getInqsi_writer() }
		    				</td>
		    				<c:if test="${empty dto.getInqsi_update() }">
		    				<th style="width: 100px;">
		    					작성일&nbsp;<i class="fa fa-calendar" aria-hidden="true"></i>
		    				</th>
		    				<td style="width: 150px;">
		    					${dto.getInqsi_date().substring(0,10) }
		    				</td>
		    				</c:if>
		    				<c:if test="${!empty dto.getInqsi_update() }">
		    				<th style="width: 100px;">
		    					갱신일&nbsp;<i class="fa fa-calendar" aria-hidden="true"></i>
		    				</th>
		    				<td style="width: 150px;">
		    					${dto.getInqsi_update().substring(0,10) }
		    				</td>
		    				</c:if>
		    			</tr>
		    			<tr>
		    				<th>
		    					제목
		    				</th>
		    				<td colspan="3"> 
		    					<input type="text" name="site_title" value="${dto.getInqsi_title() }">
		    				</td>
		    			</tr>
		    			<tr>
		    				<th>
		    					문의내용
		    				</th>
		    			</tr>
		    			<tr>
		    				<td class="board_list_content" colspan="4">
			    				<textarea cols="" rows="" name="site_content">${dto.getInqsi_content() }</textarea>
		    				</td>
		    			</tr>
		    		</table>
		    	</div>
		    	<div class="board_btn" style="display: none;">
	    			<input type="submit" value="수정">&nbsp;&nbsp;
	    			<input type="button" value="삭제" onclick="if(confirm('문의 내용을 삭제합니다.')){location.href='<%=request.getContextPath() %>/board_site_delete.do?board_no=${dto.getInqsi_no() }'; }else{return; }">&nbsp;&nbsp;
	    			<input type="button" value="목록으로" onclick="location.href='<%=request.getContextPath() %>/user_board_main.do'">
	    		</div>
	    		<div class="board_btn">
	    			<input type="button" value="편집하기" onclick="modify_content_toggle()">&nbsp;&nbsp;
	    			<input type="button" value="목록으로" onclick="location.href='<%=request.getContextPath() %>/user_board_main.do'">
	    		</div>
    		</form>
    	</div>
    	<jsp:include page="../include/footer.jsp" />
    </div>
</body>
</html>