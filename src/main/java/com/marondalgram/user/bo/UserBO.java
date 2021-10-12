package com.marondalgram.user.bo;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.marondalgram.common.FileManagerService;
import com.marondalgram.post.model.Post;
import com.marondalgram.user.dao.UserDAO;
import com.marondalgram.user.model.User;

@Service
public class UserBO {
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired 
	private FileManagerService fileManagerService; //스프링 빈이므로 
	
	public boolean existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}
	
	public int addNewUser(String loginId,String password,String name,String email) {
		return userDAO.insertNewUser(loginId, password, name, email);
	}
	
	public User getUserByLoginIdAndPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIdAndPassword(loginId, password);
	}
	
	public User getUser(int userId) {
		return userDAO.selectUser(userId);
	}

	public void updateUser(int userId, String userLoginId, String userName, String userIntroduce,  MultipartFile file) {
		String imageUrl = null;
		User user = getUser(userId);
		//file이 있는 경우에만 로직 타서 imageUrl 변환
		if(file != null) {
			try {
				imageUrl = fileManagerService.saveFile(userLoginId, file);
				// 기존에 있던 파일을 삭제 (새로운파일 업로드 잘 됐으면,, 이것부터하면 파일 날라갈수도있음)
				// => imageUrl이 존재(업로드 성공) && 기존에 파일이 있으면 파일 제거
				if (imageUrl != null && user.getImageUrl() != null) {
					// 업로드가 실패할 수 있으므로 업로드 성공 후 제거
					fileManagerService.deleteFile(user.getImageUrl()); //기존에 있었던 path보내줌
				}
				
			} catch (IOException e) {
				// 이미지 실패하고 다른것만 업데이트
				imageUrl = null;
			}
		}
		userDAO.updateUser(userId, userName, userIntroduce, imageUrl);
	}
	
	
}

	


