package member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.GoogleLoginBO;
import com.kr.goguma.NaverLoginBO;

import common.CommonExecute;

public class GoogleLogin implements CommonExecute {

	@Override
	public void execute(HttpServletRequest request) {
		// TODO Auto-generated method stub

	}

	@Override
	public void naver(NaverLoginBO naverLoginBO, Model model, HttpSession session) {
		// TODO Auto-generated method stub

	}

	@Override
	public void google(GoogleLoginBO googleLoginBO, Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String googleAuthUrl = googleLoginBO.getAuthorizationUrl(session);
        
        //https://nid.naver.com/oauth2.0/authorize?response_type=code&
        //client_id=kQa4KWPLE7Xs730gEyUp&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fgogumarket%2Fcallback
        System.out.println("구글:" + googleAuthUrl);
        
        //네이버 
        model.addAttribute("googleurl", googleAuthUrl);
	}

}
