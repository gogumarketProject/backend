package product.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;
import dto.salesDto;

public class ConsumerView implements CommonExecute {
	//int 1이면 찜 체크박스 활성화, 0이면 비활성화
	@Override
	public void execute(HttpServletRequest request) {
		HttpSession session = request.getSession();
		salesDao dao = new salesDao();
		
		int s_no = Integer.parseInt(request.getParameter("s_no"));
		String id = (String)session.getAttribute("sessionId");
		
		//로그인한 구매자가 찜을 했는지 안했는지 구분
		int CheckUserlike = dao.WishListCheck(s_no,id); 
		
		//물품 내용
		salesDto productdto = dao.ProductView(s_no); 	
		
		//인기상품 - 좋아요 순 3개
		ArrayList<salesDto> likesDtos = dao.getViewLikesDtos(s_no);
		
		//거래 제안 리스트
		ArrayList<salesDto> OfferDtos = dao.getOfferList(s_no);
		
		request.setAttribute("id", id); //로그인한사람이 글 작성자와 같은지 비교
		request.setAttribute("CheckUserlike", CheckUserlike); //찜했으면 1, 안했으면 0
		request.setAttribute("likesDtos", likesDtos); //인기순 3개 불러오는 dtos
		request.setAttribute("productdto", productdto); //들어간 상품 내용 보여주는 dto
		request.setAttribute("OfferDtos", OfferDtos); //구매 제안 리스트
	}

	@Override
	public void naver(NaverLoginBO naverLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

}
