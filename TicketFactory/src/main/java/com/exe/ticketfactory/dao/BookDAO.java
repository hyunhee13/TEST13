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
	
//	�� ȸ������ �ҷ�����
	public TicketDTO getReadCustom(String userId) {
		
		TicketDTO dtoCus = sessionTemplate.selectOne("bookMapper.getReadCustom", userId);
		return dtoCus;
	}
	
//	�� �������� �ҷ�����(where showId)
	public ShowDTO getReadShow(String showId) {
		
		ShowDTO dtoShow = sessionTemplate.selectOne("bookMapper.getReadShow", showId);
		return dtoShow;
	}
	
//	�� ������ ���� ������ �ҷ�����
	public ShowImageDTO getReadShowImage(String showId) {
		
		ShowImageDTO dtoShowImage = sessionTemplate.selectOne("bookMapper.getReadShowImage", showId);
		return dtoShowImage;
	}
	
//	���� ���� ������ ����Ʈ custom ���̺� ����
	public void updateSubPoint(TicketDTO dtoCus) {
		
		sessionTemplate.update("bookMapper.updateSubPoint", dtoCus);
	}
	
//	���� ���� ��, �� �����ݾ׿��� 5% ����Ʈ ����
	public void updateSavePoint(TicketDTO dtoCus) {
		
		sessionTemplate.update("bookMapper.updateSavePoint", dtoCus);
	}
	
//	���� ���� ������ ����
	public void insertBook(BookDTO dtoBook) {
		
		sessionTemplate.insert("bookMapper.insertBook", dtoBook);
	}
	
//	���� �Ϸ� �� �Ѿ ������(����Ƽ��-���ų���-������)���� �ش� Ƽ�� ���� �ҷ�����
	public BookDTO getReadSuccess(String bookNum) {
		
		BookDTO dtoBook = sessionTemplate.selectOne("bookMapper.getReadSuccess" , bookNum);
		return dtoBook;
	}
	
//	�������Ա� ������ ���Ա�-> �Ϸ�� ����
	public void updatePayment(BookDTO dtoBook) {
		
		sessionTemplate.update("bookMapper.updatePayment", dtoBook);
	}
	
//	�� ������ ���� timeTable ���� �ҷ�����(�ܿ� �¼�, ���� ��¥, ���� �ð�)
	public SeatDTO getReadTimeTable(SeatDTO dtoTime) {
		
		SeatDTO dtoTimeTable = sessionTemplate.selectOne("bookMapper.getReadTimeTable", dtoTime);
		return dtoTimeTable;
	}
	

//	�ܿ��¼� update
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
	
//	7�������� ���ݱ��� ���ŵ� �����͵� �ҷ�����
/*	public List<BookDTO> beforeSevenDays() {
		
		List<BookDTO> sevenLists = sessionTemplate.selectList("bookMapper.beforeSevenDays");
		return sevenLists;
	}*/
	
//	�ְ����� Best10 (showId�� �������� ����)
	public List<BookDTO> rankTen() {
		
		List<BookDTO> rankLists = sessionTemplate.selectList("bookMapper.rankTen");
		return rankLists;
	}
	
//	�ְ����� Best10 (�ٽ�)
	public SearchDTO rankList(String showId) {
		
		SearchDTO dtoSearch = sessionTemplate.selectOne("bookMapper.rankList", showId);
		return dtoSearch;
	}
	
//	�ش� ������ ���� place���� �ҷ�����
	public PlaceDTO getReadPlace(String placeId) {
		
		PlaceDTO dtoPlace = sessionTemplate.selectOne("bookMapper.getReadPlace", placeId);
		return dtoPlace;
	}
	
//	�� �������� �ҷ�����(where showId)
	public List<ShowDTO> showPlaceId(String placeId) {
		
		List<ShowDTO> dtoShowPlace = sessionTemplate.selectList("bookMapper.showPlaceId", placeId);
		return dtoShowPlace;
	}
	
