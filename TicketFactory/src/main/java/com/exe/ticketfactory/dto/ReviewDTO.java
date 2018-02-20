package com.exe.ticketfactory.dto;

public class ReviewDTO {
	

	private int num,star;
	private String name,star2,subject,content,created,showId,userId;
	private double starAVG;
	
	public double getStarAVG() {
		return starAVG;
	}
	public void setStarAVG(double starAVG) {
		this.starAVG = starAVG;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStar2() {
		return star2;
	}
	public void setStar2(String star2) {
		this.star2 = star2;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getShowId() {
		return showId;
	}
	public void setShowId(String showId) {
		this.showId = showId;
	}
	
	
	
	

}
