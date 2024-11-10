
//구매상품
document.addEventListener("DOMContentLoaded", function() {

    let currentPurchaseTab = "all";
    let currentPage = 1;
    const itemsPerPage = 10;

    function displayPurchaseProducts(page) {
        let productsToDisplay = [];

        if (currentPurchaseTab === "all") {
            productsToDisplay = [...purchasingProducts, ...purchasedProducts];
        } else if (currentPurchaseTab === "purchasing") {
            productsToDisplay = purchasingProducts;
        } else if (currentPurchaseTab === "purchased") {
            productsToDisplay = purchasedProducts;
        }

        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const productsToShow = productsToDisplay.slice(startIndex, endIndex);

        const productList = document.getElementById("product-list-purchase-history");
        productList.innerHTML = "";

        productsToShow.forEach(product => {
            const productItem = document.createElement("div");
            productItem.className = "product-item";

            productItem.innerHTML = `
                <a href=javascript:goConsumer('${product.no}')>
                ${currentPurchaseTab === 'purchased' || (currentPurchaseTab === 'all' && purchasedProducts.includes(product)) ? '<div class="purchased-overlay">구매 완료</div>' : ''}
                <img src="${contextPath}/resources/images/${product.imageDir}" alt="상품 이미지" class="product-img">
                
			    <div class="product-info">
			        ${product.name}<br>
			        ${product.location ? `${product.location} | ${product.time}` : product.time}
			    </div>
			    
			    <div class="product-price">${product.price}</div>
			    </a>
			`;
			
            productList.appendChild(productItem);
        });

        setupPurchasePagination(productsToDisplay.length);
    }

    function setupPurchasePagination(totalItems) {
        const totalPages = Math.ceil(totalItems / itemsPerPage);
        const pagination = document.getElementById("pagination-purchase-history");
        pagination.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement("span");
            pageItem.textContent = i;
            pageItem.className = (i === currentPage) ? "active" : "";
            pageItem.addEventListener("click", function() {
                currentPage = i;
                displayPurchaseProducts(currentPage);
            });

            pagination.appendChild(pageItem);
        }
    }

    function setActivePurchaseTab(tabId) {
        // Remove "active" class from all tabs
        document.querySelectorAll('.tab-menu-purchase div').forEach(tab => {
            tab.classList.remove("active");
        });

        // Set "active" class to the selected tab
        document.getElementById(tabId).classList.add("active");

        // Update current tab and reset to the first page
        currentPurchaseTab = tabId === 'tab-all-purchase' ? 'all' : (tabId === 'tab-purchasing' ? 'purchasing' : 'purchased');
        currentPage = 1;

        // Display products for the selected tab
        displayPurchaseProducts(currentPage);
    }

    // Event listeners for purchase tabs
    document.getElementById('tab-all-purchase').addEventListener('click', () => setActivePurchaseTab('tab-all-purchase'));
    document.getElementById('tab-purchasing').addEventListener('click', () => setActivePurchaseTab('tab-purchasing'));
    document.getElementById('tab-purchased').addEventListener('click', () => setActivePurchaseTab('tab-purchased'));

    // Default section to display on load
    setActivePurchaseTab("tab-all-purchase");
});



