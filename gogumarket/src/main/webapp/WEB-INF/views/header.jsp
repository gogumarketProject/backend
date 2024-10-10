<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form name="mem">
	<input type="hidden" name="t_gubun">
	<input type="hidden" name="s_no">
</form>

<header>
    <div class="header-container">
        <div class="logo">
        	<a href="javascript:location.href='market'" style="">Gogumarket</a>
       	</div>
       		<form action="market" method="get">
		        <div class="search-bar">
		            <i class="fa-solid fa-magnifying-glass" style="color: black; margin-right: 5px;"></i>
		           	<input type="text" name="search" placeholder="어떤 상품을 찾으시나요? 카페상품, 앱상품 모두 검색" value="${search }">
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
    </script>
</header>

