package com.marondalgram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.marondalgram.common.EncryptUtils;
import com.marondalgram.user.bo.UserBO;


@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	
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
}
