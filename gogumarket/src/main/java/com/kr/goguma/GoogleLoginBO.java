package com.kr.goguma;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.client.RestTemplate;

import dto.googleRequest;

@Component
public class GoogleLoginBO {
	private static final String GOOGLE_CLIENT_ID = "";
	private static final String GOOGLE_CLIENT_SECRET = "";
	private final static String REDIRECT_URI = "http://localhost:8080/gogumarket/google";
	
	public static String getGoogleClientId() {
        return GOOGLE_CLIENT_ID;
    }

    public static String getGoogleClientSecret() {
        return GOOGLE_CLIENT_SECRET;
    }
    
	/* Google 아이디로 인증  URL 생성  Method */
    public String getAuthorizationUrl(HttpSession session) {

    	// Google OAuth2 인증 URL 생성
        String reqUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=" + GOOGLE_CLIENT_ID
                + "&redirect_uri="+REDIRECT_URI
                + "&response_type=code&scope=email%20profile%20openid&access_type=offline";
        return reqUrl;
    }
    
    // Access Token과 Refresh Token 요청 메서드
    public String getTokens(String authCode) {
        String url = "https://oauth2.googleapis.com/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        String body = "client_id=" + GOOGLE_CLIENT_ID +
                      "&client_secret=" + GOOGLE_CLIENT_SECRET +
                      "&code=" + authCode +
                      "&grant_type=authorization_code" +
                      "&redirect_uri=" + REDIRECT_URI;

        HttpEntity<String> request = new HttpEntity<>(body, headers);
        RestTemplate restTemplate = new RestTemplate();

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, request, String.class);

            // 응답 상태 코드 확인
            if (response.getStatusCode() == HttpStatus.OK) {
                JSONObject jsonResponse = new JSONObject(response.getBody());
                String accessToken = jsonResponse.getString("access_token");
                String refreshToken = jsonResponse.optString("refresh_token"); // 리프레시 토큰이 있을 경우만
                return accessToken; // Access Token 반환
            } else {
                System.out.println("Access Token 요청 실패: " + response.getBody());
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    
    public String refreshAccessToken(googleRequest googleOAuthRequestParam) {
        String url = "https://oauth2.googleapis.com/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        String body = "client_id=" + GOOGLE_CLIENT_ID +
                      "&client_secret=" + GOOGLE_CLIENT_SECRET +
                      "&refresh_token=" + googleOAuthRequestParam +
                      "&grant_type=refresh_token";

        HttpEntity<String> request = new HttpEntity<>(body, headers);
        RestTemplate restTemplate = new RestTemplate();

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, request, String.class);

            // 응답 상태 코드 확인
            if (response.getStatusCode() == HttpStatus.OK) {
                JSONObject jsonResponse = new JSONObject(response.getBody());
                return jsonResponse.getString("access_token"); // 새로운 Access Token 반환
            } else {
                System.out.println("Refresh Token 요청 실패: " + response.getBody());
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    
    // Google 연동 해제 로직
    public boolean unlinkGoogle(String accessToken) {
        String revokeUrl = "https://accounts.google.com/o/oauth2/revoke?token=" + accessToken;
        HttpURLConnection conn = null;

        try {
            URL url = new URL(revokeUrl);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            int responseCode = conn.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // 응답 본문 읽기
            if (responseCode == HttpURLConnection.HTTP_OK) {
                System.out.println("Google unlink successful.");
                return true; // 연동 해제 성공
            } else {
                StringBuilder response = new StringBuilder();
                try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getErrorStream()))) {
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        response.append(inputLine);
                    }
                }
                System.out.println("Google unlink failed. Response Code: " + responseCode + ", Response: " + response.toString());
                return false; // 연동 해제 실패
            }
        } catch (IOException e) {
            e.printStackTrace(); // 예외 발생 시 로그 출력
            return false; // 오류 발생
        } finally {
            if (conn != null) {
                conn.disconnect(); // 연결 종료
            }
        }
    }
    
    public String getUserInfo(String accessToken) {
        String url = "https://www.googleapis.com/oauth2/v2/userinfo";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken); // Manually set Bearer token

        HttpEntity<String> request = new HttpEntity<>(headers);
        RestTemplate restTemplate = new RestTemplate();

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, request, String.class);

            // Check response status code
            if (response.getStatusCode() == HttpStatus.OK) {
                return response.getBody(); // Return user info
            } else {
                System.out.println("User info request failed: " + response.getBody());
                return null; // Return null on failure
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null; // Return null on exception
        }
    }
    
    // 에러 처리 메서드
    public String handleError(Model model, String errorMessage) {
        model.addAttribute("errorMessage", errorMessage);
        return "redirect:/market"; // 실패 시 리다이렉트
    }

    // 세션에 토큰 저장 메서드
    public void storeTokensInSession(HttpSession session, String accessToken, String refreshToken) {
        session.setAttribute("access_token", accessToken);
        session.setAttribute("refresh_token", refreshToken); // Refresh Token 세션에 저장
    }

    // 사용자 정보 처리 메서드
    public void handleUserInfo(HttpSession session, String userInfo) {
        String email = new JSONObject(userInfo).getString("email");
        System.out.println("email: " + email);
        session.setAttribute("email", email);
        session.setMaxInactiveInterval(60 * 30); // 세션 유지 시간 설정
    }

	
}
