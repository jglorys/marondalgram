<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="shadow-box m-5">
		<h2 class="text-center">LOGIN</h2>
		<div class="d-flex justify-content-center m-5">
			<%-- 키보드 Enter키로 로그인이 될 수 있도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>
			
			<form id="loginForm" action="/user/sign_in" method="post">
				<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">ID</span>
					</div>
					<input type="text" class="form-control" name="loginId">
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">PW</span>
					</div>
					<input type="password" class="form-control" name="password">
				</div>
				
				<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. 한 행을 쭉 차지하게됨--%>
				<input type="submit" class="btn btn-block btn-info" value="로그인">
				<a class="btn btn-block btn-secondary" href="/user/sign_up_view">회원가입</a>
			</form>
		</div>
	</div>
</div>

<script>
	
	$(document).ready(function(){
		$('#loginForm').submit(function(e){
			e.preventDefault();
			
			//validation
			let loginId = $('input[name=loginId]').val().trim();
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return false; //submit 에대해 return false라는 뜻
			}
			
			let password = $('input[name=password]').val();
			if (password == '') {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			// <form id="loginForm" action="/user/sign_in" method="post">
			let url = $('#loginForm').attr('action');
			let data = $('#loginForm').serialize();
			//console.log("url:" + url);
			//console.log("data:" + data);
			
			//$.post(url, data).done(function(data){     ....  });
			$.post(url, data)
			.done(function(data){
				if (data.result == 'success') {
					location.href = '/timeline/timeline_view';
				} else {
					alert("로그인에 실패했습니다. 다시 시도해주세요.");
				}
			});
			
			
		});
	});




</script>



