package product.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;

public class PriceOffer implements CommonExecute {
	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		HttpSession session = request.getSession();
		String msg = "", url = "";
		int OfferResult = 0;
		//price_offer 테이블 조회해서 0이면 등록으로 하고 1이면 수정으로 변경하게 만들기
		int s_no = Integer.parseInt(request.getParameter("s_no"));
		String id = (String)session.getAttribute("sessionId");
		int offer_price = Integer.parseInt(request.getParameter("offerPrice"));
		
		int Searchresult = dao.SearchOfferPrice(s_no,id); //이 사람이 제의를 했었는지 안했는지 검사
		
		if(Searchresult == 0) {
			//Searchresult가 0이면 등록
			OfferResult = dao.InsertOffer(s_no,id,offer_price);
			if(OfferResult == 1) {
				msg = "가격제안 성공! 판매자에게 답이 오는걸 기다려주세요.";
			}else {
				msg = "가격제안 실패! 관리자에게 문의하세요";
			}
		}else if(Searchresult == 1){
			//Searchresult가 1이면 수정
			OfferResult = dao.UpdateOffer(s_no,id,offer_price);
			if(OfferResult == 1) {
				msg = "가격제안 수정 성공! 판매자에게 답이 오는걸 기다려주세요.";
			}else {
				msg = "가격제안 수정 실패! 관리자에게 문의하세요";
			}
		}else {
			msg = "가격제안 오류! 관리자에게 문의하세요";
		}
		
		url = "market?t_gubun=Consumer&s_no="+s_no;
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
	}

	@Override
	public void naver(NaverLoginBO naverLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub

	}

}
