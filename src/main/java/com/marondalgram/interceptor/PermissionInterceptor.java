package com.marondalgram.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		
		// request URL -> 콘솔에서 info로 확인
		logger.info("[###preHandle]" + request.getRequestURI());
		
		// 세션을 가져온다
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
	
		// URL Path - 어떤 주소로 요청이 왔는지 가져온다.
		String uri = request.getRequestURI();
		
		if (userId != null && uri.startsWith("/user")) {
			// 로그인이 되어있으면 /user 로 안가고 /timeline으로 보냄
			response.sendRedirect("/timeline/timeline_view");
			return false;
		}
		return true; //무조건 Controller 요청 됨
	}
	
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response
			, Object handler, ModelAndView modelAndView) {
		logger.info("[###postHandle]" + request.getRequestURI());
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response
			, Object handler, Exception exception) {
		logger.info("[###afterCompletion]" + request.getRequestURI());
	}
}
