package product.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.GoogleLoginBO;
import com.kr.goguma.NaverLoginBO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.CommonExecute;
import common.CommonUtil;
import dao.salesDao;
import dto.salesDto;

public class Uploadupdate implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		HttpSession session = request.getSession();
		String msg = "", url = "";
			int s_no = Integer.parseInt(request.getParameter("s_no"));
			String price = request.getParameter("price");
			//,로 넘어오는거 공백으로 바꾸는거 추가d
			price = price.replace(",", "");
			String category_id = request.getParameter("category_id");
			String title	= request.getParameter("title");
			String contents	= request.getParameter("contents");
			String product_status = request.getParameter("product_status");
			String delivery = request.getParameter("delivery");
			String meet = request.getParameter("meet");
			String trade = "";
			String area = "";
			
			//거래 방법(택배거래=1, 직거래=2, 둘다=3) / 직거래 선택 시 input area 불러옴
			if(delivery == null) delivery = "";
			if(meet == null) meet = "";
			else area = request.getParameter("areaname");
			trade = delivery + meet;
			if(trade.equals("12")) trade = "3";
			
			salesDto dto = new salesDto("", category_id, title, contents, product_status, trade, area, "", "", price, s_no);
			int result = dao.updateSales(dto);
			if(result == 1) {
				msg = "수정 성공!";
				url = "market";
			} else {
				msg = "수정 실패! 관리자에게 문의해주세요.";
				url = "market";
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
	}

	@Override
	public void naver(NaverLoginBO naverLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub

	}

	@Override
	public void google(GoogleLoginBO googleLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

}
