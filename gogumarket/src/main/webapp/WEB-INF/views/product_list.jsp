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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_list.css">
    <script type="text/javascript">
    	function goPage(page){
    		paging.t_nowPage.value = page;
    		paging.method = "get";
    		paging.action = "market"
    		paging.submit();
    	}
    	function goSearch(){
    		paging.t_nowPage.value = page;
    		paging.method = "get";
    		paging.action = "market"
    		paging.submit();
    	}
    </script>
</head>
<body>

	<%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>
    <form name="paging">
    	<input type="hidden" name="t_gubun" value="Search">
    	<input type="hidden" name="t_nowPage">
    	<input type="hidden" name="search" value="${search }">
    	<input type="hidden" name="category_id" value="${category_id }">
    	<input type="hidden" name="min_price" value="${min_price }">
    	<input type="hidden" name="max_price" value="${max_price }">
    	<input type="hidden" name="trade" value="${trade }">
    	<input type="hidden" name="product_status" value="${product_status }">
    	<input type="hidden" name="sort" value="${sort }">
    </form>
	<div class="container">
	    <!-- 2열 4행 테이블 -->
	    <form name="search">
	    <input type="hidden" name="t_gubun" value="Search">
	    <input type="hidden" name="category_id" id="category" value="${category_id }">
	    <input type="hidden" name="search" value="${search }">
	    <div class="table-container">
	    	<span class="search-result">검색 결과</span>
	        <table id="details-table">
	        	<colgroup>
	        		<col width="15%">
	        		<col width="85%">
	        	</colgroup>
	            <tr>
	                <td class="category-cell">
		                카테고리
		                <button id="category-btn" class="category-btn">+</button>
	                </td>
	                <td id="selected-category">
	                	<c:if test="${category_id eq ''}">전체</c:if>
	                	<c:if test="${category_id eq '1'}">패션의류</c:if>
	                	<c:if test="${category_id eq '2'}">패션잡화</c:if>
	                	<c:if test="${category_id eq '3'}">가방/핸드백</c:if>
	                	<c:if test="${category_id eq '4'}">시계/쥬얼리</c:if>
	                	<c:if test="${category_id eq '5'}">가전제품</c:if>
	                	<c:if test="${category_id eq '6'}">모바일/태블릿</c:if>
	                	<c:if test="${category_id eq '7'}">노트북/PC</c:if>
	                	<c:if test="${category_id eq '8'}">게임</c:if>
	                	<c:if test="${category_id eq '9'}">가구/인테리어</c:if>
	                </td>
	            </tr>
	            <tr id="hidden-row" style="display: none;"> <!-- 기본적으로 숨겨져 있는 행 -->
			        <td></td>
			        <td id="category-list"></td>
			    </tr>
	            <tr>
	                <td>가격</td>
	                <td>
					    <div class="price-filter" style="display: inline-block;">
					        <input type="text" id="min-price" placeholder="최소 가격" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
					        ~ 
					        <input type="text" id="max-price" placeholder="최대 가격" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
					    </div>
					</td>
	            </tr>
	            <tr>
	                <td>거래 방법</td>
	                <td>
		                <div class="options">
		                    <input type="checkbox" name="delivery" id="delivery" value="1">
		                    <label for="delivery">택배</label>
		                    <input type="checkbox" name="direct" id="direct" value="2">
		                    <label for="direct">직거래</label>
		                </div>
	                </td>
	            </tr>
	            <tr>
	                <td>상품 상태</td>
	                <td>
		                <div class="status-filter">
		                    <input type="radio" name="product_status" id="new" value="new">
		                    <label for="new">새상품</label>
		                    <input type="radio" name="product_status" id="used" value="used">
		                    <label for="used">중고</label>
		                </div>
	                </td>
	            </tr>
	            <tr>
	            	<td colspan="2">
	            		<button id="reset-btn" style="white-space: pre;">초기화</button>
	            		<button id="search-btn" style="white-space: pre;" onclick="goSearch()">검색</button>
	            	</td>
	            </tr>
	        </table>
	    </div>
	    </form>
	    <!-- 정렬 박스 -->
	    <div class="sort-box">
		    <button class="sort-btn active" data-sort="recent">최신순</button> |
		    <button class="sort-btn" data-sort="low-price">낮은가격순</button> |
		    <button class="sort-btn" data-sort="high-price">높은가격순</button>
		</div>
	
	    <!-- 상품 목록 -->
		<div class="product-list">
	    <c:forEach items="${dtos }" var="dto">
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
		</div>
		
		<!-- 페이징 버튼 -->
		<nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
            	${pageDis }
            </ul>
        </nav>
	</div>

	<%@include file="footer.jsp" %>	

    <script src="${pageContext.request.contextPath}/resources/js/product_list.js"></script>
</body>
</html>
