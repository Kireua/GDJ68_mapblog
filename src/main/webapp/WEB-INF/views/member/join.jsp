<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.x {color: red;}
	.o {color: blue;}
</style>
</head>

<body>
	
	<h1>회원 가입</h1>
	
	<form action="./join" method="POST" id="fr">
		<div>
			<label>ID</label>
			<input type="text" id="id" name="id" placeholder="ID를 입력하세요">
		</div>
		<div id="idResult" class="x">ID를 확인하세요(필수)</div>
		<div>
			<label>PW</label>
			<input type="text" id="pw" name="pw" placeholder="PW를 입력하세요">
		</div>
		<div id="pwResult" class="x">PASSWORD를 확인하세요(필수)</div>
		<div>
			<label>PW 확인</label>
			<input type="text" id="pw2" placeholder="PW를 재입력하세요">
		</div>
		<div id="pw2Result" class="x">PASSWORD 일치 여부를 확인하세요(필수)</div>
		<div>
			<label>NAME</label>
			<input type="text" id="name" name="name" placeholder="NAME을 입력하세요">
		</div>
		<div id="nameResult" class="x">이름을 확인하세요(필수)</div>
		<div>
			<label>NICKNAME</label>
			<input type="text" id="nickName" name="nickName" placeholder="NICKNAME을 입력하세요">
		<div class="o">(닉네임은 필수 아님)</div>
		</div>
		<div>
			<label>EMAIL</label>
			<input type="text" id="email" name="email" placeholder="EMAIL을 입력하세요">
		</div>
		<div id="emailResult" class="x">이메일을 확인하세요(필수)</div>
		<div>
			<label>PHONE</label>
			<input type="text" id="phone" name="phone" placeholder="PHONE#을 입력하세요">
		</div>
		<div class="o">(폰번호는 필수 아님)</div>
		<div>
			<label>BIRTH</label>
			<input type="date" id="birth" name="birth" value="2023-07-23">
		</div>
		<div id="birthResult" class="x">생일을 확인하세요(필수)</div>
		<div>
			<label>PERSONAL URL</label>
			<input type="text" id="url" name="url" placeholder="사용할 URL을 입력하세요">
		</div>
		<div id="urlResult" class="x">URL을 확인하세요(필수)</div>
	</form>
	
	<div class="mb-3">
		<input type="button" class="btn btn-primary" id="btn" value="회원가입"></button>
	</div>

	<script src="../resources/js/members.js"></script>
</body>
</html>