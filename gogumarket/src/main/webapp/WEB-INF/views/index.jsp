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
		function goConsumer(){
			mem.t_gubun.value = "Consumer";
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
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>
                       	 도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>5초 전</p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>
                       	 도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>5초 전</p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>
                       	 도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>5초 전</p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>
                       	 도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>5초 전</p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>
                       	 도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="인기 상품 1">
                    <h3>인기 상품 1</h3>
                    <p>100,000원</p>
                    <p>5초 전</p>
                </div>
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
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	  도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	 1분 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	  도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	 1분 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	  도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	 1분 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	  도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	 1분 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	  도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	 1분 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	  도마동 | 5초 전
                    </p>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/200x150" alt="상품 1">
                    <h3>오클리 SCOTT INSULA</h3>
                    <p>280,000원</p>
                    <p>
                      	 1분 전
                    </p>
                </div>
                <!-- 더 많은 아이템 추가 -->
            </div>
            <button class="arrow right" onclick="slideRight()">&#9654;</button>
        </div>
    </section>



	<!-- 당신을 위한 추천상품 섹션 -->
	<section class="items-section">
	    <h2>당신을 위한 추천상품</h2>
	    <div class="slider">
	        <button class="arrow left" onclick="slideLeftRecommended()">&#9664;</button>
	        <div class="items" id="recommendedItemContainer">
	            <!-- 당신을 위한 추천상품 아이템들 -->
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 1">
	                <h3>추천 상품 1</h3>
	                <p>150,000원</p>
	                <p>10초 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 2">
	                <h3>추천 상품 2</h3>
	                <p>200,000원</p>
	                <p>1분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 3">
	                <h3>추천 상품 3</h3>
	                <p>250,000원</p>
	                <p>2분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 4">
	                <h3>추천 상품 4</h3>
	                <p>300,000원</p>
	                <p>3분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 5">
	                <h3>추천 상품 5</h3>
	                <p>350,000원</p>
	                <p>4분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 6">
	                <h3>추천 상품 6</h3>
	                <p>400,000원</p>
	                <p>5분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 7">
	                <h3>추천 상품 7</h3>
	                <p>450,000원</p>
	                <p>6분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 7">
	                <h3>추천 상품 8</h3>
	                <p>450,000원</p>
	                <p>6분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 7">
	                <h3>추천 상품 9</h3>
	                <p>450,000원</p>
	                <p>6분 전</p>
	            </div>
	            <div class="item">
	                <img src="https://via.placeholder.com/200x150" alt="추천 상품 7">
	                <h3>추천 상품 10</h3>
	                <p>450,000원</p>
	                <p>6분 전</p>
	            </div>
	        </div>
	        <button class="arrow right" onclick="slideRightRecommended()">&#9654;</button>
	    </div>
	</section>
	
	<%@include file="footer.jsp" %>
		
    <script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
