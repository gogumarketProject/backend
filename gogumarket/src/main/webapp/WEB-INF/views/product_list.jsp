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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>
    
	<div class="container">
	    <!-- 2열 4행 테이블 -->
	    <div class="table-container">
	    	<div class="table-title-con">
	    		<span class="search-result"><strong>'${search }'</strong> 검색 결과&nbsp;</span><span class="list-count" id="list-count">총 N개</span>
	    		<input type="hidden" id="search-input" value="${search }">
	    		<input type="hidden" id="category-id" value=""/>
	    	</div>
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
	                <td id="selected-category">전체</td>
	            </tr>
	            <tr id="hidden-row" style="display: none;"> <!-- 기본적으로 숨겨져 있는 행 -->
			        <td></td>
			        <td id="category-list"></td>
			    </tr>
	            <tr>
	                <td>가격</td>
	                <td>
					    <div class="price-filter" style="display: inline-block;">
					        <input type="text" id="min-price" placeholder="최소 가격" oninput="this.value = formatNumber(this.value)" maxlength="10" style="margin-left:0;"/>
					        <span>~</span> 
					        <input type="text" id="max-price" placeholder="최대 가격" oninput="this.value = formatNumber(this.value)" maxlength="10"/>
					    </div>
					</td>
	            </tr>
	            <tr>
	                <td>거래 방법</td>
	                <td>
		                <div class="status-filter">
		                	<input type="checkbox" name="trade" value="" id="tradeAll" checked>
			                <label for="tradeAll" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
			                <span class="label-text">모두</span>
		                
		                	<input type="checkbox" name="trade" value="1" id="delivery">
			                <label for="delivery" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
			                <span class="label-text">택배</span>
			                
			                <input type="checkbox" name="trade" value="2" id="direct">
			                <label for="direct" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
			                <span class="label-text">직거래</span>
		                </div>
	                </td>
	            </tr>
	            <tr>
	                <td>상품 상태</td>
	                <td>
		                <div class="status-filter">
		                	<input type="checkbox" name="productStatus" value="" id="statusAll" checked>
			                <label for="statusAll" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
			                <span class="label-text">모두</span>
		                
		                	<input type="checkbox" name="productStatus" value="2" id="new">
			                <label for="new" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
			                <span class="label-text">새상품</span>
			                
			                <input type="checkbox" name="productStatus" value="1" name="productStatus"name="productStatus"id="used">
			                <label for="used" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
			                <span class="label-text">중고</span>
		                </div>
	                </td>
	            </tr>
	        </table>
	        <div style="display: flex; justify-content: center; ">
		        <div class="filter-control-box">
		        	<button class="filter-btn" id="search-btn">검색</button>
		        	<button class="filter-btn" id="reset-btn">초기화</button>
		        </div>
	        </div>
	    </div>
	
	    <!-- 정렬 박스 -->
	    <div class="sort-box">
		    <button class="sort-btn active" id="recent" data-sort="recent">최신순</button> |
		    <button class="sort-btn" id="likes" data-sort="likes">인기순</button> |
		    <button class="sort-btn" id="low-price" data-sort="low-price">낮은가격순</button> |
		    <button class="sort-btn" id="high-price" data-sort="high-price">높은가격순</button>
		</div>
	
	    <!-- 상품 목록 -->
		<div class="product-list" id="product-list"></div>
		<!-- 페이징 버튼 -->
		<div class="pagination" id="pagination">
		    <div class="prev"><i class="fa-solid fa-angle-left"></i></div>
		    <div class="active" data-page="1">1</div>
		    <div data-page="2">2</div>
		    <div data-page="3">3</div>
		    <div data-page="4">4</div>
		    <div class="next"><i class="fa-solid fa-angle-right"></i></div>
		</div>
	</div>

	<%@include file="footer.jsp" %>	

    <script src="${pageContext.request.contextPath}/resources/js/product_list.js"></script>
   	<script>
   		
		// 페이징 컨테이너
	    const pageContainer = document.getElementById('pagination');
   	
 		// -------------------------------- 상세검색 ------------------------------- //
 		
   		// 검색버튼
	    const searchBtn = document.getElementById('search-btn');
	    
	    // 검색버튼 클릭 시
	    searchBtn.addEventListener('click', function() {
	    	resetToFirstPage();
	    	goAjax(true);
	    	
	    	// 페이지 상단 이동
	       	window.scrollTo({
	       			top: 0,
	       			left: 0,
	       			behavior: 'smooth'
	       	});
	    });

	 	// -------------------------------- 정렬(sort) ------------------------------- //
	    
	 	// 모든 정렬 버튼을 선택
		const sortButtons = document.querySelectorAll('.sort-btn');
		
		// 버튼 클릭 시 활성화 처리
		sortButtons.forEach(button => {
		    button.addEventListener('click', async function() {
		        // 비동기 작업이 진행 중일 때 클릭을 무시
		        if (this.classList.contains('active')) return;
		
		        resetToFirstPage();
		        
		        // 모든 버튼 비활성화
		        sortButtons.forEach(btn => btn.classList.remove('active'));
		        this.classList.add('active');
		
		     	// 페이지 비동기 새로고침
		        goAjax(true);
		        
		        // 페이지 상단 이동
		       	window.scrollTo({
		       			top: 0,
		       			left: 0,
		       			behavior: 'smooth'
		       	});
		    });
		});
	 	
	    
	    // -------------------------------- 페이징 ------------------------------- //
	    
	    
	 	// 페이지를 생성하는 함수
	    function createPaging(pageDis) {
	        // 기존 내용 삭제
	        pageContainer.innerHTML = pageDis;
	    }

	    // 이벤트 위임을 사용하여 클릭 이벤트 처리
	    pageContainer.addEventListener('click', function(event) {
	        // 클릭된 요소가 데이터 속성을 가진 div인지 확인
	        if (event.target.dataset.page) {
	            goPage.call(event.target);
	        }
	    });

		 // 검색 또는 정렬 버튼 클릭 시 active 페이지를 첫 페이지로 설정
	    function resetToFirstPage() {
	      const firstPage = document.querySelector('.pagination .active');
	      if (firstPage) {
	        firstPage.classList.remove('active'); // 현재 활성화된 페이지 클래스 제거
	      }
	      const newActivePage = document.querySelector('.pagination div[data-page="1"]');
	      newActivePage.classList.add('active'); // 첫 페이지에 active 클래스 추가
	    }
	    
	    // 페이지 처리 함수
	    function goPage() {
	        // 기존 active 클래스 제거
	        const activePage = pageContainer.querySelector('.active');
	        if (activePage) activePage.classList.remove('active');
	        
	        // 클릭한 요소에 active 클래스 추가
	        this.classList.add('active');
	        
	        // 페이지 비동기 새로고침
	        goAjax(false);
	        
	        // 페이지 상단 이동
	       	window.scrollTo({
	       			top: 0,
	       			left: 0,
	       			behavior: 'smooth'
	       	});
	    }
	    
	    
	    //페이징 출력
	    function createTotalCount(count){
	    	const totalCountContainer = document.getElementById('list-count');
	    	
	    	// 기존 내용 삭제
	        totalCountContainer.innerHTML = '총 ' + count + '개';
	    }
	    
	 // -------------------------------- Ajax ------------------------------- //
	 
		// event 시 비동기 새로고침 실행 함수
	    function goAjax(paging){
		 	var page = "";	
		 
		 	if(paging) page = "1";
		 	else $('#pagination div.active').data('page');
		 
    		const filterData = {
    			   search: $('#search-input').val().trim() || null, // 검색어
                   categoryId: $('#category-id').val().trim(), // 카테고리 ID
                   minPrice: $('#min-price').val().replace(/,/g, ''), // 최소 가격, 공백이면 null
                   maxPrice: $('#max-price').val().replace(/,/g, ''), // 최대 가격, 공백이면 null
                   trade: $('input[name="trade"]:checked').val(), // 거래 방식 선택된 값
                   status: $('input[name="productStatus"]:checked').val(), // 상품 상태 선택된 값
                   sort: $('button.sort-btn.active').data('sort'), // 정렬 기준
                   page: $('#pagination div.active').data('page') // 현재 페이지 (없으면 기본값)
	    	}
	    	
	    	// AJAX 요청
            $.ajax({
            	type: "GET",
                url: "search",
                data: filterData,
                success: function(responseData) {
                	const responseArray = JSON.parse(responseData);
                	
                	if(!responseArray){
                		alert("data is null!");
                		return false;
                	}
                	
                	const product = responseArray[0];
                	const pageDis = responseArray[1];
                	const totalCount = responseArray[2];
                	
                	// 상품 목록 출력
                	createProductCard(product);
                	
                	// 상품 갯수 출력
                	createTotalCount(totalCount);
                	
                	// 페이징 출력
                	createPaging(pageDis);
                },
                error: function(xhr, status, error) {
                	alert("통신 실패!");
                	console.log("상태 코드:", xhr.status);       // HTTP 상태 코드
                    console.log("응답 텍스트:", xhr.responseText); // 서버가 반환한 에러 메시지
                    console.log("에러 메시지:", error);          // JavaScript 오류 메시지
                }
            });
	    }
	    
	 	// -------------------------------- Ajax로 가져온 값 HTML 출력 ------------------------------- //
	 
	    //상품 목록 출력
	    function createProductCard(productList) {
	        const productContainer = document.getElementById('product-list');

	        // 기존 카드 삭제
	        productContainer.innerHTML = ''; // 이전 카드 제거

	        productList.forEach(product => {

	         	// 새로운 div 요소 생성
	            var newItem = document.createElement('div');
	            newItem.className = 'item';

	            // a 요소 생성
	            var link = document.createElement('a');
	            link.href = "javascript:goConsumer(" + product.s_no + ")";

	            // 이미지 요소 생성
	            var img = document.createElement('img');
	            img.src = "${pageContext.request.contextPath}/resources/images/" + product.image_dir; // 이미지 경로 설정
	            img.alt = 'product image';

	            // 제목 h3 요소 생성
	            var title = document.createElement('h3');
	            title.textContent = product.title; // 제목 설정

	            // 가격 p 요소 생성
	            var price = document.createElement('p');
	            price.textContent = product.price.trim(); // 가격 설정

	            // 조건에 따른 내용 표시 p 요소 생성
	            var description = document.createElement('p');

	            // JSON 데이터의 유무에 따른 조건 처리
	            if (product.area) {
	                // 지역 있을 때 표시할 내용
	                description.textContent = product.area + " | " + product.reg_date;
	            } else {
	                // 지역 없을 때 표시할 내용
	                description.textContent = product.reg_date;
	            }

	            // a 요소에 이미지와 텍스트 추가
	            link.appendChild(img);
	            link.appendChild(title);
	            link.appendChild(price);
	            link.appendChild(description);

	            // item div에 a 요소 추가
	            newItem.appendChild(link);

	            // product-list div에 item div 추가
	            var productList = document.getElementById('product-list');
	            productList.appendChild(newItem);
	        });
	    }
	</script>
</body>
</html>
