<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- JSTL Core태그 --%>


<div class="d-flex justify-content-center">
	<div class="contents-box">
		<%-- 글쓰기 영역 - 로그인 된 상태에서만 보이도록 --%>
		<c:if test="${not empty userId}">
			<%-- textarea의 테두리는 없애고 div에 테두리를 준다. --%>
			<div class="write-box border rounded m-3">
				<textarea id="writeTextArea" placeholder="내용을 입력해주세요."
					class="w-100 border-0"></textarea>

				<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
				<div class="d-flex justify-content-between">
					<div class="file-upload">
						<%-- file태그는 숨겨두고 이미지를 클릭하면 file태그를 클릭한 것처럼 이벤트를 줄 것임 --%>
						<input type="file" id="file" class="d-none"
							accept=".gif, .jpg, .png, .jpeg">
						<%-- 이미지에 마우스를 올리면 마우스 커서가 링크커서 변하도록 a태그 사용 --%>
						<a href="#" id="fileUploadBtn"><img width="35" class="m-2"
							src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
						<%-- 업로드 된 임시 파일 이름 저장될곳 --%>
						<div id="fileName" class="ml-2"></div>
					</div>
					
					<button id="writenBtn" class="btn btn-info m-2">게시</button>
				</div>
			</div>
		</c:if>

		<%-- 타임라인 영역 --%>
		
		<%-- my: margin 위아래(y축) --%>
		<div class="timeline-box my-5">
		<%-- forEach로 하나씩 카드 만들자!!!! --%>
		<c:forEach items="${postList}" var="post">
		
			<%-- 카드 하나하나마다 영역을 border로 나눔 --%>
			<div class="card border rounded mt-3 bg-light">

				<%-- 글쓴이 아이디 및 ... 버튼(삭제) :  이 둘을 한 행에 멀리 떨어뜨려 나타내기 위해 d-flex, between --%>
				<div class="p-2 d-flex justify-content-between">
					<span class="font-weight-bold">${post.userName}</span>

					<%-- 클릭할 수 있는 ... 버튼 이미지 --%>
					<a href="#" class="more-btn"> <img
						src="https://www.iconninja.com/files/860/824/939/more-icon.png"
						width="30">
					</a>
				</div>
		
				<%-- 카드 이미지 --%>
				<div class="card-img">
					<img
						src="${post.imagePath}"
						class="w-100">
				</div>

				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#"><img
						src="https://www.iconninja.com/files/527/809/128/heart-icon.png"
						width="18px" height="18px"></a> <a href="#">좋아요 11개</a>
				</div>

				<%-- 글(Post) --%>
				<div class="card-post m-3">
					<span class="font-weight-bold">${post.userName}</span>
					<span>${post.content}</span>
				</div>
				<%-- 댓글(Comment) --%>

				<div class="card-comment-desc border-bottom">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				<div class="card-comment-list m-2">
					<%-- 댓글 목록 --%>
					<div class="card-comment m-1">
						<span class="font-weight-bold">sdfsdf : </span> <span> 분류가
							잘 되었군요~</span>

						<%-- TODO: 댓글쓴이가 본인이면 삭제버튼 노출 --%>
						<a href="#" class="commentDelBtn"> <img
							src="https://www.iconninja.com/files/603/22/506/x-icon.png"
							width="10px" height="10px">
						</a>
					</div>

					<div class="card-comment m-1">
						<span class="font-weight-bold">coffee : </span> <span>
							철이 없었죠 분류를 위해 클러스터를 썼다는게</span>

						<%-- TODO: 댓글쓴이가 본인이면 삭제버튼 노출 --%>
						<a href="#" class="commentDelBtn"> <img
							src="https://www.iconninja.com/files/603/22/506/x-icon.png"
							width="10px" height="10px">
						</a>
					</div>
				</div>

				<%-- 댓글 쓰기 --%>
				<%-- 로그인 된 상태에서만 쓸 수 있다. --%>
				<c:if test="${not empty userId}">
					<div class="comment-write d-flex border-top mt-2">
						<input type="text" id="commentText"
							class="form-control border-0 mr-2" placeholder="댓글 달기" />
						<button type="button" class="btn btn-light commentBtn">게시</button>
					</div>
				</c:if>
			</div>
			</c:forEach>
		</div>
		
	</div>
</div>



<script>
$(document).ready(function(){
	// 파일 업로드 이미지 버튼 클릭 => 파일 선택 창이 뜸
	$('#fileUploadBtn').on('click', function(e){
		e.preventDefault(); // 제일 위로 올라가는 동작(a태그 성질) 중지
		$('#file').click(); // 사용자가 input file을 클릭한 것과 같은 동작
	});
	
	// 사용자가 파일을 선택 했을 때 => 파일 명을 옆에 노출시킴
	$('#file').on('change', function(e) {
		// change가 일어났다는 것은 이미 파일이 올라갔다는 것임
		// 사용자가 선택한 사진 정보 자체가 e 에 들어있음
		let fileName = e.target.files[0].name; //지금업로드된 파일의 이름을 가져옴
		//console.log("fileName: " + fileName);
		
		// 확장자 체크 (validation check)
		let fileNameArr = fileName.split('.');
		if (fileNameArr[fileNameArr.length - 1] != 'png'
				&& fileNameArr[fileNameArr.length - 1] != 'gif'
				&& fileNameArr[fileNameArr.length - 1] != 'jpg'
				&& fileNameArr[fileNameArr.length - 1] != 'jpeg'
				) {
			alert("이미지 파일만 업로드 할 수 있습니다.");
			// 걸렸으면 선택돼서 올라간 파일을 지워줘야함
			$(this).val('');
			$('#fileName').text(''); //잘못된 파일명도 비워준다.
			return;
		}
		
		$('#fileName').text(fileName); //파일 명을 div사이에 노출시킨다.
	});
	
	// 게시 버튼 클릭
	$('#writenBtn').on('click', function(){
		let content = $('#writeTextArea').val();
		let file = $('#file').val(); //파일의 이름을 가지고옴
		// 확장자 체크는 파일을 선택했을때 위에서 이미 했으므로 패스
		if (file == '') {
			alert("이미지를 선택해주세요.");
			return;
		}
		
		// form 태그를 자바스크립트에서 만듬
		let formData = new FormData();
		formData.append('content' , content);
		formData.append('file', $('#file')[0].files[0]);
		//$('#file')[0].files[0] ==> 진짜 파일이 담겨짐 , 컨트롤러에서는 멀티파트파일로 받을것
		
		//ajax
		$.ajax({
			type : 'post',
			url : '/post/create',
			data : formData,
			enctype: 'multipart/form-data',	// 파일 업로드 필수 설정
			processData: false,	// 파일 업로드 필수 설정
			contentType: false,  // 파일 업로드 필수 설정 -----여기까지가 request를 위한 설정
			success : function(data) {
				if (data.result == 'success') {
					alert("게시글 업로드 완료");
					location.reload(); //새로고침
				}
			},
			error : function(e) {
				alert("게시글 업로드 실패" + e);
			}
		});
	});
	
	// 댓글 쓰기
	
	
	
});




</script>