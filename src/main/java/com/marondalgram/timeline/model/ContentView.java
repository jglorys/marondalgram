package com.marondalgram.timeline.model;

import java.util.List;

import com.marondalgram.comment.model.Comment;
import com.marondalgram.post.model.Post;
import com.marondalgram.user.model.User;

public class ContentView {
	// 글 1개
	private Post post;
	
	// 댓글 n개
	private List<Comment> commentList;
	
	// 내가 한 좋아요 여부
	private boolean likeYn; //true : 좋아요  false:좋아요 해제
	
	// 좋아요 총 개수
	private int likeCount;
	
	//프로필 띄우기 위한 user객체
	private User user;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

	public boolean isLikeYn() {
		return likeYn;
	}

	public void setLikeYn(boolean likeYn) {
		this.likeYn = likeYn;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
	
}
