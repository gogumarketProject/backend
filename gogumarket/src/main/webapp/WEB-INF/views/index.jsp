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
<<<<<<< HEAD
=======

    <style>
    	
    </style>
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
>>>>>>> a47a6331365115ed3c570831716d73bb02d9d0a4
</head>
<body>
	<%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>


    <!-- 배너 슬라이더 -->
    <div class="banner-slider">
        <div class="banner-container" id="bannerContainer">
            <div class="banner-item">
                <img src="https://via.placeholder.com/1200x300?text=Banner+1" alt="배너 1">
            </div>
            <div class="banner-item">
                <img src="https://via.placeholder.com/1200x300?text=Banner+2" alt="배너 2">
            </div>
            <div class="banner-item">
                <img src="https://via.placeholder.com/1200x300?text=Banner+3" alt="배너 3">
            </div>
        </div>
        <button class="arrow left">&#9664;</button>
        <button class="arrow right">&#9654;</button>
    </div>
    <!-- 배너 슬라이더 -->


    <!-- 인디케이터 -->
    <div class="indicator-container" id="indicatorContainer">
        <div class="indicator"></div>
        <div class="indicator"></div>
        <div class="indicator"></div>
    </div>
    <!-- 인디케이터 -->
    
    <!-- 실시간 인기 상품 섹션 -->
    <section class="items-section">
        <h2>실시간 인기 상품</h2>
        <div class="slider">
            <button class="arrow left" onclick="slideLeftPopular()">&#9664;</button>
            <div class="items" id="popularItemContainer">
                <!-- 실시간 인기 상품 아이템들 -->
                <c:forEach items="${likesDtos }" var="dto">
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
        <h2>방금 등록된 상품</h2>
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
	                    </a>
	                </div>
                </c:forEach>
                <!-- 더 많은 아이템 추가 -->
            </div>
            <button class="arrow right" onclick="slideRight()">&#9654;</button>
        </div>
    </section>
	
	<%@include file="footer.jsp" %>
		
    <script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
