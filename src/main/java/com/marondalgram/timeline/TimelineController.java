package com.marondalgram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.marondalgram.post.bo.PostBO;
import com.marondalgram.post.model.Post;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	private Logger logger = LoggerFactory.getLogger(TimelineController.class);
	
	@Autowired
	private PostBO postBO;
	
	
	@RequestMapping("/timeline_view")
	public String timelineView(Model model, HttpServletRequest request) {
		
		//글 목록들을 가져온다 => 모델에 담는다.
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");// 아주작은확률로 세션이 풀려서 null일 수 있으므로 Integer
		if (userId == null) {
			logger.info("[timeline_view] userId is null. " + userId);
			return "redirect:/user/sign_in_view";
		}
		// 모든 유저의 게시물들을 다 가져옴 -> parameter없음
		List<Post> postList = postBO.getPostList();
		
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}
