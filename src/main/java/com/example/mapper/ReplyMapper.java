package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.ReplyVO;

public interface ReplyMapper {
	public List<ReplyVO> list(@Param("cri") Criteria cri, @Param("bno") int bno);
	public int totalCount(int bno);
	public void delete(int rno);
	public void insert(ReplyVO vo);
	public ReplyVO read(int rno);
	
}
