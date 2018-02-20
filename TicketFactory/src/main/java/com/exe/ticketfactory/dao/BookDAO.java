package com.exe.ticketfactory.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import com.exe.ticketfactory.dto.BookDTO;
import com.exe.ticketfactory.dto.GroupReservationDTO;
import com.exe.ticketfactory.dto.PlaceDTO;
import com.exe.ticketfactory.dto.ReviewDTO;
import com.exe.ticketfactory.dto.SearchDTO;
import com.exe.ticketfactory.dto.SeatDTO;
import com.exe.ticketfactory.dto.ShowDTO;
import com.exe.ticketfactory.dto.ShowImageDTO;
import com.exe.ticketfactory.dto.TicketDTO;

public class BookDAO {
	
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		
		this.sessionTemplate = sessionTemplate;
	}
	
//	한 회원정보 불러오기
	public TicketDTO getReadCustom(String userId) {
		
		TicketDTO dtoCus = sessionTemplate.selectOne("bookMapper.getReadCustom", userId);
		return dtoCus;
	}
	
//	한 공연정보 불러오기(where showId)
	public ShowDTO getReadShow(String showId) {
		
		ShowDTO dtoShow = sessionTemplate.selectOne("bookMapper.getReadShow", showId);
		return dtoShow;
	}
	
//	한 공연에 대한 포스터 불러오기
	public ShowImageDTO getReadShowImage(String showId) {
		
		ShowImageDTO dtoShowImage = sessionTemplate.selectOne("bookMapper.getReadShowImage", showId);
		return dtoShowImage;
	}
	
//	예매 도중 차감한 포인트 custom 테이블에 저장
	public void updateSubPoint(TicketDTO dtoCus) {
		
		sessionTemplate.update("bookMapper.updateSubPoint", dtoCus);
	}
	
//	공연 예매 후, 총 결제금액에서 5% 포인트 적립
	public void updateSavePoint(TicketDTO dtoCus) {
		
		sessionTemplate.update("bookMapper.updateSavePoint", dtoCus);
	}
	
//	공연 예매 데이터 저장
	public void insertBook(BookDTO dtoBook) {
		
		sessionTemplate.insert("bookMapper.insertBook", dtoBook);
	}
	
//	결제 완료 후 넘어간 페이지(마이티켓-구매내역-성공적)에서 해당 티켓 정보 불러오기
	public BookDTO getReadSuccess(String bookNum) {
		
		BookDTO dtoBook = sessionTemplate.selectOne("bookMapper.getReadSuccess" , bookNum);
		return dtoBook;
	}
	
//	무통장입금 결제시 미입금-> 완료로 변경
	public void updatePayment(BookDTO dtoBook) {
		
		sessionTemplate.update("bookMapper.updatePayment", dtoBook);
	}
	
//	한 공연에 대한 timeTable 정보 불러오기(잔여 좌석, 공연 날짜, 공연 시간)
	public SeatDTO getReadTimeTable(SeatDTO dtoTime) {
		
		SeatDTO dtoTimeTable = sessionTemplate.selectOne("bookMapper.getReadTimeTable", dtoTime);
		return dtoTimeTable;
	}
	

//	잔여좌석 update
	public void updateSeat1(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat1", dtoTime);
	}
	public void updateSeat2(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat2", dtoTime);
	}
	public void updateSeat3(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat3", dtoTime);
	}
	public void updateSeat4(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat4", dtoTime);
	}
	public void updateSeat5(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat5", dtoTime);
	}
	public void updateSeat6(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat6", dtoTime);
	}
	public void updateSeat7(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat7", dtoTime);
	}
	public void updateSeat8(SeatDTO dtoTime) {
		
		sessionTemplate.update("bookMapper.updateSeat8", dtoTime);
	}
	
//	7일전부터 지금까지 예매된 데이터들 불러오기
/*	public List<BookDTO> beforeSevenDays() {
		
		List<BookDTO> sevenLists = sessionTemplate.selectList("bookMapper.beforeSevenDays");
		return sevenLists;
	}*/
	
//	주간순위 Best10 (showId가 많을수록 상위)
	public List<BookDTO> rankTen() {
		
		List<BookDTO> rankLists = sessionTemplate.selectList("bookMapper.rankTen");
		return rankLists;
	}
	
//	주간순위 Best10 (다시)
	public SearchDTO rankList(String showId) {
		
		SearchDTO dtoSearch = sessionTemplate.selectOne("bookMapper.rankList", showId);
		return dtoSearch;
	}
	
