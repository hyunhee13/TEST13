package com.exe.ticketfactory.dto;

public class BookDTO { // 예매
	
	private String userId; // 회원아이디
	private String showId; // 공연아이디
	private String bookDate; // 티켓 예매한 날짜
	private String bookNum; // 예매 번호
	private int bookSu; // 예매티켓 수량
	private int bookPrice; // 티켓 가격
	private int usedPoint; // 예매할때 사용된 포인트
	private String showDay; // 공연날짜
	private String showTime; // 공연시간
	private String bookState; // 결제상태
	private String seat; // R석,S석 이런거..
	private int seat_num; // 좌석등급에 대한 숫자값
	
	
	
	public int getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(int seat_num) {
		this.seat_num = seat_num;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public int getUsedPoint() {
		return usedPoint;
	}
	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getShowId() {
		return showId;
	}
	public void setShowId(String showId) {
		this.showId = showId;
	}
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public String getBookNum() {
		return bookNum;
	}
	public void setBookNum(String bookNum) {
		this.bookNum = bookNum;
	}
	public int getBookSu() {
		return bookSu;
	}
	public void setBookSu(int bookSu) {
		this.bookSu = bookSu;
	}
	public int getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}
	public String getShowDay() {
		return showDay;
	}
	public void setShowDay(String showDay) {
		this.showDay = showDay;
	}
	public String getShowTime() {
		return showTime;
	}
	public void setShowTime(String showTime) {
		this.showTime = showTime;
	}
	public String getBookState() {
		return bookState;
	}
	public void setBookState(String bookState) {
		this.bookState = bookState;
	}
	

	
	
}
