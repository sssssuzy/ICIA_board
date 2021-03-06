package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BoardVO;
import com.example.domain.ReplyVO;
import com.example.mapper.BoardMapper;
import com.example.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	BoardMapper bmapper;
	
	@Autowired
	ReplyMapper rmapper;

	@Transactional
	@Override
	public void insert(ReplyVO vo) {
		bmapper.updateReplycnt(vo.getBno(), 1);
		rmapper.insert(vo);		
	}

	@Transactional
	@Override
	public void delete(int rno) {
		ReplyVO vo = rmapper.read(rno);
		bmapper.updateReplycnt(vo.getBno(), -1);
		rmapper.delete(rno);		
	}

}
