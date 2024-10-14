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
  				/* var result = $.trim(data);
  				  
  				/* all.t_id_result.value = result;
  				if(result == "사용가능"){
  					all.t_id_checkValue.value = all.t_id.value;
  				}else{
  					all.t_id_checkValue.value = "";
  				} */  
  			}
  		});
		
	}
	
</script>
<body>

	<%@include file="header.jsp" %>
	<%@include file="menu_bar.jsp" %>
	<%@include file="message.jsp" %>
	
	<div class="container">
		<!-- 1번째 섹션 div -->
		<div class="section1">
			<!-- 좌측: 사진 div -->
			<div class="image-box">
				<img src="${pageContext.request.contextPath}/resources/images/${productdto.getImage_dir() }" alt="product image">
			</div>
			<!-- 우측: 판매 정보 div -->
			<div class="info-box">
				<div style="display: flex; justify-content: space-between;align-items: center;">
					<div class="info-box-category">홈 > ${productdto.getCategory_name() }</div>
					<div style="margin-right: 14px;">
						<c:if test="${id eq productdto.getS_id() }">
							<select style=" width:70px; height: 24px;border-radius: 5px;">
								<option>판매중</option>
								<option>예약중</option>
								<option>판매완료</option>
							</select>
						</c:if>
					</div>
				</div>
				<div class="info-box-product-name">${productdto.getTitle() }</div>
				<div class="info-box-price"><strong>${productdto.getPrice() }원</strong></div>
				<div class="info-box-product-meta">${productdto.getReg_date() } | 채팅 0 | 찜 ${productdto.getLikes() }</div>
				<!-- 한 줄로 나란히 배치된 li -->
				<ul class="li-details">
					<li class="li-line"><span>제품상태</span><button>${productdto.getProduct_status() }</button></li>
					<li class="li-line"><span>거래방식</span><button>${productdto.getTrade() }</button></li>
					<li class="li-line"><span>거래제안</span><button>가능</button></li>
				</ul>
				<c:if test="${productdto.getTrade() eq '직거래' or productdto.getTrade() eq '직거래 | 택배'}">
				<div class="trade">
					<div class="trade-location">・거래희망지역</div>
						<div><button class="trade-location-btn">${productdto.getArea() }</button></div>
					</div>
				</c:if>
				<!-- 가격제안 -->
			<c:if test="${id eq productdto.getS_id() }">	
				<div class="trade-seller-container">
	               <p class="trade-seller-line">가격제안</p>
	               <div class="trade-overflow">
	                  <div class="trade-seller">
	                     <div class="trade-seller-left">
	                        <p>가렌</p>
	                        <p class="trade-counterparty-location">중화제2동</p>
	                     </div>
	                     <div class="trade-seller-right">
	                        <span class="seller-price"><strong>9500원</strong></span>
	                        <label class="trade-seller-msg">
	                           <button><i class="fa-regular fa-envelope"></i></button>
	                        </label>
	                        <button class="trade-btn">수락</button>
	                        <button class="trade-btn">거절</button>
	                     </div>
	                  </div>
	                  <div class="trade-seller">
	                     <div class="trade-seller-left">
	                        <p>다리우스</p>
	                        <p class="trade-counterparty-location">중화짜장동</p>
	                     </div>
	                     <div class="trade-seller-right">
	                        <span class="seller-price"><strong>9300원</strong></span>
	                        <label class="trade-seller-msg">
	                           <button><i class="fa-regular fa-envelope"></i></button>
	                        </label>
	                        <button class="trade-btn">수락</button>
	                        <button class="trade-btn">거절</button>
	                     </div>
	                  </div>
	                  <div class="trade-seller">
	                     <div class="trade-seller-left">
	                        <p>신짜오</p>
	                        <p class="trade-counterparty-location">중화짬뽕</p>
	                     </div>
	                     <div class="trade-seller-right">
	                        <span class="seller-price"><strong>999999원</strong></span>
	                        <label class="trade-seller-msg">
	                           <button><i class="fa-regular fa-envelope"></i></button>
	                        </label>
	                        <button class="trade-btn">수락</button>
	                        <button class="trade-btn">거절</button>
	                     </div>
	                  </div>
	                  <div class="trade-seller">
	                     <div class="trade-seller-left">
	                        <p>신짜오</p>
	                        <p class="trade-counterparty-location">중화짬뽕</p>
	                     </div>
	                     <div class="trade-seller-right">
	                        <span class="seller-price"><strong>999999원</strong></span>
	                        <label class="trade-seller-msg">
	                           <button><i class="fa-regular fa-envelope"></i></button>
	                        </label>
	                        <button class="trade-btn">수락</button>
	                        <button class="trade-btn">거절</button>
	                     </div>
	                  </div>
	               </div>
	            </div>
			</c:if>	
				<!-- ajax 임시 form -->
				<form name = "like">
					<input type = "hidden" name = "s_no" value = "${productdto.getS_no() }"> 
				</form>
			<c:if test="${id != productdto.getS_id() }">		
				<div class="action-buttons">
					<label class="wishlist">
					<!-- 찜 버튼, like 1이면 활성화, 0이면 비활성화, 로그인 안되어있으면 alert후 로그인창-->
						<input type="checkbox" style= "display: none;" 
						onclick="if (${sessionId == null}) { alert('로그인 후 이용해주세요.'); goLogin(); } 
						else { OnLikes(); }" <c:if test="${CheckUserlike eq '1'}">checked</c:if>>
						<i class="fa-regular fa-heart"></i>
					</label>
					<button class="send-msg" onclick="alert('쪽지보내기 버튼 클릭됨')">쪽지보내기</button>
					<!-- sessionId가 null이면 alert후 로그인창, 아니면 가격제안 나오게 -->
					<button class="trade-offer" 
					onclick="if(${sessionId == null}) {alert('로그인 후 이용해주세요.'); goLogin();}
						else { togglePriceBox();}">
						<!-- "togglePriceBox()"> -->가격제안</button>
				</div>
				<div class="trade-offer-price-box" style="visibility: hidden;">
					<div style="width:25px;"></div>
					<input type="text" class="trade-offer-price" placeholder=" 제안할 금액을 입력하세요.">
					<button class="trade-offer-price-submit">제안하기</button>
				</div>
			</c:if>

			</div>
		</div>


		<!-- 2번째 섹션 div -->
		<div class="section2">
			<div class="section2-title">현재 인기 상품이에요!</div>
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
		
		
		<!-- 업데이트 전용 Form -->
		<form name = "update">
			<input type = "hidden" name = "s_no">
			<input type = "hidden" name = "t_gubun">  
		</form>
		
		<!-- 3번째 섹션 div -->
		<div class="section3">
			<!-- 좌측 큰 div -->
			<div class="left-box">
				<h3 class="left-box-header">상품 정보
				<!-- 작성자만 보이는 수정 삭제 -->
					<c:if test="${id eq productdto.getS_id() }">	
						<div class="left-box-setting-box"> 
							<c:if test="${productdto.getStatus() !=  '예약완료'}">
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
				<p class="left-box-text">${productdto.getContents() }</p>
				<div class="location-info">
					<c:if test="${productdto.getTrade() eq '직거래' or productdto.getTrade() eq '직거래 | 택배'}">
						<p>거래희망지역</p>
						<button>${productdto.getArea() }</button>
					</c:if>	
				</div>
			</div>
			<!-- 우측 큰 div -->
			<div class="right-box">
				<a href="#">
					<h3 class="right-box-header">
						가게 정보
						<i class="fa-solid fa-chevron-right"></i>
					</h3>
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
				<div class="product-list">
					<div class="small-box">
						<div class="small-box-product-img"><img src="이미지경로" alt="상품 이미지"></div>
						<div class="small-box-content">
							<h2>슬라이딩 키보드 트레이</h2>
							<div class="small-box-price">10,000원</div>
						</div>
					</div>
					<div class="small-box">
						<div class="small-box-product-img"><img src="이미지경로" alt="상품 이미지"></div>
						<div class="small-box-content">
							<h2>mx keys mac 반값 2개</h2>
							<div class="small-box-price">50,000원</div>
						</div>
					</div>
					<div class="small-box margin-padding-reset">
						<div class="small-box-product-img"><img src="이미지경로" alt="상품 이미지"></div>
						<div class="small-box-content">
							<h2>아이패드 10세대 + 애플 펜슬 1세대 팝니다</h2>
							<div class="small-box-price">450,000원</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="footer.jsp" %>
	
</body>
	<script src="${pageContext.request.contextPath}/resources/js/product_sell.js"></script>
</html>
