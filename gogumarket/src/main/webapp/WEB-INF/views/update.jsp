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
	function goupdate() {
		
	    const productName = document.getElementById('product-name');
	    if (!productName.value) {
	        alert("상품명을 기재해 주세요.");
	        productName.focus();
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
	
	function InsertArea() {
	    //빈칸이면 alert
	    if(update.town.value == "") {
	    	alert("직거래 위치를 입력하세요.");
	    	return;
	    }
	 // trade라는 이름의 폼에서 areaname과 town의 값을 연결
	    update.areaname.value = update.town.value; 
	    
	    document.getElementsByName('delarea')[0].style.display = 'inline-block'; //삭제버튼까지 보이게
	}
	function DelArea(){
		update.areaname.value = "";
		document.getElementsByName('delarea')[0].style.display = 'none'; //삭제버튼까지 사라지게
	}
	</script>
</head>
<body>
    <%@include file="header.jsp" %>
    <%@include file="menu_bar.jsp" %>
    <%@include file="message.jsp" %>
<main>
    <div class="container">
        <form name="update">
            
           	<!-- 꾸미기 다시해야댕 -->
           	<input type="hidden" name="s_no" value = "${productdto.getS_no() }">
            <input type="hidden" name="image" value = "${productdto.getImage_dir() }">
            <div class="image-box">
				<img src="${pageContext.request.contextPath}/resources/images/${productdto.getImage_dir() }" alt="product image" style = "width : 400px; height:400px;">
			</div>    

            <!-- 상품명 입력 -->
            <div class="input-box">
                <input type="text" name="title" id="product-name" placeholder="상품명" onkeypress="checkEnter()" value = "${productdto.getTitle()}" >
            </div>
            
            <!-- 선택한 카테고리 출력 -->
            <div class="input-box selected-category-display">
                <div id="selected-category-display"></div>
                <!-- 선택한 카테고리를 숨겨진 input 필드로 저장 (date-value 값이 들어옴 / 삭제하면 value=''로 변경)-->
                <input type="hidden" name="category_id" id="selected-categories" value = "${productdto.getCategory_id() }">
            </div>

            <!-- 카테고리 선택 -->
            <div class="category-container">
                <div class="category-box" data-value="1">패션의류</div>
                <div class="category-box" data-value="2">패션잡화</div>
                <div class="category-box" data-value="3">가방/핸드백</div>
                <div class="category-box" data-value="4">시계/쥬얼리</div>
                <div class="category-box" data-value="5">가전제품</div>
                <div class="category-box" data-value="6">모바일/태블릿</div>
                <div class="category-box" data-value="7">노트북/PC</div>
                <div class="category-box" data-value="8">게임</div>
                <div class="category-box" data-value="9">가구/인테리어</div>
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
            <div class="radio-container">
                <input type="radio" name="product_status" id="option1" value="1"
                <c:if test="${productdto.getProduct_status() eq '중고' }">checked</c:if>>
                <label for="option1" class="radio-box">중고</label>
                
                <input type="radio" name="product_status" id="option2" value="2"
                <c:if test="${productdto.getProduct_status() eq '새 상품' }">checked</c:if>>
                <label for="option2" class="radio-box">새상품</label>
            </div>
            <!-- 거래 방법 선택 -->
            <div class="checkbox-container">
                <input type="checkbox" name="delivery" id="delivery" value="1"
                 <c:if test="${productdto.getTrade() eq '택배거래' || productdto.getTrade() eq '직거래 | 택배'}">checked</c:if>>
                <label for="delivery" class="round-checkbox"></label>
                <span class="label-text">택배</span>
                
                <input type="checkbox" name="meet" id="meet" value="2"
                 <c:if test="${productdto.getTrade() eq '직거래' || productdto.getTrade() eq '직거래 | 택배'}">checked</c:if>>
                <label for="meet" class="round-checkbox"></label>
                <span class="label-text">직거래</span>
                
                <!-- 직거래 위치 입력 -->
				 <div id="meetLocationContainer" style="margin-left: 15px;">
			        <input type="text" name="town" placeholder="직거래 위치 ex) 둔산동" style="padding: 5px; border: 1px solid #ddd; border-radius: 4px;">
			        <button type="button" style="width: 30px; border: 1px solid #ddd; height: 100%;" onclick="InsertArea()">확인</button>
			    </div>
			
			    <!-- 직거래 위치가 출력되는 부분 -->
			    <input type="text" name="areaname" value="${productdto.getArea() }" style="height:30px; width:40px; background-color: transparent; border:none" readonly>&nbsp;&nbsp;
			    <input type="button" name="delarea" value="삭제" style="width: 30px; border: 1px solid #ddd; height: 100%;" onclick="DelArea()">
            </div>
            <!-- 체크박스 아래에 "등록" 박스 추가 -->
            <div class="register-box" onclick="goupdate()">
             	   등록
            </div>
        </form>
    </div>
</main>

<%@include file="footer.jsp" %>

<script src="${pageContext.request.contextPath}/resources/js/write.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
