package com.marondalgram.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.marondalgram.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {

	private Logger logger = LoggerFactory.getLogger(PostRestController.class);
	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam(value = "content", required = false ) String content,
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request
			) {
		// SNS에서 사진파일은 필수, 내용은 비필수 파라미터
		
		// session 에ㅔ서 userId를 가져온다
		HttpSession session = request.getSession();
		// 세션에 있는 것 : userId, userName, userLoginId
		Integer userId = (Integer) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "error");
		
		// session 풀렸을 때
		if (userId == null) {
			logger.info("[/post/create] userId id null. " + userId);
			//return "redirect:/user/sign_in_view";
			return result;
		}
		
		// DB에 내용 insert BO한테 시킴
		int row = postBO.createPost(userId, userLoginId, userName, content, file);
		if (row > 0) {
			result.put("result", "success");
		} else {
			// row = 0  =>  이미지 업로드 실패
			logger.info("[/post/create] insert false. ");
			return result;
		}
		
		// 결과값 response
		return result;
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId
			) {
		// DB postId에 해당하는 데이터 삭제
		postBO.deletePost(postId);
		
		// 결과 리턴
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
}
