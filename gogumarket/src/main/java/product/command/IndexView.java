package product.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import dao.salesDao;
import dto.salesDto;

public class IndexView implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		
		//인기상품 - 좋아요 순 10개
		ArrayList<salesDto> likesDtos = dao.getIndexView("likes");
		
		//최근등록상품 - 게시물 넘버 순 10개(최근 생성)
		ArrayList<salesDto> recentDtos = dao.getIndexView("s_no");
		
		request.setAttribute("likesDtos", likesDtos);
		request.setAttribute("recentDtos", recentDtos);
	}

	@Override
	public void naver(NaverLoginBO naverLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

}
