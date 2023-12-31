<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Mapper Admin Main Page</title>
    
    <!-- Kakao Map -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b5744597ccc65933ecad3607daed47e&libraries=services"></script>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/admin/sb-admin-2.min.css" rel="stylesheet">
<c:import url="../../temp/bootStrap.jsp"></c:import>

<style>

</style>

</head>
<body id="page-top">
	

    <!-- Page Wrapper -->
    <div id="wrapper">

	<!-- sidebar 불러오기 -->
	<c:import url="/WEB-INF/views/admin/adminTemp/sidebar.jsp"></c:import>


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->


                <!-- Topbar -->
                <nav>

                    <c:import url="../../temp/adminHeader.jsp"></c:import>

                </nav>
                <!-- End of Topbar -->


			<!-- 페이지별 내용 -->
			<p class="mb-5"></p>
			<section class="container-sm">
		
				<form action="" id="frm">
					<!-- feedNum hidden처리 -->
					<input type="hidden" id="feedNum" name="feedNum" value="${dto.feedNum}">
				</form>
				
				<!-- publics hidden처리 -->
				<input type="hidden" name="publics" value="${dto.publics}">
		
				<input type="hidden" name="id" id="id" value="${dto.id}">
		
				<!-- 위도/경도 (숨김) -->
				<input type="hidden" name="lat" id="lat" value="${dto.lat}">
				<input type="hidden" name="lng" id="lng" value="${dto.lng}">
		
				<!-- url (숨김) -->
				<input type="hidden" name="url" id="url" value="${dto.url}">
		
		
				<p class="col-sm-8 text-start">여행날짜 ${dto.tripDate}</p>
				<p class="display-4">${requestScope.dto.title}</p>
				
				<dl class="row mt-1">
					<dd class="col-sm-2 text-start align-text-bottom mt-1">${dto.id}</dd>
					<dd class="col-sm-8 text-end text-body-tertiary">작성일 ${dto.createDate}</dd>
					<dd class="col-sm-2 text-end">조회수 ${dto.hit}</dd>
				</dl>
		
				<hr class="hr" />
		
				
			<div>
				<div class="card border-white mb-3">
					<pre class="card-body contents text-start" style="font-size:15px; height:300px;">${dto.contents}</pre>
				</div>
		
				<div>
					<c:forEach items="${dto.dtos}" var="f">
						<img alt="${f.originalName}" src="/resources/upload/feed/${f.fileName}">
					</c:forEach>
				</div>
			</div>
		
			<div class="row mt-1">
				<p class="col-sm-11 text-end"></p>
				<button class="btn btn-primary col-sm-1 text-start" id="likes"> 좋아요 ${dto.likes} </button>
			</div>
		
			<hr class="hr" />
		
		
			<div id="commentList"></div>
		
		
		
			

				<button class="btn btn-danger c1" type="button" id="delete" data-url="delete">삭제</button>
				<a class="btn btn-primary" href="./list">목록</a>
		
			
			</section>



			<!-- 페이지별 내용 끝 -->



            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; GDJ68 Mapper 2023</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>




    <!-- Logout Modal-->
  
  
  
  
  
  
  
  	<script type="text/javascript">

		// 좋아요 관련 script
		$(document).on("click", "#likes", function() {
			if ("${sessionScope.member}") {
				$.ajax({
					async:false,
					url:"./addLikes",
					type:"post",
					data:{"feedNum":$("#feedNum").val()},
					dataType:"json",
					success:function(data) {
						$("#likes").text("좋아요 " + data.count);

					},
					error:function(xhr, status, res) {
						console.log("오류 발생", xhr.responseText, status, res);
					}
				});
			} 
		});


	</script>

	<script src="/resources/js/feed/feedDelete.js"></script>
	<script src="/resources/js/feed/feedComment.js"></script>
  

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/admin/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/js/admin/demo/chart-area-demo.js"></script>
    <script src="/resources/js/admin/demo/chart-pie-demo.js"></script>

</body>

</html>