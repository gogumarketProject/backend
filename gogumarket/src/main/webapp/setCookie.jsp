<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <title>Redirecting...</title>
</head>
<body>
    <script type="text/javascript">
        // 자바스크립트로 쿠키 설정
        document.cookie = "access_token=<%= request.getAttribute("accessToken") %>; path=/; max-age=1800; secure; HttpOnly";
        
        // 페이지 리다이렉트
        window.location.href = "<%= request.getAttribute("redirectUrl") %>";
    </script>
</body>
</html>