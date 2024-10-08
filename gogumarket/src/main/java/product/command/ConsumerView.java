package product.command;

import javax.servlet.http.HttpServletRequest;

import common.CommonExecute;
import dao.salesDao;

public class ConsumerView implements CommonExecute {
	//int 1이면 찜 체크박스 활성화, 0이면 비활성화
	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		
		String s_no = "1";
		String id = "test";
		
		int like = dao.WishListCheck(s_no,id);
		
		request.setAttribute("like", like);
	}

}
