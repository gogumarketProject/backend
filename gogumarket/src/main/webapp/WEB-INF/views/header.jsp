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
       		<form action="market" method="post">
		        <div class="search-bar">
		            <i class="fa-solid fa-magnifying-glass" style="color: black; margin-right: 5px;"></i>
		           	<input type="text" name="search" value="${search }" placeholder="어떤 상품을 찾으시나요? 카페상품, 앱상품 모두 검색">
		           	<input type="hidden" name="t_gubun" value="search">
		           	<input type="submit" style="display:none;">
		        </div>
	        </form>
        <div class="search-buttons">
        	<!-- 임시 컨슈머, 판매장창 -->
        	
        	
            <!-- 채팅하기 버튼 -->
		    <a href="
		    	<c:if test="${empty email}">javascript:goLogin();</c:if>
		    	<c:if test="${not empty email}">javascript:void(0);</c:if>
		    	" class="header-link">
		    	<span class="icon chat" <c:if test="${not empty email}">id="noteButton"</c:if>>
		        	<i class="fa-solid fa-comments"></i>
		        	쪽지
		       		<span class="notification-count">0</span>
		        </span>
		    </a>
            <!-- 판매하기 버튼 -->
		    <a href="<c:if test="${empty email}">javascript:goLogin();</c:if>
		    	<c:if test="${not empty email}">javascript:goWrite();</c:if>
		    	" class="header-link">
		        <i class="fa-solid fa-bag-shopping"></i>
		        <span>판매하기</span>
		    </a>
            <!-- 마이 버튼 -->
		    <a href="<c:if test="${empty email}">javascript:goLogin();</c:if>
		    	<c:if test="${not empty email}">javascript:void(0);</c:if>
		    	" class="header-link" <c:if test="${not empty email}">id="myButton"</c:if>>
		        <i class="fa-solid fa-user"></i>
		        <span>마이</span>
		    </a>
		    
		    <!-- 마이 메뉴 (드롭다운) -->
			<div id="myMenu" class="dropdown-menu">
			    <a href="javascript:goMyPage();">마이페이지</a>
			    <a href="javascript:goLogout();">로그아웃</a>
			    
			    <form action="/gogumarket/naver/unlink" method="post">
				    <input type="hidden" name="accessToken" value="user_access_token"/>
				    <button type="submit">Naver 연동해제</button>
				</form>
			    <form action="/gogumarket/google/unlink" method="post">
				    <input type="hidden" name="accessToken" value="user_access_token"/>
				    <button type="submit">Google 연동해제</button>
				</form>
			</div>	
        </div>
    </div>
    
    <script>
	    document.addEventListener('DOMContentLoaded', function() {
	        // "마이 버튼" 클릭 시 드롭다운 메뉴를 토글하는 이벤트
	        const myButton = document.getElementById('myButton');
	        const myMenu = document.getElementById('myMenu');
	
	        if (myButton && myMenu) {
	            myButton.addEventListener('click', function(event) {
	                event.stopPropagation(); // 클릭 이벤트 전파 방지
	                myMenu.classList.toggle('show'); // 드롭다운 메뉴의 클래스 토글
	            });
	
	            // 화면의 다른 곳을 클릭했을 때 드롭다운 메뉴를 닫음
	            document.addEventListener('click', function() {
	                myMenu.classList.remove('show');
	            });
	
	            // 드롭다운 메뉴 클릭 시 메뉴가 닫히지 않도록 이벤트 전파 방지
	            myMenu.addEventListener('click', function(event) {
	                event.stopPropagation();
	            });
	        }
	    });
    </script>
    
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

