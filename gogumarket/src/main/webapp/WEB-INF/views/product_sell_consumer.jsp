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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_sell.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script type="text/javascript">

	function goUpdate(no){
		update.s_no.value = no;
		update.t_gubun.value = "UpdateForm";
		update.method = "post";
		update.action = "market";
		update.submit();
	}
	
	function goDelete(no){
		if(confirm('삭제된 게시물은 복구할 수 없습니다. \n해당 게시물을 삭제하시겠습니까?')){
			update.s_no.value = no;
			update.t_gubun.value = "Delete";
			update.method = "post";
			update.action = "market";
			update.submit();
		}
	}
	/* 찜 추가, 제거 펑션 */ 
	function OnLikes(){
		$.ajax({
  			type:"post",
  			url :"OnLikes",
  			data:"s_no="+like.s_no.value,
  			dataType:"text",
  			error:function(){
  				alert("통신 실패!!!!");
  			},
  			success:function(data){
  				var result = $.trim(data);
  				alert(result);
  			}
  		});
		
	}
	//제안하기
	function goOffer(){
		var price = document.getElementById('priceInput').value;
		
		if(price == ""){
			alert("가격을 입력해주세요!");
			return;
		}
		if(confirm(price+"원을 제의하시겠습니까?")){
			
			// 쉼표 제거 후 값 설정
			var cleanPrice = price.replace(/,/g, '');
			offer.offerPrice.value = cleanPrice; 
			
			offer.t_gubun.value = "Offer";
			offer.method = "post";
			offer.action = "market";
			offer.submit();
		}
		// select 요소에 이벤트를 직접 추가하는 방식
	    
	}
	
	
	//status 바꾸는 js
	var previousStatus = "${productdto.getStatus()}";
	
	function confirmSelection(selectElement) {
		
	    const selectedValue = selectElement.value;
	    if (selectedValue == '판매중') {
	        if (!confirm("판매중 상태로 변경하시겠습니까?")) {
	            selectElement.value = previousStatus;  // 취소 시 이전 상태로 복구
	            return;
	        } else {
	            previousStatus = '판매중'; // 확인 시 상태를 업데이트
	        }
	    } else if (selectedValue == '예약중') {
	        if (!confirm("예약중 상태로 변경하시겠습니까?")) {
	            selectElement.value = previousStatus; // 취소 시 이전 상태로 복구
	            return;
	        } else {
	            previousStatus = '예약중'; // 확인 시 상태를 업데이트
	        }
	    } else if (selectedValue === '판매완료') {
	        if (!confirm("       판매완료 상태로 변경하시겠습니까?\r\n판매완료로 변경하실 경우에 거래제안 변경이 불가합니다!")) {
	            selectElement.value = previousStatus; // 취소 시 이전 상태로 복구
	            return;
	        } else {
	            previousStatus = '판매완료'; // 확인 시 상태를 업데이트
	        }
	    }
	    $.ajax({
  			type:"post",
  			url :"ChangeStatus",
  			data :"s_no="+statusform.s_no.value+"&status="+statusform.status.value,
  			/* data:"s_no="+status.s_no.value+"&status="+status.status.value, */
  			dataType:"text",
  			error:function(){
  				alert("통신 실패!!!!");
  			},
  			success:function(data){
  				var result = $.trim(data);
  				alert(result);
  				location.reload(true);
  			}
  		});
	    /* if(selectedValue === '판매완료'){
	    	 $(selectElement).parent().html('<span>판매완료</span>');
	    	 $(".fa-regular fa-pen-to-square").hide();	
	    } */
	}
