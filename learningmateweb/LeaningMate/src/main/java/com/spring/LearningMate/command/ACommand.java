package com.spring.LearningMate.command;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface ACommand {
	
	void execute1(SqlSession sqlSession, HttpServletRequest request);
	
	void execute2(SqlSession sqlSession,  Model model);
	
	void execute3(SqlSession sqlSession , HttpServletRequest request, Model model);
	

}
