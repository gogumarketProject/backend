package product.command;

import java.io.File;
import java.io.IOException;

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

public class UploadSales implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		salesDao dao = new salesDao();
		HttpSession session = request.getSession();
		int maxSize	= 1024 * 1024 * 10;
		String pds_dir = CommonUtil.getImageDir();
		String msg = "", url = "";
		try {
			MultipartRequest mpr = new MultipartRequest(request, pds_dir, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			String image	= (String)mpr.getFilesystemName("image");
			if(image == null) image = "";
			int s_no = dao.getSaleNo();
			String price = mpr.getParameter("price");
			String s_id	= (String)session.getAttribute("sessionId");
			String reg_date	= CommonUtil.getTodayTime();
			String category_id = mpr.getParameter("category_id");
			String title	= mpr.getParameter("title");
			String contents	= mpr.getParameter("contents");
			String product_status = mpr.getParameter("product_status");
			String delivery = mpr.getParameter("delivery");
			String meet = mpr.getParameter("meet");
			String trade = "";
			String area = "";
			
			//거래 방법(택배거래=1, 직거래=2, 둘다=3) / 직거래 선택 시 input area 불러옴
			if(delivery == null) delivery = "";
			if(meet == null) meet = "";
			else area = mpr.getParameter("area");
			trade = delivery + meet;
			if(trade.equals("12")) trade = "3";
			
			salesDto dto = new salesDto(s_id, category_id, title, contents, product_status, trade, area, reg_date, image, price, s_no);
			
			int result = dao.uploadSales(dto);
			if(result == 1) {
				msg = "등록 성공!";
				url = "market";
			} else {
				msg = "등록 실패! 관리자에게 문의해주세요.";
				url = "market";
			}
			
			// 업로드 실패 시 파일 삭제
			if(result == 0 && !image.equals("")){
				File file = new File(pds_dir, image);
				boolean fileDel = file.delete();
				if(!fileDel) System.out.print("파일 삭제 실패! product.command/UploadSales.java");
			}
		} catch (IOException e) {
			e.printStackTrace();
			msg = "등록 실패! 관리자에게 문의해주세요.";
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
