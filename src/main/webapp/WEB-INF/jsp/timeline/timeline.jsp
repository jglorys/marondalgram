<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- JSTL Core태그 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- JSTL Formatting --%>


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
		<c:forEach items="${contentList}" var="content">
		
			<%-- 카드 하나하나마다 영역을 border로 나눔 --%>
			<div class="card border rounded mt-3 bg-light">

				<%-- 글쓴이 아이디 및 ... 버튼(삭제) :  이 둘을 한 행에 멀리 떨어뜨려 나타내기 위해 d-flex, between --%>
				<div class="p-2 d-flex justify-content-between">
					<div>
						<%-- 프로필 사진 및 userName --%>
						<img src="${content.user.imageUrl}" width="50">
						<span class="font-weight-bold">${content.post.userName}</span>
					</div>
					
					<%-- 클릭할 수 있는 ... 버튼 이미지 --%>
					<%-- 로그인 된 사용자가 작성한 경우에만 버튼 노출 --%>
					<%-- 삭제될 글번호를 modal창에 넣기 위해 더보기 클릭시 이벤트에서 심어준다 / 세션에 있는건 jsp에서 그냥 가져다쓰면됨!!!--%>
					<c:if test="${userName eq content.post.userName}">
						<%-- data-toggle  /  data-target만 있으면 된다! --%>
						<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-post-id="${content.post.id}"> 
							<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
						</a>
					</c:if>
				</div>
		
				<%-- 카드 이미지 --%>
				<div class="card-img">
					<img
						src="${content.post.imagePath}"
						class="w-100">
				</div>

				<%-- 좋아요 & createdAt --%>
				<div class="d-flex justify-content-between">
					<%-- 비워진 하트 --%>
					<c:if test="${content.likeYn eq false}">
					<div class="card-like m-3">
						<c:if test="${not empty userId}">
							<a href="#"  class="like-btn" data-post-id="${content.post.id}">
							<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="18px" height="18px"></a>
						</c:if>
							좋아요 <span>${content.likeCount}</span>
					</div>
					</c:if>
					<%-- 채워진 하트 --%>
					<c:if test="${content.likeYn eq true}">
					<div class="card-like m-3">
						<c:if test="${not empty userId}">
							<a href="#"  class="like-btn" data-post-id="${content.post.id}">
							<img src="https://www.iconninja.com/files/527/809/128/heart-icon.png" width="18px" height="18px"></a>
						</c:if>
							좋아요 <span>${content.likeCount}</span>
					</div>
					</c:if>
					
					<%-- 작성 날짜 --%>
					<div class="card-createdAt m-3">
						<fmt:formatDate value="${content.post.createdAt}" pattern="yyyy년MM월dd일 HH시mm분"/>
					</div>
				</div>

				<%-- 글(Post) : 내용이 있을때에만 userName이랑 내용보이게 --%>
				<c:if test="${not empty content.post.content}">
					<div class="card-post m-3">
						<span class="font-weight-bold">${content.post.userName}</span>
						<span>${content.post.content}</span>
					</div>
				</c:if>
				<%-- 댓글(Comment) --%>

				<div class="card-comment-desc border-bottom">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				<div class="card-comment-list m-2">
					<%-- 댓글 목록 --%>
					<%-- content -> commentList  (for each) 돌려서 --%>
					<c:forEach items="${content.commentList}" var="comment">
						<div class="card-comment m-1">
							<span class="font-weight-bold">${comment.userName} : </span>
							<span>${comment.content}</span>
	
							<%-- 댓글쓴이가 본인이면 삭제버튼 노출 --%>
							<c:if test="${userName eq comment.userName}">
							<a href="#" class="commentDelBtn" data-comment-id="${comment.id}"> 
								<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px">
							</a>
							</c:if>
						</div>
					</c:forEach>
				</div>

				<%-- 댓글 쓰기 --%>
				<%-- 로그인 된 상태에서만 쓸 수 있다. --%>
				<c:if test="${not empty userId}">
					<div class="comment-write d-flex border-top mt-2">
						<input type="text" class="form-control border-0 mr-2"  id="commentText${content.post.id}" placeholder="댓글 달기" />
						<button type="button" class="btn btn-light commentBtn" data-post-id="${content.post.id}">게시</button>
					</div>
				</c:if>
			</div>
			</c:forEach>
		</div>
		
	</div>
