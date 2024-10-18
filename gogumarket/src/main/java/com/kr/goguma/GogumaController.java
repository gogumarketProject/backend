package com.kr.goguma;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import common.CommonExecute;
import dao.salesDao;
import member.command.GoogleLogin;
import member.command.Login;
import member.command.MemberLogin;
import product.command.ConsumerView;
import product.command.IndexView;
import product.command.SeachList;
import product.command.UploadSales;

@Controller
public class GogumaController {
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private GoogleLoginBO googleLoginBO;
	private String apiResult = null;

    @Autowired
    public void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }
    
    @Autowired
    public void setNaverLoginBO(GoogleLoginBO googleLoginBO) {
        this.googleLoginBO = googleLoginBO;
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
			CommonExecute goguma1 = new GoogleLogin();
			
			goguma.naver(naverLoginBO,model,session);
			goguma1.google(googleLoginBO, model, session);
			viewPage = "login";
		}
		//구글 폼 
		else if(gubun.equals("googleLogin")) {
			CommonExecute goguma = new GoogleLogin();
			goguma.google(googleLoginBO, model, session);
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
		//판매자창 임시 버튼
		else if(gubun.equals("Seller")) {
			viewPage = "product_sell_seller";
		}
		//검색 및 메뉴 > 카테고리 클릭
		else if(gubun.equals("Search")) {
			CommonExecute goguma = new SeachList();
			goguma.execute(request);
			viewPage = "product_list";
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
		int s_no = Integer.parseInt(request.getParameter("s_no"));
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
	
	// 네이버 로그인 성공 시 callback 호출 메소드
	@RequestMapping(value = "callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam(required = false) String code,
	        @RequestParam(required = false) String state, @RequestParam(required = false) String error,
	        @RequestParam(required = false) String error_description, HttpSession session)
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

	    // 세션에 access token을 문자열로 저장
	    String accessToken = oauthToken.getAccessToken();
	    session.setAttribute("access_token", accessToken);
	    System.out.println(accessToken);

	    // 네이버 약관 동의 정보 조회
	    RestTemplate restTemplate = new RestTemplate();
	    String agreementUrl = "https://openapi.naver.com/v1/nid/agreement";

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Bearer " + accessToken); // Bearer {accessToken} 형식으로 토큰 설정
	    HttpEntity<String> entity = new HttpEntity<>(headers);

	    try {
	        ResponseEntity<String> response = restTemplate.exchange(agreementUrl, HttpMethod.GET, entity, String.class);

	        // 약관 동의 정보를 처리
	        ObjectMapper objectMapper = new ObjectMapper();
	        JsonNode agreementJson = objectMapper.readTree(response.getBody());
	        JsonNode agreementInfos = agreementJson.path("agreementInfos");

	        // 약관 정보 출력
	        for (JsonNode agreementInfo : agreementInfos) {
	            String termCode = agreementInfo.path("termCode").asText();
	            String agreeDate = agreementInfo.path("agreeDate").asText();
	            System.out.println("약관 코드: " + termCode + ", 동의 시각: " + agreeDate);
	        }

	    } catch (Exception e) {
	        System.out.println("약관 동의 정보 조회 실패: " + e.getMessage());
	        model.addAttribute("errorMessage", "약관 동의 정보를 가져오는 데 실패했습니다.");
	        return "redirect:market"; // 실패 시 로그인 페이지로 리다이렉트
	    }

	    // 사용자 정보 처리
	    ObjectMapper objectMapper = new ObjectMapper();
	    JsonNode jsonobj = objectMapper.readTree(apiResult);
	    JsonNode responseObj = jsonobj.path("response");

	    String email = responseObj.path("email").asText();
	    
	    System.out.println("email: " + email);
	    session.setAttribute("email", email);

	    // 세션 유지 시간 설정
	    session.setMaxInactiveInterval(60 * 30);

	    String msg = "고객님 환영합니다!";
	    model.addAttribute("msg", msg);
	    model.addAttribute("url", "market");

	    return "common_alert"; // 환영 메시지 페이지로 이동
	}
	
	//네이버,구글 로그아웃 메서드
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(Model model, HttpSession session, HttpServletResponse response) {
        // 네이버 Access Token 무효화는 여기서 수행하지 않음
        // 세션 무효화
        session.invalidate();

        // 브라우저 쿠키 삭제 (네이버 관련 쿠키 삭제)
        Cookie cookie = new Cookie("NID_AUT", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        
        String msg = "안녕히 가세요~!!";
        model.addAttribute("msg", msg);
        model.addAttribute("t_gubun", "index");
        model.addAttribute("url", "market");

        return "common_alert"; // 로그아웃 후 common_alert 창 띄우고 market으로
    }
	
    //네이버 연동 해제 메서드
    @RequestMapping(value = "naver/unlink", method = RequestMethod.POST)
    public String unlinkNaver(Model model, HttpSession session) {
        String accessToken = (String) session.getAttribute("access_token");

        if (accessToken == null) {
            model.addAttribute("msg", "Access token is missing.");
            return "redirect:/error"; // 에러 페이지로 리디렉션
        }

        boolean result = naverLoginBO.unlinkNaver(accessToken); // 연동 해제 수행

        if (result) {
            model.addAttribute("msg", "Naver login unlink successful.");
        } else {
            model.addAttribute("msg", "Unlink failed.");
        }

        // 로그아웃 수행
        return "redirect:/logout"; // 로그아웃 후 common_alert 창 띄우고 market으로 리디렉트
    }
    
	//네이버 서비스 항목내용 나옴 
    @RequestMapping(value = "service" ,method = RequestMethod.GET)
    public String servicePage() {
    	return "service";
    }
    
    // 구글 로그인 성공 시 callback 호출 메소드
    @RequestMapping(value = "google", method = RequestMethod.GET)
    public String loginGoogle(Model model, 
            @RequestParam(value = "code", required = false) String authCode,
            @RequestParam(required = false) String error, 
            HttpSession session) {
    	
        // 에러 처리
        if (error != null) {
            model.addAttribute("errorMessage", "로그인 실패하였습니다.");
            return "redirect:/market"; // 실패 시 리다이렉트
        }

        // authCode가 null인 경우 처리
        if (authCode == null) {
            model.addAttribute("errorMessage", "로그인 코드가 없습니다.");
            return "redirect:/market"; // 실패 시 리다이렉트
        }

        // Google API를 호출하여 액세스 토큰과 리프레시 토큰을 가져옵니다.
        String accessToken = googleLoginBO.getTokens(authCode);

        if (accessToken == null) {
            model.addAttribute("errorMessage", "토큰 요청 실패");
            return "redirect:/market"; // 실패 시 리다이렉트
        }

        // 액세스 토큰을 세션에 저장
        session.setAttribute("access_token", accessToken);

        // 사용자 정보 가져오기
        String userInfo = googleLoginBO.getUserInfo(accessToken);

        // 사용자 정보 처리
        try {
            JSONObject jsonUserInfo = new JSONObject(userInfo);
            String email = jsonUserInfo.getString("email");
            // 추가 사용자 정보 처리 (예: 사용자 세션에 저장)
            session.setAttribute("email", email);
        } catch (JSONException e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "사용자 정보 처리 중 오류 발생");
            return "redirect:/market"; // 실패 시 리다이렉트
        }

        // 세션 유지 시간 설정 (예: 30분)
        session.setMaxInactiveInterval(60 * 30);

        // 성공 시 메시지 설정
        String msg = "고객님 환영합니다!";
        model.addAttribute("msg", msg);
        model.addAttribute("url", "market");

        return "common_alert"; // 성공 시 환영 메시지 페이지로 이동
    }
    
    //구글 로그인 연동 해제
    @RequestMapping(value = "google/unlink", method = RequestMethod.POST)
    public String unlinkGoogle(Model model, HttpSession session) {
        String accessToken = (String) session.getAttribute("access_token");

        if (accessToken == null) {
            model.addAttribute("msg", "Access token이 없습니다.");
            return "redirect:/error"; // 에러 페이지로 리디렉션
        }

        boolean result = googleLoginBO.unlinkGoogle(accessToken); // 연동 해제 수행

        if (result) {
            model.addAttribute("msg", "Google 로그인 연동 해제 성공.");
        } else {
            model.addAttribute("msg", "Google 로그인 연동 해제 실패.");
        }

        // 로그아웃 수행
        return "redirect:/logout"; // 로그아웃 후 common_alert 창 띄우고 market으로 리디렉션
    }

}
