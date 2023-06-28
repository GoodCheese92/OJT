package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.PageVo;
import com.spring.board.vo.MbtiVo;

public interface MbtiDao {
	public List<MbtiVo> selectMbtiList(PageVo pageVo);
	
} // end of class
