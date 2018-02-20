package com.exe.ticketfactory.dto;

public class SearchDTO {
	
	private String showId; // show �������̵�
	private String showName; // show �����̸�
	private String showPlace; // show �������(��)
	private String showGenre; // show �����帣
	private String placeId; // place & show ��Ҿ��̵�
	private String placeAddr; // place �����ϴ� ����
	private String showPrice;
	private String showPoster;
	private String seatState;
	private String placeName;
	
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getShowPrice() {
		return showPrice;
	}
	public void setShowPrice(String showPrice) {
		this.showPrice = showPrice;
	}
	public String getShowPoster() {
		return showPoster;
	}
	public void setShowPoster(String showPoster) {
		this.showPoster = showPoster;
	}
	public String getSeatState() {
		return seatState;
	}
	public void setSeatState(String seatState) {
		this.seatState = seatState;
	}
	public String getShowId() {
		return showId;
	}
	public void setShowId(String showId) {
		this.showId = showId;
	}
	public String getShowName() {
		return showName;
	}
	public void setShowName(String showName) {
		this.showName = showName;
	}
	public String getShowPlace() {
		return showPlace;
	}
	public void setShowPlace(String showPlace) {
		this.showPlace = showPlace;
	}
	public String getShowGenre() {
		return showGenre;
	}
	public void setShowGenre(String showGenre) {
		this.showGenre = showGenre;
	}
	public String getPlaceId() {
		return placeId;
	}
	public void setPlaceId(String placeId) {
		this.placeId = placeId;
	}
	public String getPlaceAddr() {
		return placeAddr;
	}
	public void setPlaceAddr(String placeAddr) {
		this.placeAddr = placeAddr;
	}
}
