package com.marondalgram.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.marondalgram.user.bo.UserBO;
import com.marondalgram.user.model.User;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserBO userBO;
	
	/**
	 * 회원가입 View
	 * @param model
	 * @return
	 */
	// Path(URL): /user/sign_up_view
	@RequestMapping("/sign_up_view")
	public String signUpView(Model model) {
		
		model.addAttribute("viewName", "user/sign_up");
		return "template/layout";
	}
	
	/**
	 * 로그인 View
	 * @param model
	 * @return
	 */
	// Path(URL): /user/sign_in_view
	@RequestMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/sign_in");
		return "template/layout";
	}
	
	@RequestMapping("/sign_out")
	public String signOutView(HttpServletRequest request) {
		//session을 가져와서 로그아웃 
		HttpSession session = request.getSession();
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userImage");
		
		// redirect : 완전히 다른 화면으로 보냄
		return "redirect:/user/sign_in_view";
	}
	
	@RequestMapping("/profile_view")
	public String profileChangeView(
			Model model,
			HttpServletRequest request
			) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = userBO.getUser(userId);
		model.addAttribute("user", user);
		model.addAttribute("viewName", "user/profile");
		return "template/layout";
	}
}
