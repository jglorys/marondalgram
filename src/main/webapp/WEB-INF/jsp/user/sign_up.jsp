<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h2 class="m-3 font-weight-bold">회원 가입</h2>
		<form id="signUpForm" method="post" action="/user/sign_up" class=" p-4">
			<span class="sign-up-subject ml-2">ID</span>
			<div class="d-flex">
				<input type="text" id="loginId" name="loginId" class="form-control mt-2"
					placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn"
					class="btn btn-primary ml-4">중복확인</button>
			</div>
			
			<%-- 아이디 체크 결과--%>
			<%-- d-none클래스 : display none (보이지 않게 숨겨줌) --%>
			<div id="idCheckLength" class="small text-danger d-none">ID를
							4자 이상 입력해주세요.</div>
			<div id="idCheckDuplicated" class="small text-danger d-none">이미
							사용중인 ID입니다.</div>				
			<div id="idCheckOk" class="small text-success d-none">사용 가능한
							ID 입니다.</div>
			
			
			<span class="sign-up-subject ml-2">password</span>
			<div>
				<input type="password" id="password" name="password" class="form-control mt-2"
					placeholder="비밀번호를 입력해주세요">
			</div>

			<span class="sign-up-subject ml-2">confirm password</span>
			<div>
				<input type="password" id="confirmPassword" name="confirmPassword"
					class="form-control mt-2" placeholder="비밀번호를 다시 입력해주세요">
			</div>

			<span class="sign-up-subject ml-2">이름</span>
			<div>
				<input type="text" id="name" name="name" class="form-control mt-2"
					placeholder="이름을 입력해주세요">
			</div>

			<span class="sign-up-subject ml-2">이메일</span>
			<div>
				<input type="text" id="email" name="email" class="form-control mt-2"
					placeholder="이메일을 입력해주세요">
			</div>
			<br>
			<div class="d-flex justify-content-center">
				<button type="button" id="signUpBtn" class="btn btn-primary">가입하기</button>
			</div>

		</form>
	</div>

</div>

<script>
	$(document).ready(function(){
		
		//아이디 중복 확인
		$('#loginIdCheckBtn').on('click', function(e){
			let loginId = $('input[name=loginId]').val().trim();
			
			//alert(loginId);
			
			//idCheckLength, idCheckDuplicated, idCheckOk
			if (loginId.length < 4) {
				$('#idCheckLength').removeClass('d-none');
				$('#idCheckDuplicated').addClass('d-none');
				$('#idCheckOk').addClass('d-none');
				return;
			}
			
			//ajax 서버 호출(중복여부)
			$.ajax({
				type : 'get',
				url : '/user/is_duplicated_id',
				data : {'loginId' : loginId},
				success : function(data) {
					//alert(data.result);
					
					if (data.result) {
						//중복이다
						$('#idCheckLength').addClass('d-none');
						$('#idCheckDuplicated').removeClass('d-none');
						$('#idCheckOk').addClass('d-none');
					} else {
						//중복이 아니다 => idCheckOk 에서 d-none제거
						$('#idCheckLength').addClass('d-none');
						$('#idCheckDuplicated').addClass('d-none');
						$('#idCheckOk').removeClass('d-none');
					}
				},
				error : function(e) {
					alert("아이디 중복 확인에 실패 했습니다. 관리자에게 문의해주세요.")
				}
			});
		});
		
		
		//signUpBtn
		$('#signUpBtn').on('click', function(){
			
			//validation check
			// 아이디 입력 안했을때
			let loginId=$('#loginId').val().trim();
			if (loginId == '') {
				alert("아이디를 입력하세요");
				return;
			}
			// 비밀번호 입력 안했을때
			let password=$('#password').val();
			let confirmPassword=$('#confirmPassword').val();
			if (password == '' || confirmPassword =='') {
				alert("비밀번호를 입력하세요");
				return;
			}
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				// 일치하지 않을 때 공백으로 만들어줌
				$('#password').val(''); 
				$('#confirmPassword').val(''); 
				return;
			}
			//이름 입력 안했을때
			let name=$('#name').val().trim();
			if (name == '') {
				alert("이름을 입력하세요");
				return;
			}
			//이메일 입력 안했을때
			let email=$('#email').val().trim();
			if (email == '') {
				alert("이메일을 입력하세요");
				return;
			}
			
			// 모든 validation체크 완료!! => 서버에 요청하자!!!
			
			//<form id="signUpForm" method="post" action="/user/sign_up" class=" p-4">
			//이 ajax방식은 url, data넣음!  $.post(url, data).done(function(data){     ....  });
			let url = $('#signUpForm').attr('action'); //attr:함수의 속성을 가져올 때 사용
			let data = $('#signUpForm').serialize();
			
			$.post(url, data)
			.done(function(data){
				if (data.result == 'success') {
					alert("가입이 완료되었습니다! 로그인 해주세요.");
					location.href="/user/sign_in_view";
				} else {
					alert("가입에 실패했습니다.");
				}
				
			});
		});
	});
</script>
