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
		<h1>회원 찾기</h1>
        <form action="./searchMember" method="post" id="fr">

            <div>
                <div>
                    <label>검색 카테고리</label><br>
                    <input type="radio" id="p1" name="category" value="NICKNAME">
                    <label for="p1">닉네임</label>
                    <input type="radio" id="p2" name="category" value="URL" disabled>
                    <label for="p2">개인 URL</label><br>
                </div>
            </div>
            <div>
              <input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요">
            </div>

            <input type="submit" value="검색하기">
        </form>
</body>
</html>