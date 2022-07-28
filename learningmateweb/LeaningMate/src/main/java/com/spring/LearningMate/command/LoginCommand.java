package com.spring.LearningMate.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.spring.LearningMate.dao.AdminDao;
import com.spring.LearningMate.dto.AdminDto;



public class LoginCommand implements ACommand {

	@Override
	public void execute1(SqlSession sqlSession, HttpServletRequest request) {
		
		// httpservlet
		HttpSession session = request.getSession();
		//dao로 sql 연결 
		AdminDao dao = sqlSession.getMapper(AdminDao.class);
		//dto로 db 정보 가져와 dao와 연결  
		AdminDto dto = dao.logIn(request.getParameter("adEmail"), request.getParameter("adPw"));
		
		String adEmail = request.getParameter("adEmail");		
		String adPw = request.getParameter("adPW");
		
		
	}

	@Override
	public void execute2(SqlSession sqlSession, Model model) {
		// TODO Auto-generated method stub

	}

	@Override
	public void execute3(SqlSession sqlSession, HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub

	}

}
