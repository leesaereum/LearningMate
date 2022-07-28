package com.spring.LearningMate.controller;




import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.LearningMate.command.ACommand;


@Controller
public class Admincontroller {

	
	@Autowired
	private SqlSession sqlSession;
	
	private ACommand loginCommand = null;
	private ACommand signinCommand = null;
	
	
	@Autowired
	public void auto(ACommand logIn,ACommand signIn) {
		this.loginCommand = logIn;
		this.signinCommand = signIn;
	}
	//로그인화면 
	
	//login - 구동 
	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		loginCommand.execute1(sqlSession, request);
		return (String)request.getAttribute("return");
	}
	
	//sign in
	@RequestMapping("/signinV")
	public String signinV() {
		return "signinV";
	}
	//sign in - 구동 
	@RequestMapping("/signin")
	public String signin(HttpServletRequest request) {
		signinCommand.execute1(sqlSession, request);
		return "signin";
		
	}
}
