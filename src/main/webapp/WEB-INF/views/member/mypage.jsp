<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1 class="my-4">마이페이지</h1>
	<div>
		<p>
			아이디 : ${member.id}
		</p>
		<p>
			이름 : ${member.name}
		</p>
		<p>
			닉네임 : ${member.nickName}
		</p>
		<p>
			이메일 : ${member.email}
		</p>
		<p>
			폰번호 : ${member.phone}
		</p>
		<p>
			생일 : ${member.birth}
		</p>
		<p>
			개인 URL : ${member.url}
		</p>
		
		<a href="./update">회원수정</a>
		<form action="./delete" id="fr2">
			<input type="button" id="dm" value="회원탈퇴">
		</form>
	</div>

	<script>
		const dm = document.getElementById("dm")
		const fr2 = document.getElementById("fr2")

		dm.addEventListener('click', function(){
			if (confirm("회원 탈퇴하시겠습니까?")) {
            	fr2.submit();
        	}
		})
	</script>
</body>
</html>