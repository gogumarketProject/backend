<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
    </style>
    
    <script>
    	function DBLogin() {
    		
    		if(login.t_id.value=='admin' && login.t_pw.value=='1234') {
    			login.t_gubun.value = "DBLogin";
    			
        		login.method="post";
        		login.action="market";
        		login.submit();
    		}
    		else {
    			alert('아이디와 비밀번호를 확인하세요.');
    		}
    	}
    	
    	function goLogin() {
			mem.t_gubun.value = "login";
			mem.method = "post";
			mem.action = "market";
			mem.submit();
		}
    	
    	document.addEventListener('DOMContentLoaded', function() {
    	    // 로그인 폼의 엔터 키 입력 방지
    	    const loginForm = document.forms['login'];

    	    if (loginForm) {
    	        loginForm.addEventListener('keypress', function(event) {
    	            // Enter 키가 눌렸을 때
    	            if (event.key === 'Enter') {
    	                event.preventDefault(); // 기본 동작인 폼 제출을 막음
    	                DBLogin(); // DBLogin 함수를 호출하여 처리
    	            }
    	        });
    	    }
    	});
    </script>
    <script>
    	const googleUrl = ${googleurl};
    	console.log("${googleurl}"); 
	</script>
	
</head>

<body>
    <%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>

    <!-- 로고 영역 추가 -->
    <div class="logo-container">
        <h1>Gogumarket</h1>
    </div>
	
	<form name="login">
		<input type="hidden" name="t_gubun"> 
    <!-- 로그인 박스 -->
    <div class="login-container">
        <div class="login-box">
        
            
            
            
           	<p>고구마켓에 오신 것을 환영합니다.</p>
            <!-- 테스트용 -->
            <!-- 아이디와 비밀번호 입력란 추가 -->
            <div class="input-fields" style="margin-top: -20px;">
                <input type="text" name="t_id" placeholder="아이디" style="margin: 30px 0 10px -90px;">
                <input type="password" name="t_pw" placeholder="비밀번호">
                <button type="button" style="margin-top: -60px;display: inline-block;width: 25%;float: right;height: 110px;" onclick="DBLogin();">로그인</button>
            </div>
            <!-- 테스트용 -->
            
            
            <button type="button" class="google-btn" style="margin-top:30px;" onclick="location.href='${googleurl}'">
            	<i class="fab fa-google"></i>
             	<span class="label-google">구글로 시작하기</span>
            </button>
            <!-- 네이버 로그인 화면으로 이동 시키는 URL -->
			<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
			<button type="button" class="naver-login-btn" onclick="location.href='${naverurl}'">
			    <div class="icon-wrapper">
			        <svg stroke="currentColor" fill="currentColor" stroke-width="0" role="img" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
			            <path d="M1.6 0S0 0 0 1.6v20.8S0 24 1.6 24h20.8s1.6 0 1.6-1.6V1.6S24 0 22.4 0zm3.415 5.6h4.78l4.425 6.458V5.6h4.765v12.8h-4.78L9.78 11.943V18.4H5.015Z"></path>
			        </svg>
			    </div>
			    <span class="label-naver">네이버로 시작하기</span>
			</button> 
			<br>
			
			
			
			
			
            <button type="button" class="phone-btn" onclick=""><i class="fas fa-mobile-alt" style="margin-left:10px;"></i> 휴대폰번호로 시작하기</button>
            <div class="checkbox">
                <input type="checkbox" id="keep-login">
                <label for="keep-login">로그인 유지하기</label>
            </div>
        </div>
        
        <!-- 공용 PC 문구 추가 -->
		<small class="public-pc-warning">공용 PC에서는 [로그인 유지하기]를 꺼주세요</small>
    </div>
	</form>
	 
	
	
	
    <%@include file="footer.jsp" %>

    <script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>

</html>
