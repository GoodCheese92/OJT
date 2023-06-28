package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.vo.PageVo;
import com.spring.board.dao.MbtiDao;
import com.spring.board.vo.MbtiVo;

@Repository
public class MbtiDaoImpl implements MbtiDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MbtiVo> selectMbtiList(PageVo pageVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mbti.mbtiList", pageVo);
	} // end of selectMbtiList()
	
} // end of class
