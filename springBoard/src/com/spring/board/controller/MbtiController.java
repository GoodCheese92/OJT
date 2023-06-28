package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.MbtiVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class MbtiController {
	
	@Autowired 
	private com.spring.board.service.mbtiService mbtiService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/mbti/mbtiList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		List<MbtiVo> mbtiList = new ArrayList<MbtiVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		mbtiList = mbtiService.selectMbtiList(pageVo);
		
		System.out.println("----- mbtiList -----");
		for(MbtiVo list : mbtiList) {
			System.out.println("mbtiType : " + list.getMbtiType() + ", mbtiNum : " + list.getMbtiNum());
		} // end of for
		
		
		model.addAttribute("mbtiList", mbtiList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return "mbti/mbtiList";
	}
	
	
	
} // end of class













