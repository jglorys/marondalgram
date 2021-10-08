package com.marondalgram.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.like.dao.LikeDAO;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;
	
	public void like(int userId, int postId) {
		// 이미 좋아요가 눌러졌는지(likeYn="true") 확인해야 한다.
		boolean existLike = existLike(userId, postId);
		// existLike = true면 좋아요 취소해줘야함
		if (existLike) {
			deleteLikeByPostIdAndUserId(userId, postId);
		} else {
			// existLike = false면 좋아요 눌러줘야함
			addLikeByPostIdAndUserId(userId, postId);
		}
	}
	
	public boolean existLike(int userId, int postId) {
		int likeCount = likeDAO.selectLikeCountByPostIdAndUserId(userId, postId);
		boolean existLike = false; //좋아요 X
		if (likeCount > 0) {
			// 좋아요가 이미 눌러져 있음
			existLike = true;
		} 
		 return existLike;
	}
	
	public void deleteLikeByPostIdAndUserId(int userId, int postId) {
		likeDAO.deleteLikeByPostIdAndUserId(userId, postId);
	}
	
	public void addLikeByPostIdAndUserId(int userId, int postId) {
		likeDAO.insertLikeByPostIdAndUserId(userId, postId);
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostId(postId);
	}

}
