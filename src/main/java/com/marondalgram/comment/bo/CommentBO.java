package com.marondalgram.comment.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.comment.dao.CommentDAO;
import com.marondalgram.comment.model.Comment;

@Service
public class CommentBO {

	@Autowired
	private CommentDAO commentDAO;
	
	public List<Comment> getCommentList(int postId) {
		// postId를 가지고 해당 게시물의 댓글들을 가져온다.
		List<Comment> commentList = new ArrayList<>();
		commentList = commentDAO.selectCommentList(postId);
		
		return commentList;
	}
	
	
	public void createComment(int postId, int userId, String userName, String content) {
		commentDAO.insertComment(postId, userId, userName, content);
	}
	
	public void deleteComment(int commentId) {
		commentDAO.deleteComment(commentId);
	}
}
