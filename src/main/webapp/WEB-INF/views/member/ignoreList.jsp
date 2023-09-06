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
	
		<table>
			<thead>
				<th>내가 차단한 사람(닉네임)</th>
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
</body>
</html>