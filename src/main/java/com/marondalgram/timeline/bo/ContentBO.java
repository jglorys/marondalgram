package com.marondalgram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.comment.bo.CommentBO;
import com.marondalgram.comment.model.Comment;
import com.marondalgram.like.bo.LikeBO;
import com.marondalgram.post.bo.PostBO;
import com.marondalgram.post.model.Post;
import com.marondalgram.timeline.model.ContentView;

@Service
public class ContentBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public List<ContentView> getContentViewList(int userId){
		List<ContentView> contentViewList = new ArrayList<>();
		
		// Post목록
		List<Post> postList = postBO.getPostList();
		for (Post post : postList) {
			ContentView content = new ContentView(); //카드 하나
			
			//글
			content.setPost(post);
			
			//댓글들 - 댓글목록을 가지고 온다 -> 글id
			List<Comment> commentList = commentBO.getCommentList(post.getId()); 
			content.setCommentList(commentList);
			
			//좋아요 - 내가 한 좋아요 여부
			// 좋아요 -> userId, postId O-true / X-false
			content.setLikeYn(likeBO.existLike(userId, post.getId()));
			
			//좋아요개수
			//좋아요 -> postId
			content.setLikeCount(likeBO.getLikeCountByPostId(post.getId()));
			
			
			contentViewList.add(content);
		}
		
		
		return contentViewList;
	}
}
