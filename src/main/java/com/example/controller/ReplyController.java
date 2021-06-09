package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.ReplyVO;
import com.example.mapper.BoardMapper;
import com.example.mapper.ReplyMapper;
import com.example.service.ReplyService;

@RestController
@RequestMapping("/reply/")
public class ReplyController {
	@Autowired
	ReplyMapper mapper;
	
	@Autowired
	ReplyService service;
	
	@RequestMapping("/list.json")
	public HashMap<String,Object> list(Criteria cri,int bno){
		 HashMap<String,Object> map=new  HashMap<String,Object>();
		 cri.setPerPageNum(3);
		 map.put("list", mapper.list(cri,bno));		 
		
		 PageMaker pm = new PageMaker();
		 pm.setCri(cri);
		 pm.setTotalCount(mapper.totalCount(bno));		 
		 map.put("pm", pm);
		 map.put("cri", cri);
		 
		 return map;
	}
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public void delete(int rno){
		mapper.delete(rno);
	}
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public void insert(ReplyVO vo){
		mapper.insert(vo);
	}
	
}
