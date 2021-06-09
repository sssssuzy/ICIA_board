package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.domain.Criteria;
import com.example.mapper.BoardMapper;
import com.example.mapper.MysqlMapper;
import com.example.mapper.ReplyMapper;



@RunWith(SpringJUnit4ClassRunner.class) 
//∏’¿˙ SpringJUnit4ClassRunner.class import«—¥Ÿ. 

@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MysqlTest {
	 @Autowired
	 private BoardMapper mapper;
	 
	 @Autowired
	 private ReplyMapper rMapper;
	 
	 @Test
	 public void rList(){
		 Criteria cri = new Criteria();
		 rMapper.list(cri,1858);
		 rMapper.totalCount(1858);
	 }
	 
	 @Test
	 public void read(){
		 mapper.read(57);
	 }
	 
	 @Test
	 public void list() { 
		 Criteria cri = new Criteria();
		 cri.setPage(2);
		 cri.setPerPageNum(5);
		 cri.setSearchType("title");
		 cri.setKeyword("æ»≥Á");
		 mapper.list(cri);
	 }
	 @Test
	 public void totalCount() { 
		 Criteria cri = new Criteria();
		 cri.setPage(2);
		 cri.setPerPageNum(5);
		 cri.setSearchType("title");
		 cri.setKeyword("æ»≥Á");
		 mapper.totalCount(cri);
	 }
}
