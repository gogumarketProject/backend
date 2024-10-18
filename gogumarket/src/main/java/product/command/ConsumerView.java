package product.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.GoogleLoginBO;
import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;
import dto.salesDto;

public class ConsumerView implements CommonExecute {
	//int 1이면 찜 체크박스 활성화, 0이면 비활성화
	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		
		int s_no = Integer.parseInt(request.getParameter("s_no"));
		String id = "test";
		
		//로그인한 구매자가 찜을 했는지 안했는지 구분
		int CheckUserlike = dao.WishListCheck(s_no,id); 
		
		//상품 정보 db에서 불러오기
		salesDto productdto = dao.ProductView(s_no); 	
		
		//인기상품 - 좋아요 순 3개
		ArrayList<salesDto> likesDtos = dao.getViewLikesDtos("likes");
		
		request.setAttribute("id", id); //로그인한사람이 글 작성자와 같은지 비교
		request.setAttribute("CheckUserlike", CheckUserlike);
		request.setAttribute("likesDtos", likesDtos);
		request.setAttribute("productdto", productdto);
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
