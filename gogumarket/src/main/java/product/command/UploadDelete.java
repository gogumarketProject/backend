package product.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;

public class UploadDelete implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		String msg = ""; String url = "";
		int s_no = Integer.parseInt(request.getParameter("s_no"));
		
		int result = dao.DeleteSales(s_no);
		
		if(result == 1) {
			msg = "삭제 성공!";
			url = "market";
		} else {
			msg = "삭제 실패! 관리자에게 문의해주세요.";
			url = "market";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
	}

	@Override
	public void naver(NaverLoginBO naverLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub

	}

}
