package com.kr.goguma;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import common.CommonExecute;
import dao.salesDao;
import member.command.MemberLogin;
import product.command.ConsumerView;
import product.command.IndexView;
import product.command.UploadSales;

@Controller
public class GogumaController {
	
	@RequestMapping("market")
	public String market(HttpServletRequest request) {
		String gubun = request.getParameter("t_gubun");
		String viewPage = "";
		
		//인덱스
		if(gubun == null) {
			CommonExecute goguma = new IndexView();
			goguma.execute(request);
			viewPage = "index";
		}
		
		//로그인 폼
		else if(gubun.equals("login")) {
			viewPage = "login";
		}
		//DB로그인
		else if(gubun.equals("DBLogin")) {
			CommonExecute goguma = new MemberLogin();
			goguma.execute(request);
			viewPage = "common_alert";
		}
		//판매등록 폼
		else if(gubun.equals("writeForm")) {
			viewPage = "write";
		}
		//판매등록
		else if(gubun.equals("upload")) {
			CommonExecute goguma = new UploadSales();
			goguma.execute(request);
			viewPage = "common_alert";
		}
		//마이페이지
		else if(gubun.equals("myPage")) {
			viewPage = "mypage";
		}
		//소비자창 임시 버튼
		else if(gubun.equals("Consumer")) {
			CommonExecute goguma = new ConsumerView();
			goguma.execute(request);
			viewPage = "product_sell_consumer";
		}//판매자창 임시 버튼
		else if(gubun.equals("Seller")) {
			viewPage = "product_sell_seller";
		}
		
		return viewPage;
	}
	
	//product_sell_consumer ajax, 찜기능 매핑
	@RequestMapping("OnLikes") 
	public void checkLikes(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = null;
		try {
	         out = response.getWriter();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
		salesDao dao = new salesDao(); 
		int result = 0; 
		int s_no = 1;
		String id = "test"; 
		int count = dao.WishListCheck(s_no,id);
		  
		if(count == 0) { 
			result = dao.OnLikes(s_no,id); 
			if(result == 1) out.print("찜이 추가되었습니다!"); 
			else out.print("찜 오류 onlikes"); 
		}else if(count ==1) { 
		  result = dao.OffLikes(s_no,id); 
		  if(result == 1) out.print("찜이 취소되었습니다!"); 
		  else out.print("찜 오류 offlikes"); 
		}
	}
}
