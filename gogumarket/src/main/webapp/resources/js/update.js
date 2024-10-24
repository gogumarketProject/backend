

// 직거래 관련 동적 필드 처리
const meetCheckbox = document.getElementById('meet');
const meetLocationContainer = document.getElementById('meetLocationContainer');

document.addEventListener('DOMContentLoaded', function() {
    // 새로고침 시 tradeType을 확인하고 직거래 체크 상태를 적용
    if (tradeType === '직거래' || tradeType === '직거래 | 택배') {
        meetLocationContainer.style.display = 'inline-block';
        meetCheckbox.checked = true;  // 직거래 체크박스를 체크 상태로 유지
    } else {
        meetLocationContainer.style.display = 'none';
        meetCheckbox.checked = false;  // 체크박스 해제 상태로 유지
    }
});
// 직거래 체크박스 이벤트 처리
meetCheckbox.addEventListener('change', function() {
 const areaNameInput = document.querySelector('input[name="areaname"]');
 const areaSpan = document.getElementById('Area');
    if (meetCheckbox.checked && tradeType === '직거래' || tradeType === '직거래 | 택배') {
        // 직거래가 체크되면 텍스트 필드를 표시
        meetLocationContainer.style.display = 'inline-block';
    } else {
        // 체크 해제 시 텍스트 필드를 숨기고 입력된 위치와 확인 상태를 초기화
        meetLocationContainer.style.display = 'none';
        document.getElementById('meetLocation').value = ''; // 입력 필드 초기화
        document.getElementById('locationOutput').innerHTML = ''; // 출력된 위치 초기화
        document.getElementById('locationOutput').style.display = 'none';
        locationConfirmed = false; // 추가 상태 초기화
    }
});
document.addEventListener("DOMContentLoaded", function () {
          // 요소 가져오기
          const locationInput = document.getElementById('meetLocation');
          const locationConfirmButton = document.getElementById('locationConfirmButton');
          const areaSpan = document.getElementById('Area');
          const areaNameInput = document.querySelector('input[name="areaname"]');
          
          // 버튼 클릭 시 이벤트 리스너
          locationConfirmButton.addEventListener('click', function (event) {
              event.preventDefault(); // 폼 제출 또는 페이지 리로드 방지
              
              // 입력값 가져오기
              const enteredLocation = locationInput.value.trim();
              
              // 입력값이 비어있지 않다면
              if (enteredLocation !== "") {
                  // span 태그 내용 업데이트
                  areaSpan.textContent = enteredLocation;
                  
                  // 숨겨진 입력 필드 업데이트
                  areaNameInput.value = enteredLocation;
                  
                  // 입력 필드 초기화 (선택 사항)
                  locationInput.value = "";
              }
          });
      });
  	document.addEventListener("DOMContentLoaded", function () {
  	    // 요소 가져오기
  	    const locationInput = document.getElementById('meetLocation'); // 위치 입력 필드
  	    const locationConfirmButton = document.getElementById('locationConfirmButton'); // 추가 버튼
  	    const areaSpan = document.getElementById('Area'); // 위치를 표시하는 span
  	    const areaNameInput = document.querySelector('input[name="areaname"]'); // 숨겨진 입력 필드
  	    const nowLocationClose = document.getElementById('nowLocation'); // x 버튼

  	    // '추가' 버튼 클릭 시 이벤트 리스너
  	    nowLocationClose.addEventListener('click', function () {
		    // span 내용 지우기
		    areaSpan.textContent = "";
		
		    // 숨겨진 입력 필드 값 지우기
		    areaNameInput.value = "";
		
		    // areaSpan과 x 버튼 숨기기 (여기서도 상태를 명확하게 초기화)
		    nowLocationClose.style.display = "none"; // x 버튼 숨기기
		    locationInput.value = "";  // 입력 필드 초기화 추가
		});
		
		locationConfirmButton.addEventListener('click', function (event) {
		    event.preventDefault(); // 폼 제출 또는 페이지 리로드 방지
		    
		    // 입력값 가져오기
		    const enteredLocation = locationInput.value.trim();
		    
		    // 입력값이 비어있지 않다면
		    if (enteredLocation !== "") {
		        // span 태그 내용 업데이트 (직거래 위치 표시)
		        areaSpan.textContent = enteredLocation;
		        
		        // 숨겨진 입력 필드 업데이트
		        areaNameInput.value = enteredLocation;
		        
		        // 입력 필드 초기화
		        locationInput.value = "";
		
		        // areaSpan과 x 버튼을 다시 보이도록 설정
		        areaSpan.style.display = "inline"; // 위치가 표시되는 span 보이게
		    }
		    nowLocationClose.style.display = "inline"; // x 버튼 보이게
		});

  	    // 페이지 로드 시 초기 상태 설정
  	    
  	});
meetCheckbox.addEventListener('change', function() {
    const areaNameInput = document.querySelector('input[name="areaname"]');
    const areaSpan = document.getElementById('Area');
    const nowLocationClose = document.getElementById('nowLocation');
    const locationInput = document.getElementById('meetLocation');

    if (meetCheckbox.checked) {
        // 직거래 체크되면 텍스트 필드를 표시
        meetLocationContainer.style.display = 'inline-block';
    } else {
        // 체크 해제 시 값 초기화 및 텍스트 필드 숨김
        meetLocationContainer.style.display = 'none';
        areaSpan.textContent = ''; // 지역 이름 초기화
        areaNameInput.value = '';  // 숨겨진 입력 필드 초기화
        locationInput.value = '';  // 입력 필드 초기화
        nowLocationClose.style.display = 'none';  // x 버튼 숨기기
    }
});