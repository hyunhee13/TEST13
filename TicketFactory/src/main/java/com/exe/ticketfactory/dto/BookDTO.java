package com.exe.ticketfactory.dto;

public class BookDTO { // ����
	
	private String userId; // ȸ�����̵�
	private String showId; // �������̵�
	private String bookDate; // Ƽ�� ������ ��¥
	private String bookNum; // ���� ��ȣ
	private int bookSu; // ����Ƽ�� ����
	private int bookPrice; // Ƽ�� ����
	private int usedPoint; // �����Ҷ� ���� ����Ʈ
	private String showDay; // ������¥
	private String showTime; // �����ð�
	private String bookState; // ��������
	private String seat; // R��,S�� �̷���..
	private int seat_num; // �¼���޿� ���� ���ڰ�
	
	
	
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