//	�˻�Ű����� �����ͻѸ���!!!!
	public List<SearchDTO> searchList(String search_word, int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("search_word", search_word);
		
		List<SearchDTO> searchList = sessionTemplate.selectList("bookMapper.searchData", params);
		return searchList;
	}
	
//	�˻��� Ű������ �����͵� �� ����
	public int getDataCount(String search_word) {
		
		int result = sessionTemplate.selectOne("bookMapper.getDataCount", search_word);
		return result;
	}
	
//	������������ -----------------------

//	���ؿ��ż� (���ŵ� ���ص��� ������ �������� ����)
	public List<BookDTO> bookDescList(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<BookDTO> bookDescList = sessionTemplate.selectList("bookMapper.bookDescList", params);
		return bookDescList;
	}
	
//	group by showId�� ����, ���ص��� ����
	public int bookDescCount() {
		
		int result = sessionTemplate.selectOne("bookMapper.bookDescCount");
		return result;
	}
	
//	���� ������ ȸ����
	public List<TicketDTO> cusDescList(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<TicketDTO> cusDescList = sessionTemplate.selectList("bookMapper.cusDescList", params);
		return cusDescList;
	}

//	group by userId�� ����, ���ص��� ����
	public int cusDescCount() {
		
		int result = sessionTemplate.selectOne("bookMapper.cusDescCount");
		return result;
	}
	
//	��� ȸ������ �ҷ�����
	public List<TicketDTO> allCustomInfo(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<TicketDTO> allCustomInfoList = sessionTemplate.selectList("bookMapper.allCustomInfo", params);
		return allCustomInfoList;
	}
	
//	group by userId�� ����, �� ȸ������ ��
	public int customCount() {
		
		int result = sessionTemplate.selectOne("bookMapper.customCount");
		return result;
	}
	
//	ȸ������ ������ Ƽ�ϵ��� �� ���ݺ��� ��ü ȸ������ �ҷ�����
	public List<BookDTO> accruePrice(int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<BookDTO> accruePrice = sessionTemplate.selectList("bookMapper.accruePrice", params);
		return accruePrice;
	}
	
//	���� ��� ����
public List<ReviewDTO> avgStar() {
		
		List<ReviewDTO> avgStar = sessionTemplate.selectList("bookMapper.avgStar");
		
		return avgStar;
	}



//��������ϱ�
public void deleteBook(String bookCancelNum) {
	
	sessionTemplate.delete("bookMapper.deleteBook", bookCancelNum);
}

//��������� ������ ����Ʈ �ҷ�����
public List<BookDTO> cancelList(String bookCancelNum) {
	
	List<BookDTO> cancelList = sessionTemplate.selectList("bookMapper.cancelList", bookCancelNum);
	
	return cancelList;
}

public BookDTO cancelData(String bookNum) {
	
	BookDTO cancelData = sessionTemplate.selectOne("bookMapper.cancelData", bookNum);
	return cancelData;
}

//���� ���� ������ ����
public void insertGroupBook(GroupReservationDTO dtoGroup) {
	
	 sessionTemplate.insert("dataMapper.insertGroupBook", dtoGroup);
}



//���� �Ϸ� �� �Ѿ ������(����Ƽ��-���ų���-������)���� �ش� Ƽ�� ���� �ҷ�����
public GroupReservationDTO getReadSuccessGroup(String groupBookNum) {
	
	GroupReservationDTO dtoGroup = sessionTemplate.selectOne("dataMapper.getReadSuccessGroup" , groupBookNum);
	return dtoGroup;
}	

//�� ������ ���� timeTable ���� �ҷ�����(�ܿ� �¼�, ���� ��¥, ���� �ð�)
public SeatDTO getReadTimeTableGroup(SeatDTO dtoSeat) {
	
	SeatDTO dtoTimeTable =  sessionTemplate.selectOne("dataMapper.getReadTimeTableGroup", dtoSeat);
	return dtoTimeTable;
}


}
