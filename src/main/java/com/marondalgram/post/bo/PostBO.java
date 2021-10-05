package com.marondalgram.post.bo;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.marondalgram.common.FileManagerService;
import com.marondalgram.post.dao.PostDAO;
import com.marondalgram.post.model.Post;


@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService; //스프링 빈 Autowired
	
	public List<Post> getPostList(){
		return postDAO.selectPostList();
	}
	
	public int  createPost(int userId, String userLoginId, String userName, String content, MultipartFile file) {
		String imagePath = null;
		
		// SNS에서 파일 업로드는 필수임 -> 로직 타서 imagePath변환
		try {
			imagePath = fileManagerService.saveFile(userLoginId, file);
		} catch (IOException e) {
			// 이미지 업로드 실패
			imagePath = null;
		}
		
		return postDAO.insertPost(userId, userName, content, imagePath);
	}
}
