package mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.GoogleLoginBO;
import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;
import dto.salesDto;

public class MyPage implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sessionId");
		
		if(id == null) {
			id = "";
		}
		
		//판매내역
		ArrayList<salesDto> sales = dao.MyPageSales(id);
		//구매내역
		ArrayList<salesDto> purchase = dao.MyPagePurchase(id);
		//찜한상품
		ArrayList<salesDto> wish = dao.MyPageWish(id);
		//제안받은상품
		ArrayList<salesDto> sellOffer = dao.MyPageSellOffer(id);
		//제안한상품
		ArrayList<salesDto> purchaseOffer = dao.MyPagePurchaseOffer(id);
		
		request.setAttribute("sales", sales);
		request.setAttribute("purchase", purchase);
		request.setAttribute("wish", wish);
		request.setAttribute("sellOffer", sellOffer);
		request.setAttribute("purchaseOffer", purchaseOffer);
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