</script>
<body>

	<%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>
	<%@include file="message_send.jsp" %>
	
	
	<div class="container">
		<!-- 1번째 섹션 div -->
		<div class="section1">
			<!-- 좌측: 사진 div -->
			<div class="image-box">
				<img src="${pageContext.request.contextPath}/resources/images/${productdto.getImage_dir() }" alt="product image">
			</div>
			<!-- 우측: 판매 정보 div -->
			<div class="info-box">
				<div class="info-box-category">홈 > ${productdto.getCategory_name() }</div>
				<div style="display: flex; justify-content: space-between;align-items: center;">
					<div class="info-box-product-name">${productdto.getTitle() }</div>
					
					<div style="margin-right: 14px;">
					<form name = "statusform">
					<input type = "hidden" name = "s_no" value = "${productdto.getS_no() }">
						<c:if test="${id eq productdto.getS_id() && (productdto.getStatus() eq '판매중'||productdto.getStatus() eq '예약중')}">
							<select name = "status" style=" width:80px; height: 24px;border-radius: 5px;" onchange="confirmSelection(this)" >
								<option value = "판매중" <c:if test="${productdto.getStatus() eq '판매중' }">selected</c:if>>판매중</option> 
								<option value = "예약중" <c:if test="${productdto.getStatus() eq '예약중' }">selected</c:if>>예약중</option>
								<option value = "판매완료" <c:if test="${productdto.getStatus() eq '판매완료' }">selected</c:if>>판매완료</option>
							</select>
						</c:if>
					</form>	
					</div>
					
				</div>
				<div class="info-box-price"><strong>${productdto.getPrice() }원</strong></div>
				<div class="info-box-product-meta">${productdto.getReg_date() } | 채팅 0 | 찜 ${productdto.getLikes() }</div>
				<!-- 한 줄로 나란히 배치된 li -->
				<ul class="li-details">
					<li class="li-line"><span>제품상태</span><button>${productdto.getProduct_status() }</button></li>
					<li class="li-line"><span>거래방식</span><button>${productdto.getTrade() }</button></li>
					<li class="li-line"><span>거래제안</span><button>${productdto.getStatus() }</button></li>
				</ul>
				<c:if test="${productdto.getTrade() eq '직거래' or productdto.getTrade() eq '직거래 | 택배'}">
				<div class="trade">
					<div class="trade-location">・거래희망지역</div>
						<div><button class="trade-location-btn">${productdto.getArea() }</button></div>
					</div>
				</c:if>
				<!-- 찜 ajax form -->
				<form name = "like">
					<input type = "hidden" name = "s_no" value = "${productdto.getS_no() }"> 
				</form>
				<div class="action-buttons">
				<c:if test="${id != productdto.getS_id() }">
	               <label class="wishlist">
	               <!-- 찜 버튼, like 1이면 활성화, 0이면 비활성화-->
	                  <input type="checkbox" style="display: none;" onclick="if (${sessionId == null}) { alert('로그인 후 이용해주세요.'); goLogin(); } 
							else { OnLikes(); }" <c:if test="${CheckUserlike eq '1'}">checked</c:if>>
	                  <i class="fa-regular fa-heart"></i>
	               </label>
	               
	               <!-- 가격제안 form-->
					<form name = "offer">
						<input type = "hidden" name = "s_no" value = "${productdto.getS_no() }">
						<input type = "hidden" name = "t_gubun">
						<!-- 가격 text에 id를 지정해준후 jas에서 offerPrice에 값 옮겨주기 -->
						<input type = "hidden" name ="offerPrice" id = "offerPrice">  
					</form>
	               <c:if test="${productdto.getStatus() eq '판매중' }">
		               <div class="trade-offer-container ">
		                  <button class="trade-offer absolute" onclick="togglePriceBox()">가격제안</button>
		                  <div class="trade-offer-hidden">
		                     <input type="text" id="priceInput" class="trade-offer-price absolute" placeholder=" 제안할 금액을 입력하세요." oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');">
		                     <button class="trade-offer-price-submit absolute" onclick="if(${sessionId == null}) {alert('로그인 후 이용해주세요.'); goLogin();}
								else { goOffer();}">>제안하기</button>
		                  </div>
		               </div>
	               </c:if>
               </c:if>
            </div>
					
				
			</div>
		</div>


		
		<!-- 상품 정보 -->
		<!-- 업데이트 전용 Form -->
		<form name = "update">
			<input type = "hidden" name = "s_no">
			<input type = "hidden" name = "t_gubun">  
		</form>
		<!-- 3번째 섹션 div -->
		<div class="section3">
			<!-- 좌측 큰 div -->
			<div class="left-box">
				<h3 class="left-box-header">
						상품 정보
					<c:if test="${id eq productdto.getS_id() }">
						<div class="left-box-setting-box">
							<c:if test="${productdto.getStatus() !=  '판매완료'}">
								<a href="javascript:goUpdate('${productdto.getS_no() }')">
									수정<i class="fa-regular fa-pen-to-square"></i>
								</a>
							</c:if>	
							<a href="javascript:goDelete('${productdto.getS_no() }')">
								삭제<i class="fa-regular fa-trash-can"></i>
							</a>
						</div>
					</c:if>	
				</h3>
				<div class="left-box-relative" >
					<p class="left-box-text"  id="leftBoxText">${productdto.getContents() }</p>
					<div class="location-info">
						<c:if test="${productdto.getTrade() eq '직거래' or productdto.getTrade() eq '직거래 | 택배'}">
							<p>거래희망지역</p>
							<button>${productdto.getArea() }</button>
						</c:if>	
						<button class="more" id="toggleButton">더보기</button>
					</div>
				</div>
			</div>
			<!-- 우측 큰 div -->
			<!-- 가격제안 판매자 입장에서만 보임 -->
			<c:if test="${id eq productdto.getS_id() }">	
			<div class="right-box">
				<a href="#">
					<h3 class="right-box-header">
						가격제안
					</h3>
				</a>
				<div class="trade-seller-container">
					<div class="trade-overflow">
						<c:forEach items="${OfferDtos}" var="OfferDtos">
							<div class="trade-seller">
								<div class="trade-seller-left">
									<p>${OfferDtos.getS_id() }</p>
									<p class="trade-counterparty-location">중화짬뽕</p>
								</div>
								<div class="trade-seller-right">
									<span class="seller-price"><strong>${OfferDtos.getPrice() }원</strong></span>
								</div>
								<button class="trade-options"><i class="fa-solid fa-comments"></i></button>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			</c:if>
			<c:if test="${id != productdto.getS_id() }">
				<div class="right-box">
					<a href="#">
						<h3 class="right-box-header">판매자 정보</h3>
					</a>
					<div class="right-box-trade">
						<a href="#">
							<p class="counterparty">
								${productdto.getS_id() }
								<i class="fa-solid fa-circle-user"></i>
							</p>
						</a>
					</div>
					<div class="counterparty-trust">
						<p>신뢰지수</p>
						<span>401</span>
					</div>
					<ul class="li-details counterparty-data">
						<li class="li-line"><span>안전거래</span><button>0</button></li>
						<li class="li-line"><span>거래후기</span><button>2</button></li>
						<li class="li-line"><span>단골</span><button>0</button></li>
					</ul>
				</div>
			</c:if>
		</div>
		
		
		
		<div class="section2">
			<div class="section2-title">새 상품은 어떠세요?</div>
			<ul class="recommended-products">
				<c:forEach items="${likesDtos}" var="likesDtos">
				<li>
					<a href=javascript:goConsumer('${likesDtos.getS_no() }')><img src="${pageContext.request.contextPath}/resources/images/${likesDtos.getImage_dir() }" alt="product image"></a> <!-- 사진 -->
					<div class="recommend-products-content">
						<a href=javascript:goConsumer('${likesDtos.getS_no() }')>${likesDtos.getTitle() }</a> <!-- 제목 누르면 a태그 -->
						<div class="recommend-price"><strong>${likesDtos.getPrice() }</strong></div> <!-- 가격칸 -->
						<div class="recommend-advertisy"><span>${likesDtos.getReg_date() } | <!-- 날짜 | 지역 -->
						<c:choose>
							<c:when test="${not empty likesDtos.getArea() }">${likesDtos.getArea() }</c:when>
							<c:when test="${empty likesDtos.getArea() }">택배</c:when>
						</c:choose>
					</div>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<%@include file="footer.jsp" %>
	
	<script src="${pageContext.request.contextPath}/resources/js/product_sell.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/message.js"></script>
</body>
</html>
