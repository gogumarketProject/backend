
// 카테고리 배열
const categories = [
    "패션의류", "패션잡화", "가방/핸드백", "시계/쥬얼리", 
    "가전제품", "모바일/태블릿", "노트북/PC", "게임", "가구/인테리어"
];

// 카테고리 리스트를 <td>에 출력
const categoryListTd = document.getElementById('category-list');
categoryListTd.innerHTML = categories.map(category => 
    `<span class="category-item" style="margin-right: 10px; cursor: pointer;">${category}</span>`
).join('');

// 카테고리 선택 시 hidden input의 값 설정
document.getElementById('category-list').addEventListener('click', function(event) {
    if (event.target && event.target.classList.contains('category-item')) {
        // 선택된 카테고리의 이름
        const selectedCategory = event.target.textContent;

        // 카테고리 배열에서 선택된 카테고리의 인덱스 찾기
        const categoryIndex = categories.indexOf(selectedCategory) + 1; // 1부터 시작하도록 +1

        // hidden input에 값 설정
        document.getElementById('category').value = categoryIndex;

        // 선택된 카테고리 표시
        document.getElementById('selected-category').textContent = selectedCategory;
    }
    event.preventDefault();
});

// 버튼 클릭 시 숨겨진 행 표시/숨기기
document.getElementById('category-btn').addEventListener('click', function() {
    var hiddenRow = document.getElementById('hidden-row');
    hiddenRow.style.display = (hiddenRow.style.display === "none" || hiddenRow.style.display === "") 
        ? "table-row" 
        : "none";
    event.preventDefault();
});

// 이벤트 위임: category-list 내부에서 클릭된 항목을 감지하여 처리
document.getElementById('category-list').addEventListener('click', function(event) {
    if (event.target && event.target.classList.contains('category-item')) {
        document.getElementById('selected-category').textContent = event.target.textContent;
    }
});

//초기화 기능
document.getElementById('reset-btn').addEventListener('click', () => {
    document.getElementById('selected-category').innerHTML = '전체';
    document.getElementById('min-price').value = '';
    document.getElementById('max-price').value = '';
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => checkbox.checked = false);
    document.querySelectorAll('input[type="radio"]').forEach(radio => radio.checked = false);
    document.getElementById('category').value = '';
    event.preventDefault();
});

// 가격 기입에 관한 기능
function applyPriceFilter() {
    const minPriceInput = document.getElementById('min-price').value;
    const maxPriceInput = document.getElementById('max-price').value;

    const minPrice = parseInt(minPriceInput, 10);
    const maxPrice = parseInt(maxPriceInput, 10);

    let filterText = '';

    // 최소/최대 가격이 기입되었을 때만 체크
    if (minPriceInput && minPrice < 10) {
        // 최소가격이 10원 미만이면 경고
        alert('최소가격을 10원 이상 적어주세요.');
        document.getElementById('min-price').focus();
        return;
    }

    if (maxPriceInput && maxPrice < 10) {
        // 최대가격이 10원 미만이면 경고
        alert('최대가격을 10원 이상 적어주세요.');
        document.getElementById('max-price').focus();
        return;
    }

    if (minPriceInput && maxPriceInput && maxPrice < minPrice) {
        // 최대가격이 최소가격보다 낮으면 경고
        alert('최대가격이 최소가격보다 낮습니다.');
        document.getElementById('max-price').focus();
        return;
    }

    // 가격 필터 적용
    if (minPriceInput && !maxPriceInput) {
        // 최소가격만 입력된 경우 "10원 ~"
        filterText = ` ${minPriceInput} ~ `;
    } else if (!minPriceInput && maxPriceInput) {
        // 최대가격만 입력된 경우 "~ 20원"
        filterText = ` ~ ${maxPriceInput} `;
    } else if (minPriceInput && maxPriceInput) {
        // 최소가격과 최대가격 모두 입력된 경우
        filterText = ` ${minPriceInput} ~ ${maxPriceInput} `;
    }

    // 카테고리 필터 추가
    const selectedCategory = document.getElementById('selected-category').textContent;
    if (selectedCategory) {
        filterText += ` ${selectedCategory} `;
    }

    // 체크박스 (거래 방법) 필터 추가
    const delivery = document.getElementById('delivery').checked ? '택배' : '';
    const direct = document.getElementById('direct').checked ? '직거래' : '';
    const deliveryMethod = [delivery, direct].filter(Boolean).join(' ');

    if (deliveryMethod) {
        filterText += ` ${deliveryMethod} `;
    }

    // 라디오 버튼 (상품 상태) 필터 추가
	const productStatusNew = document.getElementById('new');
	const productStatusUsed = document.getElementById('used');
	
	if (productStatusNew.checked) {
	    filterText += ` ${productStatusNew.nextElementSibling.textContent} `;
	} else if (productStatusUsed.checked) {
	    filterText += ` ${productStatusUsed.nextElementSibling.textContent} `;
	}

    // 필터 텍스트 업데이트
    document.getElementById('filter-text').textContent = filterText;
}

// 카테고리 선택 시 필터 적용
document.getElementById('category-list').addEventListener('click', function(event) {
    if (event.target && event.target.classList.contains('category-item')) {
        var selectedCategory = event.target.textContent;
        
        // 선택된 카테고리를 표시
        document.getElementById('selected-category').textContent = selectedCategory;
        
        // input 필드의 value에 선택된 카테고리 값을 설정
        document.getElementById('category-input').value = selectedCategory;
        
        // 카테고리 선택 시 필터 텍스트 업데이트 (필요 시 추가 작업)
        applyPriceFilter();
    }
});


// 체크박스와 라디오 버튼 변경 시 필터 적용
document.querySelectorAll('input[type="checkbox"], input[type="radio"]').forEach(input => {
    input.addEventListener('change', applyPriceFilter);  // 선택 상태가 변경되면 필터 적용
});


// 페이지가 로드될 때 기본 정렬을 recent로 설정
window.onload = function() {
    sortProducts('recent');  // 페이지가 처음 로드되면 자동으로 'recent' 정렬
};

// 모든 정렬 버튼을 선택
const sortButtons = document.querySelectorAll('.sort-btn');

// 버튼 클릭 시 활성화 처리
sortButtons.forEach(button => {
    button.addEventListener('click', function() {
        sortButtons.forEach(btn => btn.classList.remove('active'));
        this.classList.add('active');
    });
});

// 정렬 버튼 클릭 이벤트 처리
document.querySelectorAll('.sort-btn').forEach(button => {
    button.addEventListener('click', () => {
        // 모든 버튼에서 active 클래스 제거 후 현재 클릭된 버튼에 추가
        document.querySelectorAll('.sort-btn').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');

        const sortCriteria = button.getAttribute('data-sort');
        sortProducts(sortCriteria);
    });
});

