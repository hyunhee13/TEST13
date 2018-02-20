package com.exe.ticketfactory.board.dto;

public class FaqDTO {
	
	private int faqNum,faqHitCount;
	private String faqContent,faqSubject;
	
	public int getFaqHitCount() {
		return faqHitCount;
	}
	public void setFaqHitCount(int faqHitCount) {
		this.faqHitCount = faqHitCount;
	}
	public int getFaqNum() {
		return faqNum;
	}
	public void setFaqNum(int faqNum) {
		this.faqNum = faqNum;
	}
	public String getFaqContent() {
		return faqContent;
	}
	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}
	public String getFaqSubject() {
		return faqSubject;
	}
	public void setFaqSubject(String faqSubject) {
		this.faqSubject = faqSubject;
	}
	
	

}
