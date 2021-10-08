package com.marondalgram.post.bo;

import java.io.IOException;
import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.marondalgram.common.FileManagerService;
import com.marondalgram.post.dao.PostDAO;
import com.marondalgram.post.model.Post;


@Service
public class PostBO {

	private Logger logger = LoggerFactory.getLogger(PostBO.class);
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService; //스프링 빈 Autowired
	
	public List<Post> getPostList(){
		return postDAO.selectPostList();
	}
	
	public int createPost(int userId, String userLoginId, String userName, String content, MultipartFile file) {
		String imagePath = null;
		
		// SNS에서 파일 업로드는 필수임 -> 로직 타서 imagePath변환
		if (imagePath == null) {
			try {
				imagePath = fileManagerService.saveFile(userLoginId, file);
			} catch (IOException e) {
				// 이미지 업로드 실패
				imagePath = null;
				return 0;
			}
		}
		return postDAO.insertPost(userId, userName, content, imagePath);
	}
	
	public Post getPost(int postId) {
		return postDAO.selectPost(postId);
	}
	
	public void deletePost(int postId) {
		// postId로 post를 조회
		Post post = getPost(postId);
		
		// post가 null인지 검사한다.
		if (post == null) {
			logger.error("[delete post] 삭제할 게시물이 없습니다. {}", postId );
			return; //void => 리턴할 값 없음 => 메소드 종류
		}
		
		// 그림있는지 확인 -> 있으면 삭제
		String imagePath = post.getImagePath();
		if (imagePath != null) {
			//FileManagerService의 deleteFile(String imagePath)메소드를 사용
			try {
				fileManagerService.deleteFile(imagePath);
			} catch (IOException e) {
				// 삭제에 실패
				logger.error("[delete post] 사진 삭제 실패  postId : {}  , path : {}",postId,imagePath);
			}
		}
		// post를 삭제한다.
		postDAO.deletePost(postId);
		
	}
}
