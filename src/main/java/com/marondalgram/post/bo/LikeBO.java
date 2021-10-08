package com.marondalgram.post.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.post.dao.LikeDAO;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
}
