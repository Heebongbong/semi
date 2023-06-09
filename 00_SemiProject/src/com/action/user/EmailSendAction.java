package com.action.user;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.*;

import com.action.Action;
import com.action.ActionForward;
import com.model.user.UserDAO;

public class EmailSendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//	email , check 파라미터를 이용해서 check에 일치하는 조건에 따라 email로 메일을 발송함
		String user_email = request.getParameter("email").trim();
		String path_check = request.getParameter("check").trim();
		
		final String user = "semisendemail@gmail.com";
	    final String password = "jappkrtfvhukiomh";
	    String code = UserDAO.getInstance().insertEmailCode(user_email);
	    int result = 0;
		try{
			Properties clsProp = System.getProperties();
			
			clsProp.put("mail.smtp.host", "smtp.gmail.com");
			clsProp.put("mail.smtp.port", 465);
			clsProp.put("mail.smtp.auth", "true");
			clsProp.put("mail.smtp.ssl.enable", "true");
			clsProp.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			
			Session clsSession = Session.getInstance(clsProp, new Authenticator(){
				public PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(user, password);
				}
			});
			
			Message clsMessage = new MimeMessage(clsSession);
			
			// 발신자 이메일 주소를 설정한다.
			clsMessage.setFrom(new InternetAddress(user));
			
			// 수신자 이메일 주소를 설정한다.
			clsMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(user_email));
			
			//제목 + 내용
			if(path_check.equals("user_join")) {
				clsMessage.setSubject("GoCatchStay 회원가입 이메일 인증입니다.");
				clsMessage.setContent("안녕하세요 GoCatchStay입니다.<br>"
						+ "GoCatchStay에 오신것을 환영합니다.<br>"
						+ " 회원가입을 위한 인증코드는 ["+code+"] 입니다.", "text/html; charset=UTF-8");
				Transport.send(clsMessage);
				result = 1;
				response.getWriter().println(result);
				
				
			}else if(path_check.equals("id_search")){
				clsMessage.setSubject("GoCatchStay ID 찾기 이메일 인증입니다.");
				clsMessage.setContent("안녕하세요 GoCatchStay입니다.<br>"
						+ "회원님의 아이디를 찾기 위한 인증코드는 ["+code+"] 입니다.", "text/html; charset=UTF-8");
				Transport.send(clsMessage);
				
				ActionForward forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("/login/login_id_search.jsp");
				return forward;
				
			}else if(path_check.equals("pwd_search")) {
				clsMessage.setSubject("GoCatchStay 비밀번호 찾기 이메일 인증입니다.");
				clsMessage.setContent("안녕하세요 GoCatchStay입니다.<br>"
						+ "회원님의 비밀번호를 찾기 위한 인증코드는 ["+code+"] 입니다.", "text/html; charset=UTF-8");
				Transport.send(clsMessage);

				ActionForward forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("/login/login_pwd_search.jsp");
				return forward;
				
			}else if(path_check.equals("apply_owner")){
				String name = request.getParameter("apply_name");
				String business = request.getParameter("apply_business");
				String phone = request.getParameter("apply_phone");
				String req = request.getParameter("apply_req");
				
				clsMessage.setSubject(name+" 상담 요청");
				clsMessage.setContent("이름 : "+name+"<br>"
						+ "사업자번호 : "+business+"<br>"
						+ "연락처 : "+phone+"<br>"
						+ "요청사항 : "+req, "text/html; charset=UTF-8");
				Transport.send(clsMessage);
				
				ActionForward forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("index_move.do");
				return forward;
			}else if(path_check.equals("owner_id_search")){
				clsMessage.setSubject("GoCatchStay ID 찾기 이메일 인증입니다.");
				clsMessage.setContent("안녕하세요 GoCatchStay입니다.<br>"
						+ "회원님의 아이디를 찾기 위한 인증코드는 ["+code+"] 입니다.", "text/html; charset=UTF-8");
				Transport.send(clsMessage);
				
				ActionForward forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("owner/manage/id_search.jsp");
				return forward;
			}
			else if(path_check.equals("owner_pwd_search")) {
				clsMessage.setSubject("GoCatchStay 비밀번호 찾기 이메일 인증입니다.");
				clsMessage.setContent("안녕하세요 GoCatchStay입니다.<br>"
						+ "회원님의 비밀번호를 찾기 위한 인증코드는 ["+code+"] 입니다.", "text/html; charset=UTF-8");
				Transport.send(clsMessage);

				ActionForward forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("owner/manage/pwd_search.jsp");
				return forward;
			}
			else { //path_check 실패
				result = 0;
			}
		}
		catch( Exception e ){
			e.printStackTrace();
		}
		return null;
	}
}
