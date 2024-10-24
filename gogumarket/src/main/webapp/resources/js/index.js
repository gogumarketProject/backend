document.addEventListener("DOMContentLoaded", function () {
	window.onload = function() { //배너 스크립트 개 븅신되서 차선책
	    // 배너 슬라이더 스크립트
	    let currentBannerIndex = 0;
	    const banners = document.querySelectorAll('.banner-item');
	    const totalBanners = banners.length - 2;
	    const bannerContainer = document.getElementById('bannerContainer');
	    const indicators = document.querySelectorAll('.indicator');
	    const bannersInView = 3; // 한 번에 보이는 배너 수를 정의
	    const bannerWidth = banners[0].offsetWidth; // 각 배너의 너비 + 패딩
	    let autoSlide;
		
		
	    // 배너 위치 업데이트
	    function updateBannerPosition() {
	        const translateValue = currentBannerIndex * bannerWidth; // 이동 거리 계산
	        bannerContainer.style.transform = `translateX(-${translateValue}px)`; // 픽셀 단위로 배너 이동
	        updateIndicators();
	    }
		
	    // 인디케이터 업데이트
	    function updateIndicators() {
	        indicators.forEach((indicator, index) => {
	            indicator.classList.toggle('active', index === currentBannerIndex);
	        });
	    }
	
	    function nextBanner() {
	        // 다음 배너로 한 장씩 이동
	        currentBannerIndex++;
	        if (currentBannerIndex >= totalBanners) { // 마지막 배너를 넘어가면 처음으로 돌아가기
	            currentBannerIndex = 0;
	        }
	        updateBannerPosition();
	        resetAutoSlide();
	    }
	
	    function prevBanner() {
	        // 이전 배너로 한 장씩 이동
	        currentBannerIndex--;
	        if (currentBannerIndex < 0) { // 처음을 넘어가면 마지막으로 돌아가기
	            currentBannerIndex = totalBanners - 1;
	        }
	        updateBannerPosition();
	        resetAutoSlide();
	    }
	    
	    function jumpToBanner(index) {
	        // 인디케이터 클릭 시 해당 배너로 이동
	        currentBannerIndex = index;
	        updateBannerPosition();
	        resetAutoSlide();
	    }
	
	    function startAutoSlide() {
	        autoSlide = setInterval(nextBanner, 5000); // 5초마다 자동 전환
	    }
	
	    function resetAutoSlide() {
	        clearInterval(autoSlide);
	        startAutoSlide();
	    }
	
	    // 페이지 로드 시 자동 슬라이드 시작 및 인디케이터 초기화
	    startAutoSlide();
	    updateIndicators();
	
	    // 배너 인디케이터 클릭 이벤트 추가
	    indicators.forEach((indicator, index) => {
	        indicator.addEventListener('click', function () {
	            jumpToBanner(index);
	        });
	    });
	    
	    // 전역에 함수 할당
	    window.nextBanner = nextBanner;
	    window.prevBanner = prevBanner;
   	};

    // 실시간 인기 상품 슬라이드 스크립트
    let currentIndexPopular = 0;
    let currentIndex = 0;
    let currentIndexRecommended = 0;

    // 인기 상품 왼쪽
    window.slideLeftPopular = function () {
        const popularItemContainer = document.getElementById('popularItemContainer');
        const itemWidth = document.querySelector('.item').offsetWidth + 20;
        if (currentIndexPopular > 0) {
            currentIndexPopular -= 5;
            if (currentIndexPopular < 0) currentIndexPopular = 0;
        }
        popularItemContainer.style.transform = `translateX(-${currentIndexPopular * itemWidth}px)`;
    };

    // 인기 상품 오른쪽
    window.slideRightPopular = function () {
        const popularItemContainer = document.getElementById('popularItemContainer');
        const itemWidth = document.querySelector('.item').offsetWidth + 20;
        const totalItems = document.querySelectorAll('#popularItemContainer .item').length;
        const itemsInView = 5;
        if (currentIndexPopular < totalItems - itemsInView) {
            currentIndexPopular += 5;
            if (currentIndexPopular > totalItems - itemsInView) currentIndexPopular = totalItems - itemsInView;
        }
        popularItemContainer.style.transform = `translateX(-${currentIndexPopular * itemWidth}px)`;
    };

    // 방금 등록된 상품 왼쪽
    window.slideLeft = function () {
        const itemContainer = document.getElementById('itemContainer');
        const itemWidth = document.querySelector('.item').offsetWidth + 20;
        if (currentIndex > 0) {
            currentIndex -= 5;
            if (currentIndex < 0) currentIndex = 0;
        }
        itemContainer.style.transform = `translateX(-${currentIndex * itemWidth}px)`;
    };

    // 방금 등록된 상품 오른쪽
    window.slideRight = function () {
        const itemContainer = document.getElementById('itemContainer');
        const itemWidth = document.querySelector('.item').offsetWidth + 20;
        const totalItems = document.querySelectorAll('#itemContainer .item').length;
        const itemsInView = 5;
        if (currentIndex < totalItems - itemsInView) {
            currentIndex += 5;
            if (currentIndex > totalItems - itemsInView) currentIndex = totalItems - itemsInView;
        }
        itemContainer.style.transform = `translateX(-${currentIndex * itemWidth}px)`;
    };

    // 추천 상품 왼쪽
    window.slideLeftRecommended = function () {
        const recommendedItemContainer = document.getElementById('recommendedItemContainer');
        const itemWidth = document.querySelector('.item').offsetWidth + 20;
        if (currentIndexRecommended > 0) {
            currentIndexRecommended -= 5;
            if (currentIndexRecommended < 0) currentIndexRecommended = 0;
        }
        recommendedItemContainer.style.transform = `translateX(-${currentIndexRecommended * itemWidth}px)`;
    };

    // 추천 상품 오른쪽
    window.slideRightRecommended = function () {
        const recommendedItemContainer = document.getElementById('recommendedItemContainer');
        const itemWidth = document.querySelector('.item').offsetWidth + 20;
        const totalItems = document.querySelectorAll('#recommendedItemContainer .item').length;
        const itemsInView = 5;
        if (currentIndexRecommended < totalItems - itemsInView) {
            currentIndexRecommended += 5;
            if (currentIndexRecommended > totalItems - itemsInView) currentIndexRecommended = totalItems - itemsInView;
        }
        recommendedItemContainer.style.transform = `translateX(-${currentIndexRecommended * itemWidth}px)`;
    };
});
