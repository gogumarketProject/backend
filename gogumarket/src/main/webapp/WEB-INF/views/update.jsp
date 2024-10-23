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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write_form.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
	<script type="text/javascript">
  	  	var tradeType = "${productdto.getTrade()}"; // JSP에서 JSTL 값을 JavaScript 변수에 전달
  	  	var NowArea = "${productdto.getArea()}";
  	  	
  	  function goupdate() {
  		
  	    if (update.title.value == "") {
  	        alert("상품명을 기재해 주세요.");
  	        update.title.focus();
  	        return;
  	    }
  	    
  	  if (update.price.value == "") {
	        alert("가격을 기재해 주세요.");
	        update.price.focus();
	        return;
	    }
  	    
  	    const productDetails = document.getElementById('product-details');
  	    if (productDetails.value.length < 3) {
  	        alert("상세 정보를 3자 이상 입력해 주세요.");
  	        productDetails.focus();
  	        return;
  	    }
  	   
  	    const productState = document.querySelector('input[type="radio"]:checked');
  	    if (!productState) {
  	        alert("상품 상태를 선택해 주세요.");
  	        return;
  	    }
  	   
  	    const deliveryMethod = document.querySelector('input[type="checkbox"]:checked');
  	    if (!deliveryMethod) {
  	        alert("거래 방법을 선택해 주세요.");
  	        return;
  	    }
  	    
  	    const meetCheckbox = update.meet.value;
  	    const meetLocation = document.getElementById('meetLocation');
  	    if (meetCheckbox.checked) {
  	        if (!meetLocation.value) {
  	            alert("직거래 위치를 입력해 주세요.");
  	            meetLocation.focus();
  	            return;
  	        }
  	    }
  	    if (!update.meet.checked && update.areaname.value) {
  	        alert("동네 설정은 직거래만 가능합니다.");
  	        return;
  	    }
  	    if (update.meet.checked && update.areaname.value == '') {
  	        alert("동네를 설정해주세요.");
  	        return;
  	    }
  	  	
  	    update.method = "post";
  	    update.action = "market?t_gubun=update";
  	    update.submit(); 
  	}

  	
  	function checkEnter(){
    		var keyValue = event.keyCode;
    		if(keyValue == 13){
    			event.preventDefault();
    			focus();
    		}
    	}
  	  	
	</script>	
</head>
<body>
    <%@include file="header.jsp" %>
    <%@include file="menu_bar.jsp" %>
    <%@include file="message.jsp" %>

<main>
    <input type="hidden" name="t_gubun">
    <div class="container">
        <form name="update">
        	<input type="hidden" name="s_no" value = "${productdto.getS_no() }">
            <input type="hidden" name="image" value = "${productdto.getImage_dir() }">
            <!-- 이미지 업로드 박스와 미리 보기 컨테이너를 묶음 -->
            <div class="upload-preview-container">
                
                <!-- 이미지 미리 보기 영역 -->
                <div class="preview-container"></div>
                <img src="${pageContext.request.contextPath}/resources/images/${productdto.getImage_dir() }" alt="product image" style = "width : 400px; height:400px;">
            </div>

            <!-- 상품명 입력 -->
            <div class="input-box">
                <input type="text" name="title" id="product-name" placeholder="상품명" onkeypress="checkEnter()" value = "${productdto.getTitle()}" >
            </div>
            
            <!-- 선택한 카테고리 출력 -->
            <div class="input-box selected-category-display">
                <div id="selected-category-display"></div>
                <!-- 선택한 카테고리를 숨겨진 input 필드로 저장 -->
                 <input type="hidden" name="category_id" id="selected-categories" value = "${productdto.getCategory_id() }">
            </div>

            <!-- 카테고리 선택 -->
            <div class="category-container">
                <div class="category-box" data-value="1">카테고리 : ${productdto.getCategory_name() }</div>
            </div>
            
            <div class="price-box">
                <input type="text" name="price" id="product-price" placeholder="판매가격" oninput="this.value = this.value.replace(/[^0-9]/g, '')" onkeypress="checkEnter()" value = "${productdto.getPrice() }">
            </div>

            <!-- 상세 정보 입력 -->
            <div class="input-box">
                <textarea class="detail-box" name="contents" id="product-details"  placeholder="
    -상품명(브랜드)
    -구매 시기
    -오염 여부
    -하자 여부
    *실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
                " >${productdto.getContents() }</textarea>
            </div>

            <!-- 상품 상태 선택 -->
            <div class="check-con-box">
            	<span class="check-title">상품상태</span>
	            	<div class="radio-container">
		                <input type="radio" name="product_status" id="option1" value="1"
		                <c:if test="${productdto.getProduct_status() eq '중고' }">checked</c:if>>
		                <label for="option1" class="radio-box">중고</label>
		                
		                <input type="radio" name="product_status" id="option2" value="2"
		                <c:if test="${productdto.getProduct_status() eq '새 상품' }">checked</c:if>>
		                <label for="option2" class="radio-box">새상품</label>
	            	</div>
            </div>

            <!-- 거래 방법 선택 -->
            <div class="check-con-box bottom-line">
            	<span class="check-title">거래방법</span>
            	<div  class="checkbox-container">
	                <input type="checkbox" name="delivery" id="delivery" value="1"
	                <c:if test="${productdto.getTrade() eq '택배거래' || productdto.getTrade() eq '직거래 | 택배'}">checked</c:if>>
		                <label for="delivery" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
		                <span class="label-text">택배</span>
	                
	                <input type="checkbox" name="meet" id="meet" value="2"
	                <c:if test="${productdto.getTrade() eq '직거래' || productdto.getTrade() eq '직거래 | 택배'}">checked</c:if>>
		                <label for="meet" class="round-checkbox"><i class="fa-solid fa-check"></i></label>
		                <span class="label-text">직거래</span>
                </div>
                
            </div>
			<div>
				<div id="meetLocationContainer" style="display: none;">
					<span class="meetLocation-title">희망 지역 - 현재지역
					<span style="color: #878686;"><i class="fa-solid fa-location-dot"></i></span>
		            <span style="color: #878686; margin:0 6px 0 5px;" id = "Area">${productdto.getArea()}</span>
		            <span id="nowLocation" style="color: #878686; cursor: pointer;"><i class="fa-solid fa-xmark"></i></span>
					<input type = "hidden" name = "areaname" value = "${productdto.getArea()}">
					</span>
					<div style="display: flex; align-items: center;">
						<div class="meetLocation-add-box-con">
		                    <input type="text" id="meetLocation" placeholder="직거래 위치 입력 ">
		                    <button id="locationConfirmButton">추가</button>
	                    </div>
	                   
	                    <!-- 입력된 위치가 여기에 출력됩니다 -->
                    </div>
                </div>
			</div>
            <!-- 체크박스 아래에 "등록" 박스 추가 -->
            <div class="register-box" onclick="goupdate()">
                등록
            </div>
            <div class="advertising-container">
            	<img src="${pageContext.request.contextPath}/resources/images/ad/advertising-image4.png" alt="ad">
            </div>
        </form>
    </div>
</main>

<%@include file="footer.jsp" %>

<script src="${pageContext.request.contextPath}/resources/js/update.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
