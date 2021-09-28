package com.marondalgram.test;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.marondalgram.test.bo.TestBO;

@Controller
public class TestController {
	
	@Autowired
	private TestBO testBO;
	
	@RequestMapping("/test2_1")
	@ResponseBody
	public String test1() {
		return "hello world!!!!!!!!!!!!!!";
	}
	
	@RequestMapping("/test2_2")
	@ResponseBody
	public List<Map<String, Object>> test2() {
		return testBO.getUserList();
	}
	
	//JSP 연동
	@RequestMapping("/test2_3")
	public String test3() {
		return "test/test";
	}
	
}
