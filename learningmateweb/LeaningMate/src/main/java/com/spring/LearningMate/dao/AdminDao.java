package com.spring.LearningMate.dao;

import com.spring.LearningMate.dto.AdminDto;

public interface AdminDao {

	//사원번호 adCode 
	//이름 adName
	//이메일 adEmail
	//비밀번호 adPw
	public AdminDto logIn(String adEmail,String adPw);
	public void signIn(String adCode,String adName,String adGender, String adEmail, String adPw,String adAgree);
}
                                                    