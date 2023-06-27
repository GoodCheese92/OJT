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
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, String boardTypeSet) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		if(boardTypeSet == null) {
			boardList = boardService.SelectBoardList(pageVo);
			totalCnt = boardService.selectBoardCnt();
		} else {
			Map<String, Object> boardTypeMap = new HashMap<String, Object>();
			
			String[] boardTypeArr = boardTypeSet.split(",");
			
			boardTypeMap.put("pageVo", pageVo);
			boardTypeMap.put("boardType", boardTypeArr);
			
			boardList = boardService.boardSelectList(boardTypeMap);;
			//totalCnt = boardVoList.size();
			totalCnt = boardService.selectBoardCnt(boardTypeMap);
		}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		System.out.println("----- boardWriteAction.do -----");
		System.out.println("boardType : " + boardVo.getBoardType());
		System.out.println("boardTitle : " + boardVo.getBoardTitle());
		System.out.println("boardComment : " + boardVo.getBoardComment());
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Model model, BoardVo boardVo) throws Exception {
		System.out.println("----- boardUpdate -----");
		System.out.println("board_type : " + boardVo.getBoardType());
		System.out.println("board_num : " + boardVo.getBoardNum());
		
		BoardVo boardVo2 = new BoardVo();
		boardVo2 = boardService.selectBoard(boardVo.getBoardType(), boardVo.getBoardNum());
		
		model.addAttribute("board", boardVo2);
		
		return "board/boardUpdate";
	} // end of boardUpdate()
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Model model, BoardVo boardVo) throws Exception {
		System.out.println("----- boardUpdateAction.do ------");
		System.out.println("boardType : " + boardVo.getBoardType());
		System.out.println("boardNum : " + boardVo.getBoardNum());
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	} // end of boardUpdateAction()
	
	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Model model, BoardVo boardVo) throws Exception{
		System.out.println("----- boardDeleteAction -----");
		System.out.println("boardType : " + boardVo.getBoardType());
		System.out.println("boardNum : " + boardVo.getBoardNum());
		
		int resultCnt = boardService.boardDelete(boardVo);
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		result.put("success", (resultCnt>0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		
		System.out.println("callbackMsg : " + callbackMsg);
		
		return callbackMsg;
	} // end of boardDeleteAction()
	
	@RequestMapping(value = "/board/boardSearchAction.do", method = RequestMethod.GET)
	@ResponseBody
	public String boardSearchAction(Model model, @RequestParam(value = "boardType[]") List<String> boardType, PageVo pageVo) throws Exception {
		System.out.println("----- boardSearchAction.do -----");
		for(int i=0; i<boardType.size(); i++) {
			System.out.print(boardType.get(i) + " ");
		} // end of for
		System.out.println();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		Map<String, Object> boardTypeMap = new HashMap<String, Object>();
		
		boardTypeMap.put("pageVo", pageVo);
		boardTypeMap.put("boardType", boardType);
		
		List<BoardVo> boardVoList = new ArrayList<BoardVo>();
		
		boardVoList = boardService.boardSelectList(boardTypeMap);
		
		Set<String> boardTypeSet = new HashSet<String>();
		for(BoardVo list : boardVoList) {
			boardTypeSet.add(list.getBoardType());
		}
		
		System.out.print("boardVoList : ");
		for(BoardVo list : boardVoList) {
			System.out.print(list.getBoardNum() + " ");
		}
		
		System.out.println();
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result.put("success", "Y");
		result.put("boardVoList", boardVoList);
		model.addAttribute("boardList", boardVoList);
		result.put("boardTypeSet", boardTypeSet);
		
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);
		
		return callbackMsg;
	} // end of boardSearchAction()
	
	/*
	 * @RequestMapping(value = "/board/boardSearchList.do", method =
	 * RequestMethod.GET) public String boardSearchList(Locale locale, Model
	 * model,PageVo pageVo, @RequestParam(value = "boardTypeSet")String
	 * boardTypeSet) throws Exception{
	 * 
	 * System.out.println("----- boardSearchList.do -----");
	 * System.out.println("boardTypeSet : " + boardTypeSet);
	 * 
	 * String[] boardTypeArr = boardTypeSet.split(",");
	 * 
	 * for(String s : boardTypeArr) { System.out.println("boardTypeArr : " + s); }
	 * 
	 * Map<String, Object> boardTypeMap = new HashMap<String, Object>();
	 * 
	 * int page = 1; int totalCnt = 0;
	 * 
	 * if(pageVo.getPageNo() == 0){ pageVo.setPageNo(page); }
	 * 
	 * boardTypeMap.put("pageVo", pageVo); boardTypeMap.put("boardType",
	 * boardTypeArr);
	 * 
	 * List<BoardVo> boardList = new ArrayList<BoardVo>();
	 * 
	 * boardList = boardService.boardSelectList(boardTypeMap);; //totalCnt =
	 * boardVoList.size(); totalCnt = boardService.selectBoardCnt(boardTypeMap);
	 * 
	 * System.out.println("boardSelectCnt : " + totalCnt);
	 * 
	 * model.addAttribute("boardList", boardList); model.addAttribute("totalCnt",
	 * totalCnt); model.addAttribute("pageNo", page);
	 * 
	 * return "board/boardList"; }
	 */
	
} // end of class













