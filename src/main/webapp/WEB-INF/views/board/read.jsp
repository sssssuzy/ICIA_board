<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>게시글 보기</title>
</head>
<body>
<h1>게시물 보기</h1>
<div><button onClick="location.href='list'">목록</button></div>
	<div>
		<div>제목 : ${vo.title} </div>
		<div>작성자 : ${vo.writer} </div>
		<div>내용 : ${vo.content}</div>
	</div>
	<hr/>
	<jsp:include page="../reply/list.jsp"/>
</body>
<script>
</script>
</html>