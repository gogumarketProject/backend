<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고구마켓</title>

    <!-- 폰트어썸 -->
    <script src="https://kit.fontawesome.com/cbbeedc0db.js" crossorigin="anonymous"></script>
    <!-- ... -->
    
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap" rel="stylesheet">
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
</head>
<body>
	<%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>


    <!-- 배너 슬라이더 -->
    <div class="banner-slider">
	    <button class="arrow left" onclick="prevBanner()">&#9664;</button>
		    <div class="banner-container" id="bannerContainer">
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner1.jpg" alt="Banner 1"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner2.jpg" alt="Banner 2"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 3"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 4"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 5"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 6"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 7"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 8"></div>
	        <div class="banner-item"><img src="${pageContext.request.contextPath}/resources/images/banner/banner3.jpg" alt="Banner 9"></div>
	        <!-- 더 많은 배너 아이템 추가 -->
	    </div>
	    <button class="arrow right" onclick="nextBanner()">&#9654;</button>
	</div>
    
    <!-- 배너 슬라이더 -->


    <!-- 인디케이터 -->
    <div class="indicator-container" id="indicatorContainer">
	    <div class="indicator"></div>
	    <div class="indicator"></div>
	    <div class="indicator"></div>
	    <div class="indicator"></div>
	    <div class="indicator"></div>
	    <div class="indicator"></div>
	    <div class="indicator"></div>
	</div>
    <!-- 인디케이터 -->
    
    <!-- 실시간 인기 상품 섹션 -->
    <section class="items-section">
        <h2>실시간 인기 상품 <a href="#" class="view-more-link">바로가기 ></a></h2>
        <div class="slider">
            <button class="arrow left" onclick="slideLeftPopular()">&#9664;</button>
            <div class="items" id="popularItemContainer">
                <!-- 실시간 인기 상품 아이템들 -->
                <c:forEach items="${likesDtos }" var="dto">
                	<div class="item">
                		<a href=javascript:goConsumer('${dto.getS_no() }')>
		                    <img src="${pageContext.request.contextPath}/resources/images/${dto.getImage_dir() }" alt="product image">
			                <div class="item-text">
			                    <h3>${dto.getTitle() }</h3>
			                    <p>${dto.getPrice() }</p>
			                    <p>
			                       	 <c:choose>
			                       	 	<c:when test="${dto.getArea() eq '' }">${dto.getReg_date() }</c:when>
			                       	 	<c:otherwise>${dto.getArea() } | ${dto.getReg_date() }</c:otherwise>
			                       	 </c:choose>
			                    </p>
			                </div>
			                <div class="item-footer">  
		                    	<div class="pay-badge">Pay</div>
	                    	</div>
	                    </a>
	                </div>
                </c:forEach>
                <!-- 더 많은 아이템 추가 -->
            </div>
            <button class="arrow right" onclick="slideRightPopular()">&#9654;</button>
        </div>
    </section>
    <!-- -->


    <!-- 방금 등록된 상품 섹션 -->
    <section class="items-section">
        <h2>방금 등록된 상품 <a href="#" class="view-more-link">바로가기 ></a></h2>
        <div class="slider">
            <button class="arrow left" onclick="slideLeft()">&#9664;</button>
            <div class="items" id="itemContainer">
                <!-- 방금 등록된 상품 아이템들 -->
               <c:forEach items="${recentDtos }" var="dto">
                	<div class="item">
                		<a href=javascript:goConsumer('${dto.getS_no() }')>
		                    <img src="${pageContext.request.contextPath}/resources/images/${dto.getImage_dir() }" alt="product image">
		                    <h3>${dto.getTitle() }</h3>
		                    <p>${dto.getPrice() }</p>
		                    <p>
		                       	 <c:choose>
		                       	 	<c:when test="${dto.getArea() eq '' }">${dto.getReg_date() }</c:when>
		                       	 	<c:otherwise>${dto.getArea() } | ${dto.getReg_date() }</c:otherwise>
		                       	 </c:choose>
		                    </p>
		                    <div class="pay-badge">Pay</div>
	                    </a>
	                </div>
                </c:forEach>
                <!-- 더 많은 아이템 추가 -->
            </div>
            <button class="arrow right" onclick="slideRight()">&#9654;</button>
        </div>
    </section>
    
    
    <!-- 광고 배너 섹션 -->
	<section class="ad-banner">
	     <img src="${pageContext.request.contextPath}/resources/images/banner/ad-banner.jpg" alt="광고 배너">
	</section>
    
	
	<%@include file="footer.jsp" %>
		
    <script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