</div>



<!-- Modal(data-target과 id가 연결됨) -->
<div class="modal fade" id="moreModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    	<%-- 삭제하기 버튼눌렀을때 서버로 리퀘스트 --%>
     	<a href="#" class="btn btn-warning del-post">삭제하기</a> 
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
	
	// ... 버튼 클릭
	$('.more-btn').on('click', function(e){
		e.preventDefault();
		// 모달이 띄워질때,
		// 지금 클릭된 태그의 postId를 가져온다.  $('.more-btn').data 해서 가져오면, 첫번째 클래스에 있는 postId만 가져오게 됨!!!!
		let postId = $(this).data('post-id');
		//alert(postId);
		
		// 모달에 postId를 넣어준다. => 태그에 셋팅을 해준다
		$('#moreModal').data('post-id', postId);
		
	});
	
	//모달안에 있는 삭제하기 클릭
	$('#moreModal .del-post').on('click', function(e){
		e.preventDefault();
		
		// #moreModel에 심어놓은 post-id
		let postId = $('#moreModal').data('post-id');
		//alert(postId);
		
		// 서버한테 글 삭제 요청(ajax)
		$.ajax({
			type : 'delete',
			url : '/post/delete',
			data : {'postId':postId},
			success : function(data) {
				if (data.result == 'success') {
					// 삭제했으면 새로고침
					alert("게시물이 삭제되었습니다.");
					location.reload(); //새로고침
				}
			},
			error : function(e) {
				alert("게시물을 삭제하는데 실패했습니다." + e);
				location.reload();
			}
		});
		
	});
	
	
	// 댓글 쓰기 - 어떤 postId가 넘어오는지 알아야한다. 
	$('.commentBtn').on('click', function(e) {
		e.preventDefault(); // 기본 동작 중단
		// 게시글 번호
		let postId = $(this).data('post-id');
		//alert(postId);
		
		// #CommentText글번호
		// 글에 대한 댓글을 가져오기 위해 아이디 뒤에 동적으로 postId를 붙인다.
		let commentContent = $('#commentText' + postId).val().trim(); // trim :앞뒤공백 제거
		if (commentContent.length < 1) {
			alert("댓글을 입력해주세요.");
			return;
		}
		
		//form 태그를 자바스크립트에서 만든다. =======>>>> 왜오류????
		let formData = new FormData();
		formData.append('content', commentContent);
		formData.append('postId', postId);
		
		//ajax
		$.ajax({
			type : 'post',
			url : '/comment/create',
			data : formData,
			processData: false,	// formData전송시 필수
			contentType: false,  // formData전송시 필수 -----여기까지가 request를 위한 설정
			success : function(data) {
				if (data.result == 'success') {
					//alert("댓글 작성 완료");
					location.reload(); //새로고침
				}
			},
			error : function(e) {
				alert("댓글작성 실패" + e);
				location.reload(); //새로고침
			}
		});
	});
	
	// 댓글 삭제
	$('.commentDelBtn').on('click', function(e) {
		e.preventDefault();
		
		let commentId = $(this).data("comment-id");
		//alert(commentId);
		
		$.ajax({
			type:'POST',
			url:'/comment/delete',
			data: {"commentId":commentId},
			success: function(data) {
				if (data.result == 'success') {
					//alert("댓글이 삭제되었습니다.");
					location.reload(); // 새로고침
				}
			},
			error: function(e) {
				alert("댓글 삭제 실패" + e);
				location.reload();
			}
		});
	});
	
	// 좋아요
	$('.like-btn').on('click', function(e){
		e.preventDefault();
		
		// 내가 좋아요 한 애를 가져와야함 - this!!!! .like-btn으로 뽑으면 처음애만 나옴
		let postId = $(this).data('post-id');
		
		$.ajax({
			type: 'post'
			, url: '/like/' + postId
			, success: function(data) {
				if (data.result == 'success') {
					location.reload(true); //새로고침 true안넣어도됨
				}
			}, error: function(e) {
				alert("좋아요 기능 오류" + e);
				location.reload();
			}
			
		});
		
	});
	
	
});




</script>