// 판매상품
document.addEventListener("DOMContentLoaded", function() {
    const sections = {
        "btn-purchase-history": "section-purchase-history",
        "btn-selling": "section-selling",
        "btn-wishlist": "section-wishlist",
        "btn-offers": "section-offers",
        "btn-transaction-reviews": "section-transaction-reviews"
    };

    

    let currentTab = "all";
    let currentPage = 1;
    const itemsPerPage = 10;

    function displayProducts(page) {
        let productsToDisplay = [];

        if (currentTab === "all") {
            productsToDisplay = [...sellingProducts, ...soldProducts];
        } else if (currentTab === "selling") {
            productsToDisplay = sellingProducts;
        } else if (currentTab === "sold") {
            productsToDisplay = soldProducts;
        }

        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const productsToShow = productsToDisplay.slice(startIndex, endIndex);

        const productList = document.getElementById("product-list-selling");
        productList.innerHTML = "";

        productsToShow.forEach(product => {
            const productItem = document.createElement("div");
            productItem.className = "product-item";

            // 수정된 부분: currentTab === 'all'에서도 판매 완료 상태인 상품에 대한 오버레이 처리
            productItem.innerHTML = `
            	<a href=javascript:goConsumer('${product.no}')>
			    ${(currentTab === 'sold' || (currentTab === 'all' && soldProducts.includes(product))) ? '<div class="sold-overlay">판매 완료</div>' : ''}
			    <img src="${contextPath}/resources/images/${product.imageDir}" alt="상품 이미지" class="product-img">
			    
			    <div class="product-info">
			        ${product.name}<br>
			        ${product.location ? `${product.location} | ${product.time}` : product.time}
			    </div>
			    
			    <div class="product-price">${product.price}</div>
			    </a>
			`;

            productList.appendChild(productItem);
        });

        setupPagination(productsToDisplay.length);
    }

    function setupPagination(totalItems) {
        const totalPages = Math.ceil(totalItems / itemsPerPage);
        const pagination = document.getElementById("pagination-selling");
        pagination.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement("span");
            pageItem.textContent = i;
            pageItem.className = (i === currentPage) ? "active" : "";
            pageItem.addEventListener("click", function() {
                currentPage = i;
                displayProducts(currentPage);
            });

            pagination.appendChild(pageItem);
        }
    }

    function setActiveTab(tabId) {
        // Remove "active" class from all tabs
        document.querySelectorAll('.tab-menu div').forEach(tab => {
            tab.classList.remove("active");
        });

        // Set "active" class to the selected tab
        document.getElementById(tabId).classList.add("active");

        // Update current tab and reset to the first page
        currentTab = tabId === 'tab-all' ? 'all' : (tabId === 'tab-selling' ? 'selling' : 'sold');
        currentPage = 1;

        // Display products for the selected tab
        displayProducts(currentPage);
    }

    // Event listeners for tabs
    document.getElementById('tab-all').addEventListener('click', () => setActiveTab('tab-all'));
    document.getElementById('tab-selling').addEventListener('click', () => setActiveTab('tab-selling'));
    document.getElementById('tab-sold').addEventListener('click', () => setActiveTab('tab-sold'));

    // Set active profile tab and display the respective section
    function setActiveProfileTab(id) {
        // Remove "active" class from all buttons and hide all sections
        Object.keys(sections).forEach(btnId => {
            document.getElementById(btnId).classList.remove("active");
            document.getElementById(sections[btnId]).style.display = "none";
        });

        // Add "active" class to the clicked button and display respective section
        document.getElementById(id).classList.add("active");
        document.getElementById(sections[id]).style.display = "block";

        // If "판매 상품" tab is clicked, display products and setup pagination
        if (id === 'btn-selling') {
            displayProducts(currentPage);
        }
    }

    // Event listeners for profile buttons
    Object.keys(sections).forEach(btnId => {
        document.getElementById(btnId).addEventListener("click", () => setActiveProfileTab(btnId));
    });

    // Default section to display on load
    setActiveProfileTab("btn-purchase-history");
});


