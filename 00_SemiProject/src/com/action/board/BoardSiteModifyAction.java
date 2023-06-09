package com.action.board;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.model.board.BoardDAO;
import com.model.board.Inquiry_SiteDTO;

public class BoardSiteModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Inquiry_SiteDTO board = new Inquiry_SiteDTO();
		
		int site_no = Integer.parseInt(request.getParameter("site_no").trim());
		String site_title = request.getParameter("site_title").trim();
		String site_content = request.getParameter("site_content").trim();
		
		board.setInqsi_no(site_no);
		board.setInqsi_title(site_title);
		board.setInqsi_content(site_content);
		int re = BoardDAO.getInstance().updateSiteBoardContent(board);
		
		if(re>0) {
			ActionForward forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("board_Get_Site_Content.do?board_no="+site_no);
			return forward;
		}else {
			response.getWriter().println("<script>"
					+ "alert('수정 중 오류가 발생했습니다.');"
					+ "history.back();"
					+ "</script>");
			return null;
		}
	}
}