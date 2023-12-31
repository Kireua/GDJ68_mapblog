let centertLat = 33.450701;
let centerLng = 126.570667;

getLocation();

function getLocation() {
    if (navigator.geolocation) { // GPS를 지원하면
      navigator.geolocation.getCurrentPosition(function(position) {
        // alert(position.coords.latitude + ' ' + position.coords.longitude);
        centertLat = position.coords.latitude;
        console.log(centertLat);
        centerLng = position.coords.longitude;
        console.log(centerLng);
        getKakaoMap(centertLat,centerLng)
      }, function(error) {
        console.error(error);
        alert('GPS 지원을 동의하지 않으셨습니다.')
        getKakaoMap(centertLat,centerLng);
      }, {
        enableHighAccuracy: false,
        maximumAge: 0,
        timeout: Infinity
      });
    } else {
      alert('GPS를 지원하지 않습니다');
      getKakaoMap(centertLat,centerLng);
    }
  }


$('#btn2').on("click",function(){
    console.log($('#adrs').val());
    getKakaoMap(centertLat,centerLng);
});

function getKakaoMap(centertLat,centerLng){
let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(centertLat, centerLng), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


if($('#adrs').val()!=""){
    // 주소-좌표 변환 객체를 생성합니다
  let geocoder = new kakao.maps.services.Geocoder();

  // 주소로 좌표를 검색합니다
  geocoder.addressSearch($('#adrs').val(), function(result, status) {

    // 정상적으로 검색이 완료됐으면 
    if (status === kakao.maps.services.Status.OK) {

      let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
     
      map.setCenter(coords);
      
    }else{
      alert('검색 실패');    
   }
  })

}

let checked = true;

let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
$('.a').each((i,e)=>{
    
    // 마커 이미지의 이미지 크기 입니다
    let imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    lat = $(e).attr('data-lat');
    lng = $(e).attr('data-lng');
    // 마커를 생성합니다
    marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: new kakao.maps.LatLng(lat, lng), // 마커를 표시할 위치
        title : $(e).attr('data-feedNum'), // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage, // 마커 이미지 
        clickable : true
    });


    let iwContent = '<div style="padding:5px;"><a href="../detail?feedNum=${f.feedNum}" style="color:blue" target="_blank">본문보기</a>',
    // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    
    infowindow = new kakao.maps.InfoWindow({
        content: $(e).attr('data-title') // 인포윈도우에 표시할 내용
    });
    
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
});

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
};


function makeClickListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
        console.log(marker.Gb);
    };
}
}


function panTo() {
    // 이동할 위도 경도 위치를 생성합니다 
    let moveLatLon = new kakao.maps.LatLng(lat, lng);
    
    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);            
}   

/* ---------------------------------------------------------------------------- */

// 커스텀 오버레이

let tripDate = document.getElementById("tripDate").value;
let title = document.getElementById("title").value;

let content = '<div class="overlaybox">' +
    '    <div class="tripDate">' + tripDate + '</div>' +
    '    <div class="title">' + title + '</div>' +
    '    </div>';

function makeClickListener(map, marker) {

 
    return function() {
 
        console.log(marker.Gb);
        $.ajax({
            type:"GET",
            url:"./detail?feedNum="+marker.Gb,
            success: function(r){
                console.log(r);
                content = r;
                 overlay = new kakao.maps.CustomOverlay({
                    content: content,
                    map: map,
                    position: marker.getPosition(),
                    yAnchor: 1       
                });
                overlay.setMap(map); 
                console.log(overlay);
                console.log(marker.getPosition());
            }
        })
      
    
    };
}

