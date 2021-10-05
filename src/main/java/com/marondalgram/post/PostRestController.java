package com.marondalgram.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
		
		if (userId == null) {
			logger.info("[/post/create] userId id null. " + userId);
			//return "redirect:/user/sign_in_view";
			return result;
		}
		
		// DB에 내용 inssert BO한테 시킴
		int row = postBO.createPost(userId, userLoginId, userName, content, file);
		if (row > 0) {
			result.put("result", "success");
		}
		
		// 결과값 response
		return result;
	}
}