//	해당 공연에 대한 place정보 불러오기
	public PlaceDTO getReadPlace(String placeId) {
		
		PlaceDTO dtoPlace = sessionTemplate.selectOne("bookMapper.getReadPlace", placeId);
		return dtoPlace;
	}
	
//	한 공연정보 불러오기(where showId)
	public List<ShowDTO> showPlaceId(String placeId) {
		
		List<ShowDTO> dtoShowPlace = sessionTemplate.selectList("bookMapper.showPlaceId", placeId);
		return dtoShowPlace;
	}
	
//	검색키워드로 데이터뿌리기!!!!
	public List<SearchDTO> searchList(String search_word, int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("search_word", search_word);
		
		List<SearchDTO> searchList = sessionTemplate.selectList("bookMapper.searchData", params);
		return searchList;
	}
	
//	검색된 키워드의 데이터들 총 갯수
	public int getDataCount(String search_word) {
		
		int result = sessionTemplate.selectOne("bookMapper.getDataCount", search_word);
		return result;
	}
	
//	관리자페이지 -----------------------

//	연극예매순 (예매된 연극들의 수량이 많을수록 상위)
	public List<BookDTO> bookDescList(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<BookDTO> bookDescList = sessionTemplate.selectList("bookMapper.bookDescList", params);
		return bookDescList;
	}
	
//	group by showId로 묶고, 연극들의 갯수
	public int bookDescCount() {
		
		int result = sessionTemplate.selectOne("bookMapper.bookDescCount");
		return result;
	}
	
//	많이 구매한 회원순
	public List<TicketDTO> cusDescList(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<TicketDTO> cusDescList = sessionTemplate.selectList("bookMapper.cusDescList", params);
		return cusDescList;
	}

//	group by userId로 묶고, 연극들의 갯수
	public int cusDescCount() {
		
		int result = sessionTemplate.selectOne("bookMapper.cusDescCount");
		return result;
	}
	
//	모든 회원정보 불러오기
	public List<TicketDTO> allCustomInfo(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<TicketDTO> allCustomInfoList = sessionTemplate.selectList("bookMapper.allCustomInfo", params);
		return allCustomInfoList;
	}
	
//	group by userId로 묶고, 총 회원들의 수
	public int customCount() {
		
		int result = sessionTemplate.selectOne("bookMapper.customCount");
		return result;
	}
	
//	회원들이 구매한 티켓들의 총 가격별로 전체 회원정보 불러오기
	public List<BookDTO> accruePrice(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<BookDTO> accruePrice = sessionTemplate.selectList("bookMapper.accruePrice", params);
		return accruePrice;
	}
	
//	별점 평균 내기
public List<ReviewDTO> avgStar() {
		
		List<ReviewDTO> avgStar = sessionTemplate.selectList("bookMapper.avgStar");
		
		return avgStar;
	}



//예매취소하기
public void deleteBook(String bookCancelNum) {
	
	sessionTemplate.delete("bookMapper.deleteBook", bookCancelNum);
}

//예매취소할 데이터 리스트 불러오기
public List<BookDTO> cancelList(String bookCancelNum) {
	
	List<BookDTO> cancelList = sessionTemplate.selectList("bookMapper.cancelList", bookCancelNum);
	
	return cancelList;
}

public BookDTO cancelData(String bookNum) {
	
	BookDTO cancelData = sessionTemplate.selectOne("bookMapper.cancelData", bookNum);
	return cancelData;
}

//공연 예매 데이터 저장
public void insertGroupBook(GroupReservationDTO dtoGroup) {
	
	 sessionTemplate.insert("dataMapper.insertGroupBook", dtoGroup);
}



//결제 완료 후 넘어간 페이지(마이티켓-구매내역-성공적)에서 해당 티켓 정보 불러오기
public GroupReservationDTO getReadSuccessGroup(String groupBookNum) {
	
	GroupReservationDTO dtoGroup = sessionTemplate.selectOne("dataMapper.getReadSuccessGroup" , groupBookNum);
	return dtoGroup;
}	

//한 공연에 대한 timeTable 정보 불러오기(잔여 좌석, 공연 날짜, 공연 시간)
public SeatDTO getReadTimeTableGroup(SeatDTO dtoSeat) {
	
	SeatDTO dtoTimeTable =  sessionTemplate.selectOne("dataMapper.getReadTimeTableGroup", dtoSeat);
	return dtoTimeTable;
}


}
