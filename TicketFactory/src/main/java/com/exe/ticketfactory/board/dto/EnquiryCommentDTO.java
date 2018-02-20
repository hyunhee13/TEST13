package com.exe.ticketfactory.board.dto;

public class EnquiryCommentDTO {
	
	private String eqId,eqcContent,eqcCreated;
	private int eqcNum,eqNum,eqcListNum;
	

	public int getEqcListNum() {
		return eqcListNum;
	}
	public void setEqcListNum(int eqcListNum) {
		this.eqcListNum = eqcListNum;
	}
	public String getEqId() {
		return eqId;
	}
	public void setEqId(String eqId) {
		this.eqId = eqId;
	}
	public String getEqcContent() {
		return eqcContent;
	}
	public void setEqcContent(String eqcContent) {
		this.eqcContent = eqcContent;
	}
	public String getEqcCreated() {
		return eqcCreated;
	}
	public void setEqcCreated(String eqcCreated) {
		this.eqcCreated = eqcCreated;
	}
	public int getEqcNum() {
		return eqcNum;
	}
	public void setEqcNum(int eqcNum) {
		this.eqcNum = eqcNum;
	}
	public int getEqNum() {
		return eqNum;
	}
	public void setEqNum(int eqNum) {
		this.eqNum = eqNum;
	}

}
