package com.spring.LearningMate.controller;




import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;

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
	@RequestMapping("/loginV")
	public String loginV() {
		System.out.println("login1");
		return "loginV";
	}
	
	//login - 구동 
	@RequestMapping("/logIn")
	public String login(HttpServletRequest request) {
		System.out.println("login2");
		loginCommand.execute1(sqlSession, request);
		return (String)request.getAttribute("return");
	}
	
	//회원가입 화면  
	@RequestMapping("/signin")
	public String signinV() {
		System.out.println("signin1");
		return "signinV";
	}
	//회원가입 - 구동 
	@RequestMapping("/signinH")
	public String signIn(HttpServletRequest request) {
		signinCommand.execute1(sqlSession, request);
		System.out.println("controller");
		return "signinH";
	}
	
}
