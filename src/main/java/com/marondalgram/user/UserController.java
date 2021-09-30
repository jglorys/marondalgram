package com.marondalgram.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

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
		session.removeAttribute("userID");
		session.removeAttribute("userName");
		session.removeAttribute("userLoginId");
		
		// redirect : 완전히 다른 화면으로 보냄
		return "redirect:/user/sign_in_view";
	}
}
