package com.action.user;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.action.login.SessionRenewal;
import com.model.user.PaymentDTO;
import com.model.user.UserDAO;

public class UserPaymentModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		int pay_no = Integer.parseInt(request.getParameter("pay_no").trim());
		String pay_name = request.getParameter("pay_name").trim();
		String pay_cardno = request.getParameter("pay_cardno1")+"-"+request.getParameter("pay_cardno2")+"-"+request.getParameter("pay_cardno3")+"-"+request.getParameter("pay_cardno4");
		String pay_cardcom = request.getParameter("pay_cardcom").trim();
		int pay_cvc = Integer.parseInt(request.getParameter("pay_cvc").trim());
		String pay_pwd = request.getParameter("pay_pwd").trim();
		String pay_date = request.getParameter("pay_date").trim();
		
		UserDAO dao = UserDAO.getInstance();
		
		PaymentDTO pay_dto = dao.getPaymentContent(pay_no);
		request.setAttribute("dtoPayment", pay_dto);
		
		SessionRenewal.renewal(request);
		
		pay_dto.setPay_name(pay_name);
		pay_dto.setPay_cardno(pay_cardno);
		pay_dto.setPay_cardcom(pay_cardcom);
		pay_dto.setPay_cvc(pay_cvc);
		pay_dto.setPay_pwd(pay_pwd);
		pay_dto.setPay_date(pay_date);

		UserDAO daoUser = UserDAO.getInstance();
		int res = daoUser.modifyPayment(pay_dto);
		ActionForward forward = new ActionForward();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("user_payment.do?no="+user_no);
		} else {
			forward.setRedirect(false);
			forward.setPath("user/user_paymentModify.jsp");
		}
		return forward;
	}
}