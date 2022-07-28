package com.spring.LearningMate.dto;

public class AdminDto {
	//사원번호
	String adCode;
	//이름 
	String adName;
	//email
	String adEmail;
	//pw 
	String adPw;
	
	@Override
	public String toString() {
		return "AdminDto [adCode=" + adCode + ", adName=" + adName + ", adEmail=" + adEmail + ", adPw=" + adPw + "]";
	}

	public String getAdCode() {
		return adCode;
	}

	public void setAdCode(String adCode) {
		this.adCode = adCode;
	}

	public String getAdName() {
		return adName;
	}

	public void setAdName(String adName) {
		this.adName = adName;
	}

	public String getAdEmail() {
		return adEmail;
	}

	public void setAdEmail(String adEmail) {
		this.adEmail = adEmail;
	}

	public String getAdPw() {
		return adPw;
	}

	public void setAdPw(String adPw) {
		this.adPw = adPw;
	}

	public AdminDto(String adCode, String adName, String adEmail, String adPw) {
		super();
		this.adCode = adCode;
		this.adName = adName;
		this.adEmail = adEmail;
		this.adPw = adPw;
	}
	
	
	
}
