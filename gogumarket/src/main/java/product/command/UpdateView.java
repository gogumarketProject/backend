package product.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.GoogleLoginBO;
import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;
import dto.salesDto;

public class UpdateView implements CommonExecute {
	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		
		int s_no = Integer.parseInt(request.getParameter("s_no"));
		
		//로그인한 구매자가 찜을 했는지 안했는지 구분
		
		salesDto productdto = dao.ProductView(s_no); 	
		
		//인기상품 - 좋아요 순 3개
		
		request.setAttribute("productdto", productdto); //들어간 상품 내용 보여주는 dto
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
