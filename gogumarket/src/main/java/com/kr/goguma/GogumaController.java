package com.kr.goguma;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import common.CommonExecute;
import dao.salesDao;
import member.command.Login;
import member.command.MemberLogin;
import product.command.ConsumerView;
import product.command.IndexView;
import product.command.PriceOffer;
import product.command.SeachList;
import product.command.UpdateView;
import product.command.UploadDelete;
import product.command.UploadSales;
import product.command.Uploadupdate;

@Controller
public class GogumaController {
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

    @Autowired
    public void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }
	
	@RequestMapping(value="market",method = { RequestMethod.GET, RequestMethod.POST })
	public String market(HttpServletRequest request, Model model, HttpSession session) {
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
			CommonExecute goguma = new Login();
			goguma.naver(naverLoginBO,model,session);
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
		}
		//검색 및 메뉴 > 카테고리 클릭
		else if(gubun.equals("Search")) {
			CommonExecute goguma = new SeachList();
			goguma.execute(request);
			viewPage = "product_list";
		}
		//판매자 물품 수정창 폼 이동
		else if(gubun.equals("UpdateForm")) {
			CommonExecute goguma = new UpdateView();
			goguma.execute(request);
			viewPage = "update";
		}
		//판매자 물품 db에 수정
		else if(gubun.equals("update")) {
			CommonExecute goguma = new Uploadupdate();
			goguma.execute(request);
			viewPage = "common_alert";
		}
		//판매자 물품 글 삭제
		else if(gubun.equals("Delete")) {
			CommonExecute goguma = new UploadDelete();
			goguma.execute(request);
			viewPage = "common_alert";
		}
		//가격제안
		else if(gubun.equals("Offer")) { 
			CommonExecute goguma = new PriceOffer();
			goguma.execute(request); 
			viewPage = "common_alert"; 
		}
		
		return viewPage;
	}
	
	
	//product_sell_consumer ajax, 찜기능 매핑
		@RequestMapping("ChangeStatus") 
		public void ChangeStatus(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = null;
			try {
		         out = response.getWriter();
		      } catch (IOException e) {
		         e.printStackTrace();
		      }
			salesDao dao = new salesDao(); 
			int s_no = Integer.parseInt(request.getParameter("s_no"));
			String status = request.getParameter("status");
			if(status.equals("판매중")) {
				status = "1";
			}else if(status.equals("예약중")) {
				status = "2";
			}else if(status.equals("판매완료")) {
				status = "3";
			}
			int result = dao.ChangeStatus(s_no,status);
			if(result == 1) {
				out.print("거래 제안 변경 완료!");
			}else {
				out.print("거래 제안 변경 실패! 관리자에게 문의해주세요.");
			}
		}
	
	//product_sell_consumer ajax, 찜기능 매핑
	@RequestMapping("OnLikes") 
	public void checkLikes(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = null;
		try {
	         out = response.getWriter();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
		salesDao dao = new salesDao(); 
		int result = 0; 
		int s_no = Integer.parseInt(request.getParameter("s_no"));
		String id = (String)session.getAttribute("sessionId");
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
		
    //네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "callback", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model,  @RequestParam(required = false) String code, 
            @RequestParam(required = false) String state, 
    		@RequestParam(required = false) String error,
            @RequestParam(required = false) String error_description,HttpSession session)
            throws IOException, InterruptedException, ExecutionException {
        System.out.println("여기는 callback");
        
        // 에러가 있는 경우 처리
        if (error != null) {
            System.out.println("로그인 취소됨: " + error + ", 설명: " + error_description);
            model.addAttribute("errorMessage", "로그인 취소되었습니다.");
            return "redirect:market"; // 로그인 페이지로 리다이렉트
        }

        // code와 state가 null일 경우 처리
        if (code == null || state == null) {
            model.addAttribute("errorMessage", "로그인 요청이 잘못되었습니다.");
            return "redirect:market"; // 로그인 페이지로 리다이렉트
        }

        // 정상적으로 로그인된 경우
        OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
        // 로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
        System.out.println("API 결과: " + apiResult);
        session.setAttribute("apiResult", apiResult);

        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonobj = objectMapper.readTree(apiResult);
        JsonNode responseObj = jsonobj.path("response");
        // 여기서 사용자의 정보를 처리하는 로직 추가
        String id = responseObj.path("id").asText();
        String nickname = responseObj.path("nickname").asText();
        String name = responseObj.path("name").asText();
        String email = responseObj.path("email").asText();
        // 사용자 정보를 세션에 저장하거나 DB에 저장하는 등의 처리
       // session.setAttribute("user_id", id);
       // session.setAttribute("nickname", nickname);
       // session.setAttribute("name", name);
        System.out.println("email"+email);
        session.setAttribute("email", email);
        
        
        //세션유지시간
        session.setMaxInactiveInterval(60*30);
	
        String msg = "고객님환영합니다!";
        model.addAttribute("msg", msg);
        model.addAttribute("url", "market");
        // 세션이나 데이터베이스에 사용자의 데이터를 저장하고 필요한 비즈니스 로직을 수행할 수 있습니다.
        // 예: 사용자 정보를 데이터베이스에 저장하거나 세션에 설정
        
        return "common_alert";
    }
	
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(Model model, HttpSession session, HttpServletResponse response) {
    	// 네이버 Access Token 무효화
        String accessToken = (String) session.getAttribute("access_token");
        if (accessToken != null) {
            try {
                naverLoginBO.revokeNaverToken(accessToken); // 토큰 무효화 메소드 호출
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 세션 무효화
        session.invalidate();

        // 브라우저 쿠키 삭제 (네이버 관련 쿠키 삭제)
        Cookie cookie = new Cookie("NID_AUT", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        String msg = "안녕히가세요~!!";
        model.addAttribute("msg", msg);
        model.addAttribute("t_gubun", "index");
        model.addAttribute("url", "market");

        return "common_alert"; // 로그아웃 후 common_alert 창 띄우고 market으로
    }
	
	
	
	
	
	
	
}
