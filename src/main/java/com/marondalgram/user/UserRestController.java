package com.marondalgram.user;

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

import com.marondalgram.common.EncryptUtils;
import com.marondalgram.user.bo.UserBO;
import com.marondalgram.user.model.User;


@RequestMapping("/user")
@RestController
public class UserRestController {
	
	private Logger logger = LoggerFactory.getLogger(UserRestController.class);
	
	@Autowired
	private UserBO userBO;
	
	/**
	 * loginId 중복 여부 확인
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplicatedID(
			@RequestParam("loginId") String loginId
			) {
		//loginId 중복 여부 DB조회
		userBO.existLoginId(loginId); //저장된건 boolean
		
		//중복여부에 대한 결과 map생성
		Map<String, Boolean> result = new HashMap<>();
		result.put("result", userBO.existLoginId(loginId));
		
		return result;
	}
	
	
	/**
	 * 회원가입
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		//비밀번호 해싱
		String encryptPassword = EncryptUtils.md5(password);
		
		// DB user insert
		int row = userBO.addNewUser(loginId, encryptPassword, name, email);
		
		//insert성공했다면 row=1
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		// 응답값 생성 후 리턴
		return result;
	}
	
	
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request
			){
		//HttpServletRequest request는 세션을 위해!
		
		// 파라미터로 받은 비밀번호를 해싱한다.
		String encryptPassword = EncryptUtils.md5(password);
		
		// id와 해싱된 password로 DB SELECT
		User user = userBO.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		if (user != null) {
			// 있으면 로그인 성공
			result.put("result" , "success");
			
			//로그인 상태 유지 = 세션
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userImage", user.getImageUrl());
			// Controller / jsp 에서 사용가능 
			// -> 로그인이 되어있으면 .getAttribute해서 키이름으로 꺼냄 / ${userName}으로 jsp에서 꺼내서 사용가능
		} else {
			//없으면 로그인 실패
			result.put("result", "error");
		}
		return result;	
	}
	
	@PostMapping("/profile")
	public Map<String, Object> changeUserProfile(
			@RequestParam("userName") String userName,
			@RequestParam(value="introduce", required=false) String introduce,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		Map<String, Object> result = new HashMap<>();
		Integer userId = (Integer) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		if (userId == null) {
			logger.error("[/user/profile] 로그인 세션이 없습니다.");
			result.put("result", "error");
			return result;
		}
		
		userBO.updateUser(userId, userLoginId, userName, introduce, file);
		result.put("result", "success");	
		
		// 세션에 담긴 유저이름 변경
		User changedUser = userBO.getUser(userId);
		session.setAttribute("userName", changedUser.getName());
		session.setAttribute("userImage", changedUser.getImageUrl());
		return result;
	}
	
	
	
	
	
	
	
	
}
