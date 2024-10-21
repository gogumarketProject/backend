
// 카테고리 배열
const categories = [
    "패션의류", "패션잡화", "가방/핸드백", "시계/쥬얼리", 
    "가전제품", "모바일/태블릿", "노트북/PC", "게임", "가구/인테리어"
];

// 카테고리 리스트를 <td>에 출력
const categoryListTd = document.getElementById('category-list');
categoryListTd.innerHTML = categories.map(category => 
    `<span class="category-item">${category}</span>`
).join('');

// 버튼 클릭 시 숨겨진 행 표시/숨기기
document.getElementById('category-btn').addEventListener('click', function() {
    var hiddenRow = document.getElementById('hidden-row');
    hiddenRow.style.display = (hiddenRow.style.display === "none" || hiddenRow.style.display === "") 
        ? "table-row" 
        : "none";
});

// 이벤트 위임: category-list 내부에서 클릭된 항목을 감지하여 처리
document.getElementById('category-list').addEventListener('click', function(event) {
    if (event.target && event.target.classList.contains('category-item')) {
        document.getElementById('selected-category').textContent = event.target.textContent;
    }
    document.getElementById('hidden-row').style.display = "none";
});

// 하트 찜 기능 이벤트 리스너 추가 함수
function addWishlistEventListeners() {
    document.querySelectorAll('.like-btn').forEach(button => {
        button.addEventListener('click', () => {
            button.classList.toggle('liked');
            const wishlistText = button.previousElementSibling.querySelector('.wishlist');
            let currentWishlist = parseInt(wishlistText.textContent.replace('찜 ', ''), 10);
            if (button.classList.contains('liked')) {
                currentWishlist += 1;
            } else {
                currentWishlist -= 1;
            }
            wishlistText.textContent = `${currentWishlist}명 찜꽁!`;
        });
    });
}

// 초기 찜 기능 이벤트 리스너 설정
addWishlistEventListeners();


//초기화 기능
document.getElementById('reset-btn').addEventListener('click', () => {
    document.getElementById('selected-category').innerHTML = '';
    document.getElementById('hidden-row').style.display = 'none';
    document.getElementById('min-price').value = '';
    document.getElementById('max-price').value = '';
    document.getElementById('min-price-hidden').value = '';
    document.getElementById('max-price-hidden').value = '';
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => checkbox.checked = false);
    document.querySelectorAll('input[type="radio"]').forEach(radio => radio.checked = false);
    
});


// 체크박스를 radio처럼 동작하게 만들기
const tradeAllCheckbox = document.getElementById('tradeAll');
const tradeDeliveryCheckbox = document.getElementById('delivery');
const tradeDirectCheckbox = document.getElementById('direct');

const statusAllCheckbox = document.getElementById('statusAll');
const statusNewCheckbox = document.getElementById('new');
const statusUsedCheckbox = document.getElementById('used');

function handleStatusChange() {
    if (this.checked) {
        // 하나만 선택되도록 다른 체크박스 해제
        if (this === statusNewCheckbox) {
            statusUsedCheckbox.checked = false;
            statusAllCheckbox.checked = false;
        } else if (this === statusUsedCheckbox) {
            statusNewCheckbox.checked = false;
            statusAllCheckbox.checked = false;
        }  else if (this ===  statusAllCheckbox) {
            statusNewCheckbox.checked = false;
            statusUsedCheckbox.checked = false;
        }
    }
}

function handleTradeChange() {
    if (this.checked) {
        // 하나만 선택되도록 다른 체크박스 해제
        if (this === tradeAllCheckbox) {
            tradeDeliveryCheckbox.checked = false;
            tradeDirectCheckbox.checked = false;
        } else if (this === tradeDeliveryCheckbox) {
            tradeAllCheckbox.checked = false;
            tradeDirectCheckbox.checked = false;
        } else if (this === tradeDirectCheckbox) {
            tradeAllCheckbox.checked = false;
            tradeDeliveryCheckbox.checked = false;
        }
    }
}

tradeAllCheckbox.addEventListener('change', handleTradeChange);
tradeDeliveryCheckbox.addEventListener('change', handleTradeChange);
tradeDirectCheckbox.addEventListener('change', handleTradeChange);

statusAllCheckbox.addEventListener('change', handleStatusChange);
statusNewCheckbox.addEventListener('change', handleStatusChange);
statusUsedCheckbox.addEventListener('change', handleStatusChange);

// 모든 정렬 버튼을 선택
const sortButtons = document.querySelectorAll('.sort-btn');

// 버튼 클릭 시 활성화 처리
sortButtons.forEach(button => {
    button.addEventListener('click', function() {
        sortButtons.forEach(btn => btn.classList.remove('active'));
        this.classList.add('active');
    });
});










// input price에 천 단위 콤마 추가 함수
function formatNumber(value) {
    return value.replace(/[^0-9]/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
