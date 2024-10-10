package com.kr.goguma;

import java.io.IOException;

import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import java.nio.charset.StandardCharsets; // UTF-8 인코딩을 위해 추가

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import common.NaverLoginApi;
@Component
public class NaverLoginBO {

    /* 인증 요청문을 구성하는 파라미터 */
    //client_id: 애플리케이션 등록 후 발급받은 클라이언트 아이디
    //response_type: 인증 과정에 대한 구분값. code로 값이 고정돼 있습니다.
    //redirect_uri: 네이버 로그인 인증의 결과를 전달받을 콜백 URL(URL 인코딩). 애플리케이션을 등록할 때 Callback URL에 설정한 정보입니다.
    //state: 애플리케이션이 생성한 상태 토큰
    private final static String CLIENT_ID = "kQa4KWPLE7Xs730gEyUp";       //네이버API Client ID
    private final static String CLIENT_SECRET = "dTYcoF5BDe";                      
    private final static String REDIRECT_URI = "http://localhost:8080/gogumarket/callback";
    private final static String SESSION_STATE = "oauth_state";
    /* 프로필 조회 API URL */
    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";/// Api 종류 기본 !!
    
    /* 네이버 아이디로 인증  URL 생성  Method */
    public String getAuthorizationUrl(HttpSession session) {

        /* 세션 유효성 검증을 위하여 난수를 생성 */
        String state = generateRandomString();
        /* 생성한 난수 값을 session에 저장 */
        setSession(session,state);        

        // 요청할 스코프
        String scope = "profile,email"; // 필요한 스코프를 설정합니다.
        
        String encodedRedirectUri;
        try {
            encodedRedirectUri = URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8.toString()); // URL 인코딩
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Encoding failed: " + e.getMessage());
        }

        String url = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                + "&client_id=" + CLIENT_ID
                + "&redirect_uri=" + encodedRedirectUri
                + "&state=" + state
                + "&scope=" + scope;

        return url;
    }

    /* 네이버아이디로 Callback 처리 및  AccessToken 획득 Method */
    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException{

        /* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
        String sessionState = getSession(session);
        if(StringUtils.pathEquals(sessionState, state)){
        	//밑에 코드는 위에 String url이랑 똑같음. 다만 scope만 빠져있음
        	
            OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
                    .apiKey(CLIENT_ID)
                    .apiSecret(CLIENT_SECRET)
                    .callback(REDIRECT_URI)
                    .build(NaverLoginApi.instance());

            /* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
            OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
            return accessToken;
        }
        return null;
    }

    /* 세션 유효성 검증을 위한 난수 생성기 */
    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    /* http session에 데이터 저장 */
    private void setSession(HttpSession session,String state){
        session.setAttribute(SESSION_STATE, state);     
    }

    /* http session에서 데이터 가져오기 */ 
    private String getSession(HttpSession session){
        return (String) session.getAttribute(SESSION_STATE);
    }
    /* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
    public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException{

    	OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI)
                .build(NaverLoginApi.instance());

        OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL);
        oauthService.signRequest(oauthToken, request);
        Response response = oauthService.execute(request);
        return response.getBody();
    }
    
    public void revokeNaverToken(String accessToken) throws IOException {
        
        String revokeUrl = "https://nid.naver.com/oauth2.0/token?grant_type=delete"
                           + "&client_id=" + CLIENT_ID
                           + "&client_secret=" + CLIENT_SECRET
                           + "&access_token=" + accessToken
                           + "&service_provider=NAVER";
        
        URL url = new URL(revokeUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        
        if(responseCode == 200) {
            // 토큰 무효화 성공
            System.out.println("Access Token 무효화 완료");
        } else {
            // 실패 처리
            System.out.println("Access Token 무효화 실패");
        }
    }



}