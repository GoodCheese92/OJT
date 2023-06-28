package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.MbtiVo;
import com.spring.board.vo.PageVo;

public interface mbtiService {
	public List<MbtiVo> selectMbtiList(PageVo pageVo) throws Exception;
	
} // end of mbtiService
