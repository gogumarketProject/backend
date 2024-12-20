package product.command;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.GoogleLoginBO;
import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;
import common.CommonUtil;
import dao.salesDao;
import dto.salesDto;

public class SearchList implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		
		String search = request.getParameter("search");
		String category_id = request.getParameter("category_id");
		String min_price = request.getParameter("min_price");
		String max_price = request.getParameter("max_price");
		String trade = request.getParameter("trade");
		String product_status = request.getParameter("product_status");
		String sort = request.getParameter("sort");
		if(search == null) search = "";
		if(category_id == null) category_id = "";
		if(min_price == null) min_price = "0";
		if(max_price == null) max_price = "99999999";
		if(trade == null) trade = "";
		if(product_status == null) product_status = "";
		if(sort == null) sort = "s_no desc";  // 정렬 순서 기본값
		
		/* paging 설정 start*/
		int totalCount = dao.getTotalCount(search, category_id, min_price, max_price, trade, product_status);
		int list_setup_count = 5;  //한페이지당 출력 (행 * 열) 수
		int pageNumber_count = 2;  //한페이지당 출력 페이지 갯수
		
		String nowPage = request.getParameter("t_nowPage");
		int current_page = 0; // 현재페이지 번호
		int total_page = 0;    // 전체 페이지 수
		
		if(nowPage == null || nowPage.equals("")) current_page = 1; 
		else current_page = Integer.parseInt(nowPage);
		
		total_page = totalCount / list_setup_count;  // 몫 : 2
		int rest = 	totalCount % list_setup_count;   // 나머지:1
		if(rest !=0) total_page = total_page + 1;     // 3
		
		int start = (current_page -1) * list_setup_count + 1;
		int end   = current_page * list_setup_count;
		String pageDis = CommonUtil.pageListPost(current_page, total_page, pageNumber_count);
		/* paging 설정 end*/
		
		// 목록 불러오기
		ArrayList<salesDto> dtos = dao.getSeachView(start, end, search, category_id, min_price, max_price, trade, product_status, sort);
		
		request.setAttribute("dtos", dtos);
		request.setAttribute("pageDis", pageDis);
		request.setAttribute("search", search);
		request.setAttribute("category_id", category_id);
		request.setAttribute("min_price", min_price);
		request.setAttribute("max_price", max_price);
		request.setAttribute("trade", trade);
		request.setAttribute("product_status", product_status);
		request.setAttribute("sort", sort);
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
