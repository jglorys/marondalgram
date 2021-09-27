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
	
	@RequestMapping("/test3")
	@ResponseBody
	public String test1() {
		return "hello world!!!!!!!!!!!!!!";
	}
	
	@RequestMapping("/test4")
	@ResponseBody
	public List<Map<String, Object>> test2() {
		return testBO.getUserList();
	}
	
}
