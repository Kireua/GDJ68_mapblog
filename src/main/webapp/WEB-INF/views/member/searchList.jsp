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
	
		<h1>검색 결과</h1>
		
		<table id="igo">
			<thead>
				<th>아이디(차단x)</th>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="ar">
				<tr>
					<td><a>${ar.id}</a></td>
					<td><button onclick="location.href='./ignore?ignored=${ar.id}'">차단하기</button></td>
				</tr>			
				</c:forEach>
			</tbody>
		</table><br><br>

		<table id="igx">
			<thead>
				<th>아이디(내가 차단한 사람)</th>
			</thead>
			<tbody>
				<c:forEach items="${ignore}" var="ar">
				<tr>
					<td><a>${ar.ignored}</a></td>
					<td><button onclick="location.href='./ignoreCancle?ignored=${ar.ignored}'">차단해제</button></td>
				</tr>			
				</c:forEach>
			</tbody>
		</table>
<script src="../resources/js/member/searchList.js"></script>
</body>
</html>