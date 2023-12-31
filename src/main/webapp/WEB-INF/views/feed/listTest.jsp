<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Travel HTML-5 Template </title>

        <c:import url="../temp/bootStrap.jsp"></c:import>

        <!-- Kakao Map -->
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b5744597ccc65933ecad3607daed47e&libraries=services"></script>


        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- <link rel="manifest" href="site.webmanifest"> -->
		<link rel="shortcut icon" type="image/x-icon" href="/resources/img/index/favicon.ico">

		<!-- CSS here -->
            <link rel="stylesheet" href="/resources/css/index/bootstrap.min.css">
            <link rel="stylesheet" href="/resources/css/index/owl.carousel.min.css">
            <link rel="stylesheet" href="/resources/css/index/flaticon.css">
            <link rel="stylesheet" href="/resources/css/index/slicknav.css">
            <link rel="stylesheet" href="/resources/css/index/animate.min.css">
            <link rel="stylesheet" href="/resources/css/index/magnific-popup.css">
            <link rel="stylesheet" href="/resources/css/index/fontawesome-all.min.css">
            <link rel="stylesheet" href="/resources/css/index/themify-icons.css">
            <link rel="stylesheet" href="/resources/css/index/slick.css">
            <link rel="stylesheet" href="/resources/css/index/nice-select.css">
            <link rel="stylesheet" href="/resources/css/index/style.css">
        
        <style>
            .overlaybox {position:relative;width:360px;height:350px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
            .overlaybox div, ul {overflow:hidden;margin:0;padding:0;}
            .overlaybox li {list-style: none;}
            .overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;margin-bottom:8px;}
            .overlaybox .first {position:relative;width:247px;height:136px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png') no-repeat;margin-bottom:8px;}
            .first .text {color:#fff;font-weight:bold;}
            .first .triangle {position:absolute;width:48px;height:48px;top:0;left:0;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:6px;font-size:18px;}
            .first .movietitle {position:absolute;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;}
            .overlaybox ul {width:247px;}
            .overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
            .overlaybox li span {display:inline-block;}
            .overlaybox li .number {font-size:16px;font-weight:bold;}
            .overlaybox li .title {font-size:13px;}
            .overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;} 
            .overlaybox li .up {background-position:0 -40px;}
            .overlaybox li .down {background-position:0 -60px;}
            .overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
            .overlaybox li:hover {color:#fff;background:#d24545;}
            .overlaybox li:hover .up {background-position:0 0px;}
            .overlaybox li:hover .down {background-position:0 -20px;}
        </style>
   </head>

   <body>
        <script>




        let clickCount = 0; 
        /* function addFollow(){
            $.ajax({
                url: '/feed/list',
                type: 'get',
                data: {
                    nowUrl: location.href
                }
                
            })
        } */
        
        function addFollow(){
            $.ajax({
                url: '/feed/follow/add',
                type: 'post',
                data: {
                    nowUrl: location.href
                }, 
                success: function(){
                    alert("팔로우 추가 성공")
                    location.reload();
                    
                }
            })
        }
        
        function deleteFollow(){
            $.ajax({
                url: '/feed/follow/deleteFollow',
                type: 'post',
                data: {
                    nowUrl: location.href
                },
                success: function(){
                    alert("팔로우 취소 성공")
                    location.reload();
                }
            })
        }
        /* document.addEventListener("DOMContentLoaded", function() {
            const followBtn = document.getElementById("actionBtn");
            let isFollowing = getFollowStatusFromCookie();

            followBtn.addEventListener('click',function(){
                if(isFollowing){
                    deleteFollow();
                    
                }
                else{
                    addFollow();
                    
                }
                toggleFollowBtn();
                saveFollowStatusToCookie(isFollowing);
            })
            function toggleFollowBtn() {
                isFollowing = !isFollowing;
                followBtn.textContent = isFollowing ? "팔로우" : "언팔로우";
            }

            toggleFollowBtn();
            
        }); */

        function getFollowStatusFromCookie() {
        // 쿠키에서 팔로우 상태를 가져오는 코드를 작성
        const cookies = document.cookie.split('; ');
        for (const cookie of cookies) {
            const [name, value] = cookie.split('=');
            if (name === 'followStatus') {
                return value === 'true'; // 팔로우 상태가 'true'면 true, 그렇지 않으면 false 반환
            }
        }
        return false; // 쿠키에 팔로우 상태가 없을 경우 기본값으로 false 반환
    }

    function saveFollowStatusToCookie(isFollowing) {
        // 팔로우 상태를 쿠키에 저장하는 코드를 작성
        const expirationDate = new Date(Date.now() + 365 * 24 * 60 * 60 * 1000); // 쿠키 만료일을 1년 후로 설정
        document.cookie = `followStatus=${isFollowing}; expires=${expirationDate.toUTCString()}; path=/`;
    }
    </script>
    <!-- Preloader Start -->
    <div id="preloader-active">
        <div class="preloader d-flex align-items-center justify-content-center">
            <div class="preloader-inner position-relative">
                <div class="preloader-circle"></div>
                <div class="preloader-img pere-text">
                    <img src="/resources/img/찐막.png" alt="">
                </div>
            </div>
        </div>
    </div>
    <!-- Preloader Start -->

        <!-- Header Start -->

		<c:import url="/WEB-INF/views/temp/header.jsp"></c:import>

        <!-- Header End -->

	<!-- Main start -->
    <main>

        <div>
            <h1 class="a mb-5 text-center">Feed List</h1>
    
            <div id="followList"></div> 
        </div>
    
        <%--
        <c:forEach items="${member}" var="m">
        <div>${m.nickName}</div>
        </c:forEach>
        --%>
        
        <div>
            url : ${member.url}
            toUser :${follow.toUser}
            <c:choose>
                <c:when test="${member.url eq follow.toUser}"></c:when>
                <c:otherwise>
                    <c:if test="${followStatus < 1}">
                    <button type="button" onclick="addFollow()">팔로우</button>
                    </c:if>
                    <c:if test="${followStatus > 0}">
                    <button type="button" onclick="deleteFollow()">삭제</button>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    
        <!-- div.container start -->
        <section>
        <div class="conatiner">
            <input type="hidden" id="page" value="${pager.page}" />
            <!-- div.row g-2 start -->
            <div class="row g-2">
                <!-- kakao map -->
                <div class="container col-md-6">
                    <input type="text" id="adrs"><button id="btn2" type="button">검색</button>
                    <div id="map" style="width:900px;height:700px;float:left;border: solid 1px;margin-right: 300px;"></div>
                        <c:forEach items="${list}" var="d" varStatus="i">
                            <div class="a" data-feedNum="${d.feedNum}" data-contents="${d.contents}" data-title="${d.title}" data-lat="${d.lat}" data-lng="${d.lng}" id="${i.index}"></div>
                        </c:forEach>
    
                        <div id="address"></div>
                    </div>
    
                    <div class="col-md-6">
                        <div id="blogContents" class="row row-cols-md-3 g-3" style="width:100%; height:725px; overflow-y:auto">
                            <c:forEach items="${list}" var="f" varStatus="i">
                            
                            <!-- feedNum hidden처리 -->
                            <input type="hidden" id="feedNum" name="feedNum" value="${f.feedNum}">

                            <!-- 위도/경도 (숨김) -->
                            <input type="hidden" name="lat" id="lat" value="${f.lat}">
                            <input type="hidden" name="lng" id="lng" value="${f.lng}">

                            <!-- tripDate (숨김) -->
                            <input type="hidden" id="tripDate" value="${f.tripDate}">

                                <div>
                                    <div class="card shadow-sm">
                                        <svg class="bd-placeholder-img card-img-top" width="80%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">

                                            <!-- 제목 밑에 있는 회색부분 -->
                                            <rect width="100%" height="100%" fill="#55595c"></rect>

                                            <!-- 이미지 -->
                                            <a id="detailLink" class="text-white link-offset-2 link-underline link-underline-opacity-0" href="../detail?feedNum=${f.feedNum}">
                                                <c:if test="${f.thumbnail == null }">
                                                    <image class="img" href="/resources/img/99A85F3C5C0DC6AD29.jpeg" style="width:100%; height:200px;" />
                                                </c:if>
                                                <c:if test="${f.thumbnail != null }">
                                                    <image class="img" href="/resources/upload/feed/${f.thumbnail}" style="width:100%; height:200px;" />
                                                </c:if>
                                                <text id="title" x="5%" y="95%" fill="#eceeef" dy=".3em">${f.title}</text>
                                            </a>

                                        </svg>

                                        <div class="card-body" style="position:relative; width:100%;">
                                        <small class="text-muted text-start" style="position:relative; float:left;">${f.createDate}</small>
                                        <button type="button" id="likes" style="position:relative; float:right;" class="likesBtn btn-sm btn-outline-secondary justify-content-end">♡ ${f.likes}</button>
                                        <button type="button" id="findMarker" style="position:relative; float:right;" class="showMapbBtn btn-sm btn-outline-secondary justify-content-end">지도보기</button>
                                        </div>

                                        <div style="clear:both"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
    
    
            </div>
            <!-- div.row g-2 end -->
    
        </div>
        <!-- div.container end -->
        </section>
    
    
    
        <!-- 전체 페이지 수 -->
        <input type="hidden" name="totalPage" id="totalPage" value="${pager.totalPage}">
    
        <!-- Pager -->
        <nav class="container" aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <c:if test="${pager.pre}">
                    <li class="page-item"><a class="page-link" href="/feed/list/${url}?page=${pager.startNum-1}">Previous</a></li>
                </c:if>
                <c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
                <li class="page-item move"><a class="page-link" href="/feed/list/${url}?page=${i}&kind=${param.kind}&search=${param.search}">${i}</a></li>
                </c:forEach>
                <c:if test="${pager.next}">
                <li class="page-item move"><a class="page-link" href="/feed/list/${url}?page=${pager.lastNum+1}">Next</a></li>
                </c:if>
            </ul>
        </nav>
    
    
        <!-- 글쓰기 버튼 -->
        <c:if test="${not empty member}">
            <a class="btn btn-primary" href="../add">글쓰기</a>
        </c:if>
    
        <!-- 검색 Search (수정 후) -->
        <!-- Search Box -->
        <div class="row">
            <div class="col-xl-12">
                <!-- form -->
                <form id="searchform" action="/feed/list/${url}" class="search-box" method="get">
                    <div class="select-form mb-30">
                        <div class="select-itms">
                            <select name="kind" id="kind">
                                <option value="">전체</option>
                                <option value="title" ${pager.kind eq "title" ? "selected" : "" }>제목</option>
                                <option value="contents" ${pager.kind eq "kind" ? "selected" : "" }>내용</option>
                            </select>
                        </div>
                    </div>
                    <div class="input-form mb-30">
                        <input type="text" name="search" style="border:solid 1px #e8e8e8;;" value="${pager.search}" />
                    </div>
                    <div class="search-form mb-30">
                        <a href="#" onclick="$('#searchform').submit();">Search</a>
                    </div>   
                </form>   
            </div>
        </div>
    

        <script src="/resources/js/feed/feedListMap.js" defer></script>
        <script src="/resources/js/feed/feedList.js"></script>


    </main>

        <!-- Footer Start-->

		<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

        <!-- Footer End-->


	<!-- JS here -->
	
		<!-- All JS Custom Plugins Link Here here -->
        <script src="/resources/js/index/vendor/modernizr-3.5.0.min.js"></script>
		
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