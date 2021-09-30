<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- JSTL Core태그 --%>

<div class="d-flex justify-content-between align-items-center">
	<h2 class="logo m-3 font-weight-bold justify-content-start">Marondalgram</h2>
	<div class="login-info d-flex align-items-center mr-4">
		<%-- session정보가 있는 경우에만 출력 --%>
		<c:if test="${not empty userId}">
			<span class="font-weight-bold">${userName}님 안녕하세요.</span>
			<a href="/user/sign_out" class="font-weight-bold ml-3">로그아웃</a>
		</c:if>
	</div>
</div>