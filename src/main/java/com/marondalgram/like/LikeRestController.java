package com.marondalgram.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.marondalgram.like.bo.LikeBO;

@RequestMapping("/like")
@RestController
public class LikeRestController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private LikeBO likeBO;

	// 동적으로 postId가 들어간다
	@PostMapping("/{postId}")
	public Map<String, Object> postLike(@PathVariable int postId, HttpServletRequest request) {
		// 글번호(@PathVariable), 유저번호(세션)
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		Map<String, Object> result = new HashMap<>();

		// userId는 null이면 쿼리문에러남 => null검사해야한다.
		
		 if (userId == null) { 
			 result.put("result", "error");
			 logger.error("[like error] 좋아요 로그인세션이 없습니다.");
			 return result; 
		}
		  
		 
		likeBO.like(userId, postId);

		result.put("result", "success");
		return result;
	}
}
