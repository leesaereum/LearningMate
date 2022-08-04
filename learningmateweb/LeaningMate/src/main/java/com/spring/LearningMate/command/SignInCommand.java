package com.spring.LearningMate.command;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.spring.LearningMate.dao.AdminDao;

public class SignInCommand implements ACommand {

	@Override
	public void execute1(SqlSession sqlSession, HttpServletRequest request) {
		String adCode = request.getParameter("adCode");
		String adName = request.getParameter("adName");
		String adGender = request.getParameter("adGender");
		String adEmail = request.getParameter("adEmail");
		String adPw = request.getParameter("adPw");
		String adAgree = request.getParameter("adAgree");
		
		AdminDao dao = sqlSession.getMapper(AdminDao.class);
		dao.signIn(adCode, adName, adGender, adEmail, adPw, adAgree);
		System.out.println(adCode);
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
