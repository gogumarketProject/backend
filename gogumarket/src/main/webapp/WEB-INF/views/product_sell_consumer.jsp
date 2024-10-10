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
	/* 찜 추가, 제거 펑션 */ 
	function OnLikes(){
		$.ajax({
  			type:"post",
  			url :"OnLikes",
  			data:"s_no="+like.s_no.value+"&id="+like.id.value,
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
				<img src="이미지경로" alt="상품 이미지">
			</div>
			<!-- 우측: 판매 정보 div -->
			<div class="info-box">
				<div class="info-box-category">홈 > ${dto.getCategory_id() }</div>
				<div class="info-box-product-name">${dto.getTitle() }</div>
				<div class="info-box-price"><strong>${dto.getPrice() }</strong></div>
				<div class="info-box-product-meta">${dto.getReg_date() } | 채팅 0 | 찜 ${dto.getLikes() }</div>
				<!-- 한 줄로 나란히 배치된 li -->
				<ul class="li-details">
					<li class="li-line"><span>제품상태</span><button>${dto.getProduct_status() }</button></li>
					<li class="li-line"><span>거래방식</span><button>${dto.getTrade() }</button></li>
					<li class="li-line"><span>배송비</span><button>-</button></li>
					<li class="li-line"><span>거래제안</span><button>가능</button></li>
				</ul>
				<div class="trade">
					<div class="trade-location">・거래희망지역</div>
					<div><button class="trade-location-btn">${dto.getArea() }</button></div>
				</div>
				
				<!-- ajax 임시 form -->
				<form name = "like">
					<input type = "hidden" name = "s_no" value = "1"> 
					<input type = "hidden" name = "id" value = "test">
				</form>
				
				<div class="action-buttons">
					<label class="wishlist">
					<!-- 찜 버튼, like 1이면 활성화, 0이면 비활성화-->
						<input type="checkbox" style="display: none;" onclick = "OnLikes()" <c:if test="${like eq '1'}">checked</c:if>>
						<i class="fa-regular fa-heart"></i>
					</label>
					<button class="send-msg" onclick="alert('쪽지보내기 버튼 클릭됨')">쪽지보내기</button>
					<button class="trade-offer" onclick="togglePriceBox()">가격제안</button>
				</div>
				<div class="trade-offer-price-box" style="visibility: hidden;">
					<div style="width:25px;"></div>
					<input type="text" class="trade-offer-price" placeholder=" 제안할 금액을 입력하세요.">
					<button class="trade-offer-price-submit">제안하기</button>
				</div>


			</div>
		</div>


		<!-- 2번째 섹션 div -->
		<div class="section2">
			<div class="section2-title">새 상품은 어떠세요?</div>
			<ul class="recommended-products">
				<li>
					<img src="이미지경로" alt="상품 이미지">
					<div class="recommend-products-content">
						<a href="#">엘디 엘마운트 슬라이딩 책상 키보드 트레이 APL-KT52 1개 엘디 엘마운트 슬라이딩 책상 키보드 트레이</a>
						<div class="recommend-price"><strong>36,700원</strong></div>
						<div class="recommend-advertisy"><span>쿠팡 | 광고</span></div>
					</div>
				</li>
				<li>
					<img src="이미지경로" alt="상품 이미지">
					<div class="recommend-products-content">
						<a href="#">헬시위드 탈부착 레일형 슬라이딩 키보드 트레이 월넛(상부) + 화이트(하부) 1개</a>
						<div class="recommend-price"><strong>35,000원</strong></div>
						<div class="recommend-advertisy"><span>쿠팡 | 광고</span></div>
					</div>
				</li>
				<li>
					<img src="이미지경로" alt="상품 이미지">
					<div class="recommend-products-content">
						<a href="#">헬시위드 탈부착 레일형 슬라이딩 키보드 트레이 월넛(상부) + 화이트(하부) 1개</a>
						<div class="recommend-price"><strong>35,000원</strong></div>
						<div class="recommend-advertisy"><span>쿠팡 | 광고</span></div>
					</div>
				</li>
			</ul>
		</div>


		<!-- 3번째 섹션 div -->
		<div class="section3">
			<!-- 좌측 큰 div -->
			<div class="left-box">
				<h3 class="left-box-header">상품 정보</h3>
				<p class="left-box-text">[반값이하, 특가] ${dto.getTitle() }<br><br>
					${dto.getContents() }
				</p>
				<div class="location-info">
					<p>거래희망지역</p>
					<button>${dto.getArea() }</button>
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
							${dto.getS_id() }
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
