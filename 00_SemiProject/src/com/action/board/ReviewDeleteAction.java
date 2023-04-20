package com.action.board;

import java.io.File;
import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.model.board.ReviewDAO;

public class ReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int hotel_no = Integer.parseInt(request.getParameter("hotel_no").trim());
		int review_no = Integer.parseInt(request.getParameter("review_no").trim());
		
		String fileName = ReviewDAO.getInstance().getReviewFileName(review_no);
		
		int re = ReviewDAO.getInstance().deleteReviewContent(review_no);
		
		if(re>0) {
			if(fileName!=null) {
				String fileFolder = "C:\\NCS\\workspace_semi\\00_SemiProject\\WebContent\\image\\review\\";
				File file = new File(fileFolder+fileName);
				file.delete();
				StringTokenizer st = new StringTokenizer(fileName, "/");
				String hotel_name = st.nextToken();
				String writer_name = st.nextToken();
				File wr_file = new File(fileFolder+hotel_name+"/"+writer_name);
				File ho_file = new File(fileFolder+hotel_name);
				if(ho_file!=null) {
					if(wr_file!=null) {
						wr_file.delete();
					}
					ho_file.delete();
				}
			}
			
			ActionForward forward = new ActionForward();
			
			forward.setRedirect(true);
			forward.setPath("hotel_get_Content.do?hotel_no="+hotel_no);
			return forward;
		}else {
			response.getWriter().println("<script>"
					+ "alert('리뷰 삭제 실패.');"
					+ "history.back();"
					+ "</script>");
			return null;
		}
	}
}