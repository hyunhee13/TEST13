package com.exe.ticketfactory.board.dto;

import org.springframework.web.multipart.MultipartFile;

public class EventDTO {

	private String ebSubject,ebTitleContent,ebTitleimage,ebContent,ebPeriodFrom,ebPeriodTo,ebCreated,ebTitle;
	private int ebNum,ebHitCount;
	
	private MultipartFile upload;
	

	public String getEbTitle() {
		return ebTitle;
	}
	public void setEbTitle(String ebTitle) {
		this.ebTitle = ebTitle;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public String getEbSubject() {
		return ebSubject;
	}
	public void setEbSubject(String ebSubject) {
		this.ebSubject = ebSubject;
	}
	public String getEbTitleContent() {
		return ebTitleContent;
	}
	public void setEbTitleContent(String ebTitleContent) {
		this.ebTitleContent = ebTitleContent;
	}
	public String getEbTitleimage() {
		return ebTitleimage;
	}
	public void setEbTitleimage(String ebTitleimage) {
		this.ebTitleimage = ebTitleimage;
	}
	public String getEbContent() {
		return ebContent;
	}
	public void setEbContent(String ebContent) {
		this.ebContent = ebContent;
	}
	public String getEbPeriodFrom() {
		return ebPeriodFrom;
	}
	public void setEbPeriodFrom(String ebPeriodFrom) {
		this.ebPeriodFrom = ebPeriodFrom;
	}
	public String getEbPeriodTo() {
		return ebPeriodTo;
	}
	public void setEbPeriodTo(String ebPeriodTo) {
		this.ebPeriodTo = ebPeriodTo;
	}
	public String getEbCreated() {
		return ebCreated;
	}
	public void setEbCreated(String ebCreated) {
		this.ebCreated = ebCreated;
	}
	public int getEbNum() {
		return ebNum;
	}
	public void setEbNum(int ebNum) {
		this.ebNum = ebNum;
	}
	public int getEbHitCount() {
		return ebHitCount;
	}
	public void setEbHitCount(int ebHitCount) {
		this.ebHitCount = ebHitCount;
	}
	
	
	
}
