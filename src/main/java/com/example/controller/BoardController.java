package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.mapper.BoardMapper;
import com.example.service.BoardService;

@Controller
@RequestMapping("/board/")
public class BoardController {
	@Autowired
	BoardMapper mapper;
	
	
	@Autowired
	BoardService service;
	
	@RequestMapping("read")
	 public void read(int bno, Model model) {
	 model.addAttribute("vo", service.read(bno));
	 }
	
	
	
	@RequestMapping("list.json")
	@ResponseBody
	public HashMap<String,Object> list(Criteria cri){
		 HashMap<String,Object> map=new  HashMap<String,Object>();
		 map.put("list", mapper.list(cri));		 
		
		 PageMaker pm = new PageMaker();
		 pm.setCri(cri);
		 pm.setTotalCount(mapper.totalCount(cri));
		 
		 map.put("pm", pm);
		 map.put("cri", cri);
		 
		 return map;
	}
	@RequestMapping("list")
	public String list(){
		return "/board/list";
	}
	
	
	
	
}
