package common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kr.goguma.NaverLoginBO;

public interface CommonExecute {
	void execute(HttpServletRequest request);
	void naver(NaverLoginBO naverLoginBO,Model model, HttpSession session);
}
