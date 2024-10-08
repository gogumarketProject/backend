<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매 상품 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <!-- 폰트어썸 -->
    <script src="https://kit.fontawesome.com/cbbeedc0db.js" crossorigin="anonymous"></script>
    
    <style>
        
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>
	<%@include file="mypage_profile.jsp" %>
	<%@include file="popup.jsp" %>


    <!-- 메인 -->
    <div class="container">
        <!-- 프로필 섹션 -->
        <div class="profile-container">
            <div class="profile-left">
                <div class="profile-img" id="profileImage">
                    <img src="https://via.placeholder.com/120" alt="프로필 이미지">
                </div>
                <div class="profile-info">
                    <div class="profile-name" id="nicknamemain">히텅</div>
                    <div class="profile-level">Level 1</div>
                    <div class="profile-location">동작구 사당동</div>
                    <!-- 신뢰지수 추가 -->
                    <div class="trust-score">
                        <div class="trust-score-label">신뢰지수 <span id="trust-score-value">189</span></div>
                        <div class="trust-bar">
                            <div class="trust-bar-inner" id="trust-bar-inner"></div>
                            <div class="trust-bar-value">1,000</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="vertical-line"></div>
            
            <div class="profile-stats" id="profile-stats">
                <div class="profile-stat-item active" id="btn-purchase-history">구매 내역<span>60</span></div>
                <div class="profile-stat-item" id="btn-selling">판매 상품<span>30</span></div>
                <div class="profile-stat-item" id="btn-wishlist">찜한 상품<span>60</span></div>
                <div class="profile-stat-item" id="btn-offers">가격 제안<span>60</span></div>
                <div class="profile-stat-item" id="btn-transaction-reviews">거래 후기<span>10</span></div>
            </div>
        </div>
        	

        <!-- 판매 상품 섹션 -->
        <div class="section-container" id="section-selling">
            <div class="sales-header">판매 상품</div>
            <div class="tab-menu">
                <div id="tab-all" class="active">전체</div>
                <div id="tab-selling">판매중</div>
                <div id="tab-sold">판매완료</div>
            </div>
            <div class="product-list" id="product-list-selling">
                <!-- 판매 상품 리스트가 표시될 부분 -->
            </div>
            <div class="pagination" id="pagination-selling">
                <!-- 판매 상품의 페이지네이션이 표시될 부분 -->
            </div>
        </div>

        <!-- 구매 내역 섹션 -->
	    <div class="section-container" id="section-purchase-history">
	        <div class="sales-header">구매 내역</div>
	        <div class="tab-menu-purchase">
	            <div id="tab-all-purchase" class="active">전체</div>
	            <div id="tab-purchasing">구매중</div>
	            <div id="tab-purchased">구매완료</div>
	        </div>
	        <div class="product-list" id="product-list-purchase-history">
	            <!-- 구매 상품 리스트가 표시될 부분 -->
	        </div>
	        <div class="pagination" id="pagination-purchase-history">
	            <!-- 구매 상품의 페이지네이션이 표시될 부분 -->
	        </div>
	    </div>

        <!-- 찜한 상품 섹션 -->
        <div class="section-container" id="section-wishlist">
            <div class="sales-header">찜한 상품</div>
            <div class="tab-menu-wishlist">
                <div id="tab-all-wishlist" class="active">전체</div>
            </div>
            <div class="product-list" id="product-list-wishlist">
                <!-- 찜한 상품 리스트가 표시될 부분 -->
            </div>
            <div class="pagination" id="pagination-wishlist">
                <!-- 찜한 상품의 페이지네이션이 표시될 부분 -->
            </div>
        </div>

        <!-- 가격 제안 섹션 -->
        <div class="section-container" id="section-offers">
            <div class="sales-header">가격 제안</div>
            <div class="tab-menu-offers">
                <div id="tab-all-offers" class="active">판매 상품 제안</div>
                <div id="tab-purchase-offers">구매 상품 제안</div>
            </div>
            <div class="product-list" id="product-list-offers">
                <!-- 가격 제안 리스트가 표시될 부분 -->
            </div>
            <div class="pagination" id="pagination-offers">
                <!-- 가격 제안의 페이지네이션이 표시될 부분 -->
            </div>
        </div>

        <!-- 거래 후기 섹션 -->
        <div class="section-container active" id="section-transaction-reviews">
            <div class="sales-header">거래 후기</div>
            <div class="review-tab">
                <div id="tab-sales-review" class="active">받은 후기</div>
                <div id="tab-purchase-review">작성한 후기</div>
            </div>

            <div class="review-list" id="review-list">
                <!-- 거래 후기 리스트가 표시될 부분 -->
            </div>
            <div class="pagination" id="pagination-reviews">
                <!-- 거래 후기에 대한 페이지네이션 표시 -->
            </div>
        </div>
    </div>
    

    <%@include file="footer.jsp" %>
    <script>
        
    </script>
    
    
    <script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/mypage_profile.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popup.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
