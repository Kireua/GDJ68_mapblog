let centertLat =33.450701;
let centerLng =126.570667;
let myListResult = true;
$('#myListBtn').on('click',function(){
 
  if(myListResult){
    $(this).html('전체 리스트 보기');
    myListResult=!myListResult;
   
  $.ajax({
    type:"GET",
    url:"./myList",
    success: function(r){
        $('#myList').html(r);
        getKakaoMap(centertLat,centerLng);
     
    },error: function(){
      console.log(error);
    }
})
}else{
  
    $(this).html('내 참석 모임 보기');
    myListResult=!myListResult;
    getKakaoMap(centertLat,centerLng);
    
  }
});



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

let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
if(myListResult) {
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
        title : $(e).attr('data-meetingNum'), // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage, // 마커 이미지 
        clickable : true
    });
    
    infowindow = new kakao.maps.InfoWindow({
        content: $(e).attr('data-title') // 인포윈도우에 표시할 내용
    });
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
});
}else{

let imageSrc = "../resources/img/marker2.png";
$('.b').each((i,e)=>{
  
  // 마커 이미지의 이미지 크기 입니다
  let imageSize = new kakao.maps.Size(43, 54); 
  
  // 마커 이미지를 생성합니다    
  let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
  lat = $(e).attr('data-lat');
  lng = $(e).attr('data-lng');
  // 마커를 생성합니다
  marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(lat, lng), // 마커를 표시할 위치
      title : $(e).attr('data-meetingNum'), // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image : markerImage, // 마커 이미지 
      clickable : true
  });
  
  infowindow = new kakao.maps.InfoWindow({
      content: $(e).attr('data-title') // 인포윈도우에 표시할 내용
  });
  kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
  kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
  kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
});
}
}

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
    // let clickFunction ={
    //     ch: true,
    //     f1 : function(){
    //         infowindow.open(map,marker);
    //     }
    // }
    // if(checked){   
    //     return clickFunction;

    // }else{
    //     return clickFunction.f2;
    // }
    return function() {
        infowindow.open(map, marker);
        console.log(marker.Gb);
        $.ajax({
            type:"GET",
            url:"./detail?meetingNum="+marker.Gb,
            success: function(r){
                $('#detail').html(r);
              //   $.ajax({
              //     type:"GET",
              //     url:"./getComment?meetingNum="+marker.Gb,
              //     success: function(r){
              //         $('#commentList').html(r);
              //     }
              // })
            }
        })
    
    };
}


// $('#detail').on('click','#commentList',function(){
  
// })






function getMyKakaoMap(centertLat,centerLng){
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

let imageSrc = "../resources/img/marker2.png";

$('.b').each((i,e)=>{
  
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
      title : $(e).attr('data-meetingNum'), // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image : markerImage, // 마커 이미지 
      clickable : true
  });
  
  infowindow = new kakao.maps.InfoWindow({
      content: $(e).attr('data-title') // 인포윈도우에 표시할 내용
  });
  kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
  kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
  kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
});

}

