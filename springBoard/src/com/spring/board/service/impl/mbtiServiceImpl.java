package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.vo.PageVo;
import com.spring.board.dao.MbtiDao;
import com.spring.board.service.mbtiService;
import com.spring.board.vo.MbtiVo;

@Service
public class mbtiServiceImpl implements mbtiService {
	
	@Autowired
	private MbtiDao mbtiDao;
	
	@Override
	public List<MbtiVo> selectMbtiList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return mbtiDao.selectMbtiList(pageVo);
	}
	
} // end of class
