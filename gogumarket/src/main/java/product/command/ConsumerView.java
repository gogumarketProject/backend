package product.command;

import javax.servlet.http.HttpServletRequest;

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
		
		
		int like = dao.WishListCheck(s_no,id); //로그인한 구매자가 찜을 했는지 안했는지 구분
		salesDto dto = dao.ProductView(s_no); 	//상품 정보 db에서 불러오기
		request.setAttribute("like", like);
		request.setAttribute("dto", dto);
	}

}