// 찜한 상품
document.addEventListener("DOMContentLoaded", function() {

    let currentWishlistPage = 1;
    const itemsPerPage = 10;

    function displayWishlistProducts(page) {
        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const productsToShow = wishlistProducts.slice(startIndex, endIndex);

        const productList = document.getElementById("product-list-wishlist");
        productList.innerHTML = "";

        productsToShow.forEach(product => {
            const productItem = document.createElement("div");
            productItem.className = "product-item";

            productItem.innerHTML = `
            	<a href=javascript:goConsumer('${product.no}')>
                <img src="${contextPath}/resources/images/${product.imageDir}" alt="상품 이미지" class="product-img">
			    
			    <div class="product-info">
			        ${product.name}<br>
			        ${product.location ? `${product.location} | ${product.time}` : product.time}
			    </div>
			    
			    <div class="product-price">${product.price}</div>
			    </a>
			`;

            productList.appendChild(productItem);
        });

        setupWishlistPagination(wishlistProducts.length);
    }

    function setupWishlistPagination(totalItems) {
        const totalPages = Math.ceil(totalItems / itemsPerPage);
        const pagination = document.getElementById("pagination-wishlist");
        pagination.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement("span");
            pageItem.textContent = i;
            pageItem.className = (i === currentWishlistPage) ? "active" : "";
            pageItem.addEventListener("click", function() {
                currentWishlistPage = i;
                displayWishlistProducts(currentWishlistPage);
            });

            pagination.appendChild(pageItem);
        }
    }

    // Set default tab to display on load
    displayWishlistProducts(currentWishlistPage);
});


// 가격 제안

document.addEventListener("DOMContentLoaded", function() {

    let currentOffersTab = "selling";
    let currentOffersPage = 1;
    const itemsPerPage = 10;

    function displayOffersProducts(page) {
        let offersToDisplay = currentOffersTab === "selling" ? sellingOffers : purchaseOffers;

        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const offersToShow = offersToDisplay.slice(startIndex, endIndex);

        const productList = document.getElementById("product-list-offers");
        productList.innerHTML = "";

        offersToShow.forEach(offer => {
            const productItem = document.createElement("div");
            productItem.className = "product-item";

            productItem.innerHTML = `
            	<a href=javascript:goConsumer('${offer.no}')>
                <img src="${contextPath}/resources/images/${offer.imageDir}" alt="상품 이미지" class="product-img">
			    
			    <div class="product-info">
			        ${offer.name}<br>
			        ${offer.location ? `${offer.location} | ${offer.time}` : offer.time}
			    </div>
			    
			    <div class="product-price">${offer.price}</div>
			    </a>
			`;

            productList.appendChild(productItem);
        });

        setupOffersPagination(offersToDisplay.length);
    }

    function setupOffersPagination(totalItems) {
        const totalPages = Math.ceil(totalItems / itemsPerPage);
        const pagination = document.getElementById("pagination-offers");
        pagination.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement("span");
            pageItem.textContent = i;
            pageItem.className = (i === currentOffersPage) ? "active" : "";
            pageItem.addEventListener("click", function() {
                currentOffersPage = i;
                displayOffersProducts(currentOffersPage);
            });

            pagination.appendChild(pageItem);
        }
    }

    function setActiveOffersTab(tabId) {
        document.querySelectorAll('.tab-menu-offers div').forEach(tab => {
            tab.classList.remove("active");
        });

        document.getElementById(tabId).classList.add("active");
        currentOffersTab = tabId === "tab-all-offers" ? "selling" : "purchase";
        currentOffersPage = 1;
        displayOffersProducts(currentOffersPage);
    }

    document.getElementById('tab-all-offers').addEventListener('click', () => setActiveOffersTab('tab-all-offers'));
    document.getElementById('tab-purchase-offers').addEventListener('click', () => setActiveOffersTab('tab-purchase-offers'));

    // Default section to display on load
    setActiveOffersTab("tab-all-offers");
});




// 신뢰지수 막대 애니메이션
document.addEventListener("DOMContentLoaded", function() {
    const trustScoreValue = parseInt(document.getElementById("trust-score-value").innerText);
    const trustBarInner = document.getElementById("trust-bar-inner");

    // 애니메이션 효과를 위한 setInterval 사용
    let currentValue = 0;
    const maxScore = 1000;
    const interval = setInterval(() => {
        if (currentValue >= trustScoreValue) {
            clearInterval(interval);
        } else {
            currentValue += 2; // 증가 속도 조절 가능
            const widthPercentage = (currentValue / maxScore) * 100;
            trustBarInner.style.width = widthPercentage + "%";
        }
    }, 10); // 증가 간격 조절 가능
});