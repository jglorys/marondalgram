<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>

</head>
<body>
	<div class="d-flex justify-content-center">
		<div class="sign-up-box">
			<h2 class="m-3 font-weight-bold">회원 가입</h2>
			<form id="signUpForm" method="post" action="" class=" p-4">
				<span class="sign-up-subject ml-2">ID</span>
				<div class="d-flex">
					<input type="text" name="loginId" class="form-control mt-2" placeholder="ID를 입력해주세요">
					<button type="button" id="loginIdCheckBtn" class="btn btn-primary ml-4">중복확인</button>
				</div>

				<span class="sign-up-subject ml-2">password</span>
				<div>
					<input type="password" name="password" class="form-control mt-2" placeholder="비밀번호를 입력해주세요">
				</div>

				<span class="sign-up-subject ml-2">confirm password</span>
				<div>
					<input type="password" name="confirmPassword" class="form-control mt-2" placeholder="비밀번호를 다시 입력해주세요">
				</div>

				<span class="sign-up-subject ml-2">이름</span>
				<div>
					<input type="text" name="name" class="form-control mt-2" placeholder="이름을 입력해주세요">
				</div>

				<span class="sign-up-subject ml-2">이메일</span>
				<div>
					<input type="text" name="email" class="form-control mt-2" placeholder="이메일을 입력해주세요">
				</div>
				
				<br>
				<div class="d-flex justify-content-center">
					<button type="button" id="signUpBtn" class="btn btn-primary">가입하기</button>
				</div>
				
			
			</form>
		
		</div>
	
	
	
	</div>

</body>
</html>