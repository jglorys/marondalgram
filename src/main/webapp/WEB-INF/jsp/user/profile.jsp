<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- JSTL Core태그 --%>

<div class="d-flex justify-content-center">
	<div class="shadow-box m-5">
		<h2 class="text-center">프로필 설정</h2>
		<div  id="profileForm">
			<%-- 키보드 Enter키로 변경 가능하도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>
				<div class="h-25 p-4">
					<span class="font-weight-bold m-2">사용자 이름</span>
					<div>
						<input type="text" id="profileName" class="form-control m-2 w-75"
							value="${user.name}">
					</div>
				</div>
				
				<div class="h-25 p-4">
					<span class="font-weight-bold m-2">자기소개</span>
					<div>
						<textarea class="profileIntroduce form-control m-2 w-75">${user.introduce}</textarea>
					</div>
				</div>
				
				<div class="h-25 p-4">
					<span class="font-weight-bold m-2">프로필사진 선택</span>
					<%-- file태그는 숨겨두고 이미지를 클릭하면 file태그를 클릭한 것처럼 이벤트를 줄 것임 --%>
					<input type="file" id="profileFile" class="d-none" accept=".gif, .jpg, .png, .jpeg">
					<%-- 이미지에 마우스를 올리면 마우스 커서가 링크커서 변하도록 a태그 사용 --%>
					<a href="#" id="profileFileUploadBtn">파일 선택</a>
					<%-- 업로드 된 임시 파일 이름 저장될곳 --%>
					<div id="profileImgFileName" class="ml-2">${user.imageUrl}</div>
				</div>
				<div class="d-flex justify-content-center">
					<button id="profileUpdateBtn" class="btn btn-info">프로필 수정 완료</button>
				</div>

		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	// 파일 업로드 클릭 => 파일 선택 창이 뜸
	$('#profileFileUploadBtn').on('click', function(e){
		e.preventDefault();
		$('#profileFile').click();
	});
	
	// 사용자가 파일을 선택 했을 때 -> 파일 명을 옆에 노출시킨다
	$('#profileFile').on('change', function(e){
		let fileName = e.target.files[0].name;
		//console.log("fileName: " + fileName);
		
		
		//확장자 체크 (validation check)
		let fileNameArr = fileName.split('.');
		if (fileNameArr[fileNameArr.length - 1] != 'png'
				&& fileNameArr[fileNameArr.length - 1] != 'gif'
				&& fileNameArr[fileNameArr.length - 1] != 'jpg'
				&& fileNameArr[fileNameArr.length - 1] != 'jpeg'
				) {
			alert("이미지 파일만 업로드 할 수 있습니다.");
			$(this).val('');
			$('#profileImgFileName').text('');
			return;
		}
		
		$('#profileImgFileName').text(fileName);
	});
	
	// 프로필 수정 버튼 클릭시
	$('#profileUpdateBtn').on('click', function(){
		let userName = $('#profileName').val().trim();
		let introduce = $('.profileIntroduce').val().trim();
		
		if (userName == '') {
			alert("사용자 이름을 입력해주세요.");
			location.reload();
			return false;
		}
		
		let formData = new FormData();
		formData.append('userName', userName);
		formData.append('introduce', introduce);
		formData.append('file', $('#profileFile')[0].files[0]);
		
		$.ajax({
			type: 'post',
			url: '/user/profile',
			data: formData,
			enctype: 'multipart/form-data',	// 파일 업로드 필수 설정
			processData: false,	// 파일 업로드 필수 설정
			contentType: false,  // 파일 업로드 필수 설정 -----여기까지가 request를 위한 설정
			success : function(data) {
				if (data.result == 'success') {
					alert("프로필 업데이트 완료");
					location.reload();
				}
			},
			error : function(e) {
				alert("프로필 변경 실패" + e);
				location.reload();
			}
		});
		

	});
	
});





</script>