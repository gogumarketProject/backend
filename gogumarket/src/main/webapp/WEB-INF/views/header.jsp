<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form name="mem">
	<input type="hidden" name="t_gubun">
	<input type="hidden" name="s_no">
</form>

<header>
	<!-- 상단 배너 -->
    <div class="top-banner">
    	<i class="fa-solid fa-gift"></i> <!-- 선물 아이콘 추가 -->
        <span>고구마켓 고객이 판매하는 하루 10만개 가량의 상품을 편리하게 검색해보세요</span>
    </div>
    <div class="header-container">
        <div class="logo">
        	<a href="javascript:location.href='market'" style="">Gogumarket</a>
       	</div>
       		<form action="market" method="get">
		        <div class="search-bar">
		            <i class="fa-solid fa-magnifying-glass" style="color: black; margin-right: 5px;"></i>
		           	<input type="text" name="search" value="${search }" placeholder="어떤 상품을 찾으시나요? 카페상품, 앱상품 모두 검색">
		           	<input type="button" onclick="goList()" style="display:none;">
		           	<input type="hidden" name="t_gubun" value="Search">
		        </div>
	        </form>
        <div class="search-buttons">
        	<!-- 임시 컨슈머, 판매장창 -->
            <button>
                <span class="icon chat" id="noteButton" style="width:80px;" 
                <c:if test="${empty email}">onclick="goLogin();"</c:if>
                >쪽지</span>
                <span class="notification-count">0</span>
            </button>
            <button>
                <span class="icon sell" style="width:80px;" 
                <c:if test="${empty email}">onclick="goLogin();"</c:if>
                <c:if test="${not empty email}">onclick="goWrite();"</c:if>
                >판매하기</span>
            </button>
            <button>
                <span class="icon my-account" style="width:80px;" 
                <c:if test="${empty email}">onclick="goLogin();"</c:if>
                <c:if test="${not empty email}">onclick="goMyPage();"</c:if>
                >마이</span> 
            </button>
            <button>
                <span class="icon-logout" style="width:80px;" 
                <c:if test="${not empty email}">onclick="goLogout();"</c:if>
                >로그아웃</span> 
            </button>
            <form action="/gogumarket/naver/unlink" method="post">
			    <input type="hidden" name="accessToken" value="user_access_token"/>
			    <button type="submit">Naver 로그인 연동해제</button>
			</form>
			<form action="/gogumarket/google/unlink" method="post">
			    <input type="hidden" name="accessToken" value="user_access_token"/>
			    <button type="submit">Google 로그인 연동해제</button>
			</form>
        </div>
    </div>
    <script>
		function goLogin() {
			mem.t_gubun.value = "login";
			mem.method = "post";
			mem.action = "market";
			mem.submit();
		}
		
		function goWrite() {
			mem.t_gubun.value = "writeForm";
			mem.method = "post";
			mem.action = "market";
			mem.submit();
		}
		
		function goMyPage() {
			mem.t_gubun.value = "myPage";
			mem.method = "post";
			mem.action = "market";
			mem.submit();
		}
		function goConsumer(no){
			mem.t_gubun.value = "Consumer";
			mem.s_no.value = no;
			mem.method = "post";
			mem.action = "market";
			mem.submit();
		}
		function goSeller(){
			mem.t_gubun.value = "Seller";
			mem.method = "post";
			mem.action = "market";
			mem.submit();
		}
		function goLogout(){
			mem.method = "get";
			mem.action = "logout";
			mem.submit();
		}
    </script>
</header>

