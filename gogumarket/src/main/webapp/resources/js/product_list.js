
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

