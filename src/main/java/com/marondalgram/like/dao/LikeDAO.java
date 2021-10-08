package com.marondalgram.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {

	public int selectLikeCountByPostIdAndUserId(
			@Param("userId") int userId,
			@Param("postId") int postId
			);
	
	public void deleteLikeByPostIdAndUserId(
			@Param("userId") int userId,
			@Param("postId") int postId
			);
	
	public void insertLikeByPostIdAndUserId(
			@Param("userId") int userId,
			@Param("postId") int postId
			);
	
	public int selectLikeCountByPostId(int postId);
}
