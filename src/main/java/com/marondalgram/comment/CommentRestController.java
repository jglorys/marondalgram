package com.marondalgram.comment;


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

import com.marondalgram.comment.bo.CommentBO;

@RestController
@RequestMapping("/comment")
public class CommentRestController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CommentBO commentBO;
	
	@PostMapping("/create")
	public Map<String, Object> createComment(
			@RequestParam("postId") int postId,
			@RequestParam("content") String content,
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		Map<String, Object> result = new HashMap<>();
		
		Integer userId = (Integer) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");
		if (userId == null || userName == null) {
			result.put("result", "error");
			logger.error("[댓글 쓰기] 로그인 세션이 없습니다.");
			return result;
		}
		
		commentBO.createComment(postId, userId, userName, content);
		result.put("result", "success");
		
		return result;
	}
	
	@PostMapping("/delete")
	public Map<String, Object> deleteComment(
			@RequestParam("commentId") int commentId
			) {
		Map<String, Object> result = new HashMap<>();
		
		commentBO.deleteComment(commentId);
		result.put("result", "success");
		return result;
	}
	
}
