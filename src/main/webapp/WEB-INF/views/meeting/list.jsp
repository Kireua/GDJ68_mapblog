<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Travel HTML-5 Template</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="manifest" href="site.webmanifest" />
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="/resources/img/index/favicon.ico"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b5744597ccc65933ecad3607daed47e&libraries=services"
    ></script>
    


    <!-- CSS here -->
    <link rel="stylesheet" href="/resources/css/index/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/index/owl.carousel.min.css" />
    <link rel="stylesheet" href="/resources/css/index/flaticon.css" />
    <link rel="stylesheet" href="/resources/css/index/slicknav.css" />
    <link rel="stylesheet" href="/resources/css/index/animate.min.css" />
    <link rel="stylesheet" href="/resources/css/index/magnific-popup.css" />
    <link
      rel="stylesheet"
      href="/resources/css/index/fontawesome-all.min.css"
    />
    <link rel="stylesheet" href="/resources/css/index/themify-icons.css" />
    <link rel="stylesheet" href="/resources/css/index/slick.css" />
    <link rel="stylesheet" href="/resources/css/index/nice-select.css" />
    <link rel="stylesheet" href="/resources/css/index/style.css" />
    <style>
      footer {
        float: left;
        width: 100%;
      }
      .modal-body{
        margin: 0 auto;
      }
      .detailBox::after{
        content: '';
        display: block;
        clear: both;
      }
      button{
        color: #333;
        border-radius: 10px;
      }
      #myListBtn{
        margin-left: 30px;
        margin-bottom: 15px;
      }
      a{
        text-decoration: none;
      }
      a:hover{
        text-decoration: underline;
        color: blue;
      }
      #position{
        margin-right: 30px;
        float: right;
        width: 250px;
      }
      #myListBtn{
        height: 40px;
      }
      .btn{
        margin-bottom: 14px;
        height: 40px;
      }
      
    </style>
  </head>

  <body>
    <!-- Preloader Start -->
    <div id="preloader-active">
      <div class="preloader d-flex align-items-center justify-content-center">
        <div class="preloader-inner position-relative">
          <div class="preloader-circle"></div>
          <div class="preloader-img pere-text">
            <img src="/resources/img/찐막.png" alt="" />
          </div>
        </div>
      </div>
    </div>
    <!-- Preloader Start -->

    <!-- Header Start -->

    <c:import url="/WEB-INF/views/temp/header.jsp"></c:import>
    <c:import url="../temp/bootStrap.jsp"></c:import>
    <!-- Header End -->

    <!-- Main start -->
    <main>
      <div class="input-group mb-3"  id="position">
      <input type="text" class="form-control" placeholder="주소를 입력하세요" aria-label="Recipient's username" aria-describedby="button-addon2" id="adrs"/><button id="btn2" type="button" class="btn btn-outline-secondary">
        검색
      </button></div>
      <button id="myListBtn" type="button" class="btn btn-outline-secondary">내 참석 모임 보기</button>
      <a href="./add" class="btn btn-outline-secondary">모임 추가</a>
      <c:forEach items="${list}" var="d" varStatus="i">
        <div
          class="a"
          data-meetingNum="${d.meetingNum}"
          data-contents="${d.contents}"
          data-title="${d.title}"
          data-lat="${d.lat }"
          data-lng="${d.lng }"
          id="${i.index}"
        ></div>
      </c:forEach>
      <div id="myList"></div>
      <div
        id="map"
        style="
          width: 100%;
          height: 800px;
          float: left;
          border: solid 1px;
          margin-right: 300px;
        "
      ></div>
      <!-- <div id="detail" style="float: left; text-align: center">
    
    </div> -->
      <div class="modal" id="myModal">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
          <div class="modal-content">
            
                
                <div id="detail" style="float: left; text-align: center">
                    
                </div>
            
           <!--  <div class="modal-body"> -->
           <!--  <div class="modal-footer">
              <button
                type="button"
                id="closeModalBtn"
                class="btn btn-secondary"
                data-bs-dismiss="modal"
              >
                Close
              </button>
              <button type="button" class="btn btn-primary">
                Save changes
              </button>
            </div> -->
          
        </div>
      </div>
      

    </main>

    <!-- Footer Start-->

    <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

    <!-- Footer End-->

    <!-- JS here -->

    <!-- All JS Custom Plugins Link Here here -->
    <script src="/resources/js/index/vendor/modernizr-3.5.0.min.js"></script>
    <script type="text/javascript">
      // kakao.maps.load(function() {
      // // v3가 모두 로드된 후, 이 콜백 함수가 실행됩니다.
      // let map = new kakao.maps.Map(node, options);
      // });
    </script>

    <script src="../resources/js/meeting/list.js" defer></script>

    <!-- Jquery, Popper, Bootstrap -->
    <script src="/resources/js/index/vendor/jquery-1.12.4.min.js"></script>
    <script src="/resources/js/index/popper.min.js"></script>
    <script src="/resources/js/index/bootstrap.min.js"></script>
    <!-- Jquery Mobile Menu -->
    <script src="/resources/js/index/jquery.slicknav.min.js"></script>

    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="/resources/js/index/owl.carousel.min.js"></script>
    <script src="/resources/js/index/slick.min.js"></script>
    <!-- One Page, Animated-HeadLin -->
    <script src="/resources/js/index/wow.min.js"></script>
    <script src="/resources/js/index/animated.headline.js"></script>
    <script src="/resources/js/index/jquery.magnific-popup.js"></script>

    <!-- Scrollup, nice-select, sticky -->
    <script src="/resources/js/index/jquery.scrollUp.min.js"></script>
    <script src="/resources/js/index/jquery.nice-select.min.js"></script>
    <script src="/resources/js/index/jquery.sticky.js"></script>

    <!-- contact js -->
    <script src="/resources/js/index/contact.js"></script>
    <script src="/resources/js/index/jquery.form.js"></script>
    <script src="/resources/js/index/jquery.validate.min.js"></script>
    <script src="/resources/js/index/mail-script.js"></script>
    <script src="/resources/js/index/jquery.ajaxchimp.min.js"></script>

    <!-- Jquery Plugins, main Jquery -->
    <script src="/resources/js/index/plugins.js"></script>
    <script src="/resources/js/index/main.js"></script>
  </body>
</html>
