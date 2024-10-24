<%@ page pageEncoding="UTF-8"%>
<nav class="menu-bar">
<script>
	function goCategorySearch(category, category_id) {
		categorySearch.category.value = category;
		categorySearch.category_id.value = category_id;
		
		categorySearch.method = "post";
		categorySearch.action = "market";
		categorySearch.submit();
	}
</script>
<form name="categorySearch">
	<input type="hidden" name="category">
	<input type="hidden" name="category_id">
	<input type="hidden" name="t_gubun" value="search">
</form>
    <div class="menu-container">
        <div class="menu-item">
            <a href="#" class="category"><i class="fa-solid fa-bars" style="margin-right:10px;"></i>카테고리</a>
            <!-- 서브메뉴 -->
            <div class="sub-menu">
                <a href="javascript:goCategorySearch('패션의류', '1')">패션의류</a>
                <a href="javascript:goCategorySearch('패션잡화', '2')">패션잡화</a>
                <a href="javascript:goCategorySearch('가방/핸드백', '3')">가방/핸드백</a>
                <a href="javascript:goCategorySearch('시계/쥬얼리', '4')">시계/쥬얼리</a>
                <a href="javascript:goCategorySearch('가전제품', '5')">가전제품</a>
                <a href="javascript:goCategorySearch('모바일/태블릿', '6')">모바일/태블릿</a>
                <a href="javascript:goCategorySearch('노트북/PC', '7')">노트북/PC</a>
                <a href="javascript:goCategorySearch('게임', '8')">게임</a>
                <a href="javascript:goCategorySearch('가구/인테리어', '9')">가구/인테리어</a>
            </div>
        </div>
        <a class="menu" href="javascript:goSortSearch('likes')">인기상품</a>
        <a class="menu" href="#">이벤트</a>
        <a class="menu" href="#">사기예방</a>
        <a class="menu" href="#">J쿠폰</a>
        <a class="menu" href="#">시세조회</a>
        <a class="menu" href="#">콘텐츠</a>
        <a class="menu" href="#">찜한 상품</a>
        <a class="menu" href="#">내 폰 팔기</a>
    </div>
</nav>