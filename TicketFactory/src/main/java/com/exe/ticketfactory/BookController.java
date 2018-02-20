package com.exe.ticketfactory;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exe.ticketfactory.dao.BookDAO;
import com.exe.ticketfactory.dao.Detail2DAO;
import com.exe.ticketfactory.dao.DetailDAO;
import com.exe.ticketfactory.dao.TicketDAO;
import com.exe.ticketfactory.dto.BookDTO;
import com.exe.ticketfactory.dto.PlaceDTO;
import com.exe.ticketfactory.dto.ReviewDTO;
import com.exe.ticketfactory.dto.SearchDTO;
import com.exe.ticketfactory.dto.SeatDTO;
import com.exe.ticketfactory.dto.ShowDTO;
import com.exe.ticketfactory.dto.ShowImageDTO;
import com.exe.ticketfactory.dto.TicketDTO;
import com.jdbc.util.MyUtil;

@Controller
public class BookController {
	
	@Autowired
	@Qualifier("bookDAO")
	BookDAO daoBook;
	
	@Resource(name="ticketDAO")
	TicketDAO daoTicket;
	
	@Autowired
	MyUtil myUtil;
	
	@Autowired
	@Qualifier("detailDAO")
	DetailDAO dao2;
	
	@Autowired
	@Qualifier("detail2DAO")
	Detail2DAO dao;
	
	
//	------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/book.action", method={RequestMethod.POST,RequestMethod.GET})
	public String book( HttpServletRequest req, HttpServletResponse resp,String showId, int count) throws Exception {
		
		HttpSession session = req.getSession();
		
	//	session에서 회원아이디 불러오기
		if ((TicketDTO)session.getAttribute("loginDto")==null){
			
			
			return "redirect:/layout.action?showId="+showId;
			
		}
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		
		String userId = ticket.getUserId();
		//System.out.println(userId);
		

		


		TicketDTO dtoCus = daoBook.getReadCustom(userId);
		req.setAttribute("dtoCus", dtoCus); // 회원정보넘기기
		
		
		showId = (String)session.getAttribute("showId"); // 세션에서 showId 불러오기
		
		ShowDTO showdto = dao.getShow(showId); // showId에 대한 해당 공연정보 불러오기
		
		
		List<BookDTO> lists = new ArrayList<BookDTO>(); // 예매내역 집어넣기
		
		
		
		//OnePlus 티켓 계산---------------------------------------------------------------------------------------
		
		if(dao2.getOneplus(showId)!=null){
			showdto.setEvent("oneplus");
		}
		
		if(showdto.getEvent()=="oneplus"){
			
		
		for(int i=0; i<count; i++) {
			
			BookDTO dtoBook = new BookDTO();
			dtoBook.setShowDay(req.getParameter("bookDate"+i));
			dtoBook.setShowTime(req.getParameter("showTime"+i));
			dtoBook.setBookSu(Integer.parseInt(req.getParameter("bookSu"+i))*2);
			dtoBook.setBookPrice(Integer.parseInt(req.getParameter("bookPrice"+i)));
			dtoBook.setSeat(req.getParameter("seat"+i)); // 좌석 등급
			dtoBook.setSeat_num(Integer.parseInt(req.getParameter("seat_num"+i)));
			
			lists.add(dtoBook);
			
			}
			
		}else{
			
			for(int i=0; i<count; i++) {
				
				BookDTO dtoBook = new BookDTO();
				dtoBook.setShowDay(req.getParameter("bookDate"+i));
				dtoBook.setShowTime(req.getParameter("showTime"+i));
				dtoBook.setBookSu(Integer.parseInt(req.getParameter("bookSu"+i)));
				dtoBook.setBookPrice(Integer.parseInt(req.getParameter("bookPrice"+i)));
				dtoBook.setSeat(req.getParameter("seat"+i)); // 좌석 등급
				dtoBook.setSeat_num(Integer.parseInt(req.getParameter("seat_num"+i)));
				
				lists.add(dtoBook);
			}
			
		}
		
		
		
		
		//OnePlus 티켓 계산---------------------------------------------------------------------------------------
				
		/*for(int i=0; i<count; i++) {
			
			BookDTO dtoBook = new BookDTO();
			dtoBook.setShowDay(req.getParameter("bookDate"+i));
			dtoBook.setShowTime(req.getParameter("showTime"+i));
			dtoBook.setBookSu(Integer.parseInt(req.getParameter("bookSu"+i)));
			dtoBook.setBookPrice(Integer.parseInt(req.getParameter("bookPrice"+i)));
			dtoBook.setSeat(req.getParameter("seat"+i)); // 좌석 등급
			dtoBook.setSeat_num(Integer.parseInt(req.getParameter("seat_num"+i)));
			
			lists.add(dtoBook);
		}*/
		
		String total_priceWon = req.getParameter("total_priceWon");
		
		req.setAttribute("total_priceWon", total_priceWon);
		req.setAttribute("lists", lists);
		req.setAttribute("count", count);
		req.setAttribute("show", showdto);
		
		return "book.tiles";
		
	}
	
	
	
//	무통장입금(ajax) page ------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/account.action", method={RequestMethod.POST,RequestMethod.GET})
	public String account(){
		
		return "accountInfo";
	}
	
	

//	예매page에서 결제 완료후 넘어갈 화면 (마이페이지-구매내역 화면) ------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/bookMyPage.action", method={RequestMethod.POST,RequestMethod.GET})
	public String bookMyPage(BookDTO dtoBook, ShowDTO dtoShow, TicketDTO dtoCus, SeatDTO dtoTime, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		HttpSession session = req.getSession();
		
//		String userId = (String)session.getAttribute("loginDto"); // 세션에서 회원아이디 불러옴(userId)
		String showId = (String)session.getAttribute("showId"); // 세션에서 공연아이디 불러옴(showId)
		
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		
/*		if(ticket.getUserId()==null){
			req.setAttribute("loginMsg", "login");
			return "main.tiles";
		}*/
		String userId = ticket.getUserId();
		
		dtoCus = daoBook.getReadCustom(userId); // 사용자 정보 불러오기
		
		
		dtoShow = daoBook.getReadShow(showId);
		String showName = dtoShow.getShowName(); // 공연이름
		
		
//		int usedPoint = Integer.parseInt(req.getParameter("usedPoint")); // 사용한 포인트
		int usedPoint = Integer.parseInt(req.getParameter("totalUsedPoint"));
		
		int userPoint = dtoCus.getUserPoint(); // 사용자의 원래 적립 포인트
		
		
		
		int totalPrice = Integer.parseInt(req.getParameter("totalPrice")); // 실제 결제한 금액(티켓값-포인트)
	//	dtoBook.setBookPrice(totalPrice); // 실제 결제금액 저장 ----------> 실제결제금액말고 (할인된 가격 * 티켓장수) = 이 결과값 저장으로 바꾸기 

		int addPoint = (totalPrice)/1000*5; // 총 결제금액의 5%값
		System.out.println(addPoint);
		System.out.println("a밍");
		if(usedPoint != 0) {
			dtoCus.setUserPoint(userPoint - usedPoint);
			daoBook.updateSubPoint(dtoCus); // 포인트 차감된값 저장
		}
		
		dtoCus.setUserPoint(dtoCus.getUserPoint() + addPoint); // 결제금액의 5% 포인트 적립
		daoBook.updateSavePoint(dtoCus); 
		
		
		
		
	//	DIV 수 만큼 반복문 돌려서 bookList에 담기
		
		int divCount = Integer.parseInt(req.getParameter("i")); // DIV수
		System.out.println("DIV : " + divCount);
		
		
		//	랜덤(문자+숫자)으로 예매번호 지정(10자리)
		String bookNum = "";
		Random random = new Random();
		
		String text[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9".split(",");
		
		for (int i=0; i<15; i++) {
			bookNum += text[random.nextInt(text.length)];
		}
		
		
	//	for문 들어가기전에 변수지정할게요~
		int bookSu = 0;
		int originalTicketPrice = 0;
		String payment = "";
		String showDay = "";
		String showTime = "";
		int priceSu = 0;
		
		
		for(int s=0; s<divCount; s++) {
			
			String te1 = req.getParameter("seat_grade"+s);
			String te2 = req.getParameter("showDay"+s);
			String te3 = req.getParameter("showTime"+s);
			
			
			if(te1!=null && te2!=null && te3!=null) {
				
				dtoBook.setUserId(userId); // 사용자 아이디 저장
				dtoBook.setShowId(showId); // 공연 showId 저장
			//	bookDate(예매날짜)는 sysdate로 저장됩니당
				
				payment = req.getParameter("accou"); // 결제 방식 불러오기
			/*	if(payment.equals("무통장입금")) {
					dtoBook.setBookState("미입금");
				} else {
					dtoBook.setBookState("완료");
				}
				*/
				dtoBook.setBookState(payment);
				dtoBook.setUsedPoint(usedPoint);
			
				dtoBook.setBookNum(bookNum + "_" + s); // 예매번호(랜덤) 저장
				
				
				dtoBook.setSeat(req.getParameter("seat_grade"+s)); // 좌석등급
				dtoBook.setSeat_num(Integer.parseInt(req.getParameter("seat_num"+s))); // 좌석등급에 대한 번호
				
				showDay = req.getParameter("showDay"+s); // 공연날짜
				showTime = req.getParameter("showTime"+s); // 공연시간
				
				dtoBook.setShowDay(showDay);
				dtoBook.setShowTime(showTime);
				
				
				
			//	dtoBook.setBookSu(Integer.parseInt(req.getParameter("chanSu")));
				bookSu = Integer.parseInt(req.getParameter("bookSu"+s)); // 티켓수량
				dtoBook.setBookSu(bookSu);
				

				originalTicketPrice = Integer.parseInt(req.getParameter("price"+s))/bookSu; // 할인된 티켓 1장당 가격
				
				priceSu = Integer.parseInt(req.getParameter("price"+s)); // 티켓 한장 가격 * 티켓 장수 = 총합값
				dtoBook.setBookPrice(priceSu);
				
				daoBook.insertBook(dtoBook); // 예매table에 값 입력
			}
			
			
		//	dtoBook = daoBook.getReadSuccess(bookNum + "_" + s);	
			
		} // divCount for문...end
		
		
		
//	여기까진 예매page값들 저장, 여기부턴 예매완료page에 값들 띄우기	
		List<BookDTO> bookList = new ArrayList<BookDTO>();
		
		for(int s=0; s<divCount; s++) {
			
			
			String te1 = req.getParameter("seat_grade"+s);
			String te2 = req.getParameter("showDay"+s);
			String te3 = req.getParameter("showTime"+s);
			
			
			
			if(te1!=null && te2!=null && te3!=null) {
				

				dtoBook = daoBook.getReadSuccess(bookNum + "_" + s);
				
				bookList.add(dtoBook);
				
				
			//	잔여좌석차감코딩(showId,showDate,showTime 값 필요함)
				dtoTime.setShowDate(dtoBook.getShowDay());
				dtoTime.setShowTime(dtoBook.getShowTime());
				dtoTime.setShowId(showId);
				
				dtoTime = daoBook.getReadTimeTable(dtoTime);
				

				
				int seat_num = dtoBook.getSeat_num(); // 해당 bookNum의 seat_num(좌석번호)
				bookSu = dtoBook.getBookSu(); // 해당 bookNum의 티켓수량
				
				int subSeat = 0; // 차감후의 좌석값
				int getSeatSu = 0; // 해당 좌석에 대한 좌석수
				
				
				if(seat_num==1) {
					
					getSeatSu = dtoTime.getSeat1();
					
					subSeat = getSeatSu - bookSu;
					
					
					dtoTime.setSeat1(subSeat);
					daoBook.updateSeat1(dtoTime);
					
				} else if(seat_num==2) {
					
					getSeatSu = dtoTime.getSeat2();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat2(subSeat);
					daoBook.updateSeat2(dtoTime);
					
				} else if(seat_num==3) {
					
					getSeatSu = dtoTime.getSeat3();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat3(subSeat);
					daoBook.updateSeat3(dtoTime);
					
				} else if(seat_num==4) {
					
					getSeatSu = dtoTime.getSeat4();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat4(subSeat);
					daoBook.updateSeat4(dtoTime);
					
				} else if(seat_num==5) {
					
					getSeatSu = dtoTime.getSeat5();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat5(subSeat);
					daoBook.updateSeat5(dtoTime);
					
				} else if(seat_num==6) {
					
					getSeatSu = dtoTime.getSeat6();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat6(subSeat);
					daoBook.updateSeat6(dtoTime);
					
				} else if(seat_num==7) {
					
					getSeatSu = dtoTime.getSeat7();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat7(subSeat);
					daoBook.updateSeat7(dtoTime);
					
				} else { // seat_num==8인 경우
					
					getSeatSu = dtoTime.getSeat8();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat8(subSeat);
					daoBook.updateSeat8(dtoTime);
				}
				
			}
			
		} // for문...end
		
		System.out.println("bookNum 테스트 : " + bookNum);
		req.setAttribute("bookCancelNum", bookNum); // 예매취소를 위한 테스트
		
		
		req.setAttribute("dtoCus", dtoCus);
		req.setAttribute("payment", payment);
		req.setAttribute("showName", showName);
		req.setAttribute("bookList", bookList);
		req.setAttribute("bookSize", bookList.size());
		
		req.setAttribute("divCount", divCount);
		
		
		req.setAttribute("dtoBook", dtoBook);
		
		req.setAttribute("totalPrice", totalPrice);
		req.setAttribute("originalTicketPrice", originalTicketPrice);
		
		return "bookMyPage.tiles";
	}
		

//	-----------------------------------------------------------------------------------------
//	무통장입금결제하기 버튼 클릭시, 미입금-> 완료로 DB변경
//	myPage화면 띄우기
	@RequestMapping(value="myPage.action", method={RequestMethod.POST,RequestMethod.GET})
	public String myPage(BookDTO dtoBook, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		if(req.getParameter("bookNum") != null) {
			
			dtoBook.setBookState("무통장입금완료");
			daoBook.updatePayment(dtoBook);
		}
		
		return "myPage";
	}


	
//	주간예매순위 -----------------------------------------------------------------------------------------------
	@RequestMapping(value="weekBest.action", method={RequestMethod.POST,RequestMethod.GET})
	public String weekBest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
	//	Best10 불러오기
		List<BookDTO> rankLists = daoBook.rankTen();
		Iterator<BookDTO> itBook = rankLists.iterator();
		
		List<SearchDTO> searchList = new ArrayList<SearchDTO>();
		List<ReviewDTO> avgStar = daoBook.avgStar();
		
		while(itBook.hasNext()) {
			
			BookDTO dtoBook = itBook.next();
			
			String showId = dtoBook.getShowId();
			
			SearchDTO dtoSearch = daoBook.rankList(showId);
			
			dtoSearch.setPlaceAddr(dtoSearch.getPlaceAddr().substring(0, dtoSearch.getPlaceAddr().indexOf(" ")));
			
			searchList.add(dtoSearch);
		}
		
		
		Iterator<SearchDTO> itSearch = searchList.iterator();
		
		while(itSearch.hasNext()){
			SearchDTO dtoSearch = itSearch.next();
			if(dtoSearch.getShowPrice().indexOf("전석")==-1){
				dtoSearch.setSeatState("좌석 별로 다름");
			}
		}
		req.setAttribute("searchList", searchList);
		req.setAttribute("avgStar", avgStar);
		
		return "weekBest.tiles";
	}
	
	
	
	@RequestMapping(value="/searchData.action", method={RequestMethod.POST,RequestMethod.GET})
	public String searchData(ShowDTO dtoShow, PlaceDTO dtoPlace, SearchDTO dtoSearch, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		String search_word = req.getParameter("search_word");
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			search_word = URLDecoder.decode(search_word, "UTF-8");
		}
		
		int dataCount = daoBook.getDataCount(search_word); // 전체데이터갯수
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // 전체 페이지수
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		// 검색데이터 불러오기
//		List<SearchDTO> searchList = daoBook.searchList(search_word, start, end); // 검색된 데이터들에 대한 정보
		
		// 테스트 영역
		if(search_word.equals("") || search_word==null) {
			
			String keywordX = "/ticketfactory/resources/image/keywordX.GIF";
			req.setAttribute("keywordX", keywordX);
			
		} else {
			
			List<SearchDTO> searchList = daoBook.searchList(search_word, start, end);
			
			Iterator<SearchDTO> itSearch = searchList.iterator();
			
			List<SearchDTO> searchList2 = new ArrayList<SearchDTO>();
			
			while(itSearch.hasNext()) {
				
				dtoSearch = itSearch.next();
				
				dtoSearch.setPlaceAddr(dtoSearch.getPlaceAddr().substring(0, dtoSearch.getPlaceAddr().indexOf(" ")));
				
				searchList2.add(dtoSearch);
			}
			
			Iterator<SearchDTO> itSearch2 = searchList2.iterator();
			
			while(itSearch2.hasNext()){
				dtoSearch = itSearch2.next();
				if(dtoSearch.getShowPrice().indexOf("전석")==-1){
					dtoSearch.setSeatState("좌석 별로 다름");
				}
			}
			
			req.setAttribute("searchList", searchList2);
		}
		
		/*
		Iterator<SearchDTO> itSearch = searchList.iterator();
		
		List<SearchDTO> searchList2 = new ArrayList<SearchDTO>();
		
		while(itSearch.hasNext()) {
			
			dtoSearch = itSearch.next();
			
			dtoSearch.setPlaceAddr(dtoSearch.getPlaceAddr().substring(0, dtoSearch.getPlaceAddr().indexOf(" ")));
			
			searchList2.add(dtoSearch);
		}
		
		Iterator<SearchDTO> itSearch2 = searchList2.iterator();
		
		while(itSearch2.hasNext()){
			dtoSearch = itSearch2.next();
			if(dtoSearch.getShowPrice().indexOf("전석")==-1){
				dtoSearch.setSeatState("좌석 별로 다름");
			}
		}*/
		
		
		
		
		
		
	//	페이징
		String param = "";
		
		if(!search_word.equals("")) {
			param = "search_word=" + URLEncoder.encode(search_word, "UTF-8");
		}
		
		
		String listUrl = cp + "/searchData.action";
		if(!param.equals("")) {
			listUrl = listUrl + "?" + param;
		}
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		List<ReviewDTO> avgStar = daoBook.avgStar();
		req.setAttribute("avgStar", avgStar);
		
	//	req.setAttribute("searchList", searchList2);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		
		return "searchData.tiles";
	}
	
	
//	관리자 페이지(버튼누를수있는)
	@RequestMapping(value="/admin.action", method={RequestMethod.POST,RequestMethod.GET})
	public String adminPage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String pageNum = req.getParameter("pageNum");
		
		if(pageNum== null) {
			pageNum = "1";
		}
		
		req.setAttribute("pageNum", pageNum);
		
		return "/admin/adminPage.tiles";
	}
	
//	관리자 페이지 - 많이 예매한 연극순
	@RequestMapping(value="/admin01.action", method={RequestMethod.POST,RequestMethod.GET})
	public String descBook(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.bookDescCount(); // 전체데이터갯수
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // 전체 페이지수
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		List<BookDTO> bookDescList = daoBook.bookDescList(start, end); // 예매된 공연 리스트
		Iterator<BookDTO> itBook = bookDescList.iterator();
		
		List<ShowDTO> showList = new ArrayList<ShowDTO>();
		List<BookDTO> bookList = new ArrayList<BookDTO>(); // 누적값을 임의의 변수에 넣기 위해..
		
		while(itBook.hasNext()) {
			
			BookDTO dtoBook = itBook.next();
			
			String showId = dtoBook.getShowId();
			
			ShowDTO dtoShow = daoBook.getReadShow(showId); // 공연의 showId로 해당 공연정보 불러들이기
			
			if(dtoShow.getShowPrice().indexOf("전석")==-1){
				dtoShow.setSeatState("좌석 별로 다름");
			}
			
			showList.add(dtoShow);
		}
		
		
		String listUrl = cp + "/admin.action";
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("showList", showList);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		
		return "descBook";
	}
	
//	관리자 페이지 - 많이 예매한 회원순
	@RequestMapping(value="/admin02.action", method={RequestMethod.POST,RequestMethod.GET})
	public String descCustom(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.cusDescCount(); // 전체데이터갯수
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // 전체 페이지수
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		List<TicketDTO> bookDescList = daoBook.cusDescList(start, end); // 예매된 공연 리스트
		Iterator<TicketDTO> itTicket = bookDescList.iterator();
		
		List<TicketDTO> cusList = new ArrayList<TicketDTO>();
		
		while(itTicket.hasNext()) {
			
			TicketDTO dtoTicket = itTicket.next();
			
			String userId = dtoTicket.getUserId();
			
			dtoTicket = daoBook.getReadCustom(userId);
			
			cusList.add(dtoTicket);
		}
		
		String listUrl = cp + "/admin02.action";
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		req.setAttribute("cusList", cusList);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		
		return "descCustom";
	}
	
//	관리자 페이지 - 회원 등급순
	@RequestMapping(value="/admin03.action", method={RequestMethod.POST,RequestMethod.GET})
	public String customGrage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.customCount(); // 총 회원들의 수
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // 전체 페이지수
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		List<BookDTO> accruePriceDesc = daoBook.accruePrice(start, end);
		Iterator<BookDTO> itBook = accruePriceDesc.iterator();
		
		List<TicketDTO> cusList = new ArrayList<TicketDTO>();
		List<BookDTO> bookList = new ArrayList<BookDTO>();
		
		while(itBook.hasNext()) {
			
			TicketDTO dtoTicket = null;
			BookDTO dtoBook = itBook.next();
			
			String userId = dtoBook.getUserId();
			
			dtoTicket = daoBook.getReadCustom(userId);
			
			cusList.add(dtoTicket);
			
			dtoBook.setBookPrice(dtoBook.getBookPrice()); // 누적금액
			dtoBook.setUserId(userId);
			
			bookList.add(dtoBook);
		}
		
		String listUrl = cp + "/admin03.action";
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		req.setAttribute("cusList", cusList);
		req.setAttribute("bookList", bookList);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		
		return "customGrage";
	}
	
	
//	관리자 페이지 - 회원관리
	@RequestMapping(value="/admin04.action", method={RequestMethod.POST,RequestMethod.GET})
	public String customInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.customCount(); // 총 회원들의 수
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // 전체 페이지수
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<TicketDTO> allCustomInfoList = daoBook.allCustomInfo(start, end);

		String listUrl = cp + "/admin04.action";
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		req.setAttribute("allCustomInfoList", allCustomInfoList);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		
		return "customInfo";
	}
	

	
	
	

	//	예매취소
	@RequestMapping(value="/bookCancel.action", method={RequestMethod.POST,RequestMethod.GET})
	public String bookCancel(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		BookDTO dtoBook = new BookDTO();
		TicketDTO dtoCus = new TicketDTO();
		SeatDTO dtoSeat = new SeatDTO();
		
		
		String bookCancelNum = req.getParameter("bookCancelNum"); // 결제 취소할 예매번호의 공통부분
		System.out.println(bookCancelNum);
		
	//	차감되었던 포인트 돌려받기
	//	dtoBook = daoBook.getReadSuccess(bookCancelNum + "_0");
		dtoBook = daoBook.cancelData(bookCancelNum);
		System.out.println(dtoBook.getBookNum());
		
		String userId = dtoBook.getUserId(); // 회원정보
		dtoCus = daoBook.getReadCustom(userId);
		
		int userPoint = dtoCus.getUserPoint(); // 사용자 현재 포인트값
		int addPoint = dtoBook.getUsedPoint(); // 티켓예매할때 사용했던 포인트값
		
		int upPoint = userPoint + addPoint;
		
		dtoCus.setUserPoint(upPoint);
		
		daoBook.updateSavePoint(dtoCus);
		
		
		
	//	차감되었던 티켓수 되돌려주기
		
		// 좌석테이블 조건 입력
		String showId = dtoBook.getShowId();
		String showDate = dtoBook.getShowDay();
		String showTime = dtoBook.getShowTime();
		dtoSeat.setShowId(showId);
		dtoSeat.setShowDate(showDate);
		dtoSeat.setShowTime(showTime);
		
		dtoSeat = daoBook.getReadTimeTable(dtoSeat);
		
		BookDTO cancelBook = new BookDTO();
		
		
		List<BookDTO> cancelList = daoBook.cancelList(bookCancelNum); // 결제취소할 데이터 리스트
		Iterator<BookDTO> itBook = cancelList.iterator();
		
		while(itBook.hasNext()) {
			
			cancelBook = itBook.next();
			
			String cancelBookNum = cancelBook.getBookNum(); // 예매번호
			System.out.println(cancelBookNum);
			
			int seat_num = cancelBook.getSeat_num(); // 좌석등급번호
			System.out.println(seat_num);
			
			int cancelBookSu = cancelBook.getBookSu(); // 티켓수량
			System.out.println(cancelBookSu);
			
			int getSeatSu = 0; // 현재 좌석등급에 따라 저장된 좌석수 불러올것임
			
			if(seat_num==1) {
				
				getSeatSu = dtoSeat.getSeat1();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat1(getSeatSu);
				daoBook.updateSeat1(dtoSeat);
				
			} else if(seat_num==2) {
				
				getSeatSu = dtoSeat.getSeat2();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat2(getSeatSu);
				daoBook.updateSeat2(dtoSeat);
				
			} else if(seat_num==3) {
				
				getSeatSu = dtoSeat.getSeat3();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat3(getSeatSu);
				daoBook.updateSeat3(dtoSeat);
				
			} else if(seat_num==4) {
				
				getSeatSu = dtoSeat.getSeat4();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat4(getSeatSu);
				daoBook.updateSeat4(dtoSeat);
				
			} else if(seat_num==5) {
				
				getSeatSu = dtoSeat.getSeat5();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat5(getSeatSu);
				daoBook.updateSeat5(dtoSeat);
				
			} else if(seat_num==6) {
				
				getSeatSu = dtoSeat.getSeat6();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat6(getSeatSu);
				daoBook.updateSeat6(dtoSeat);
				
			} else if(seat_num==7) {
				
				getSeatSu = dtoSeat.getSeat7();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat7(getSeatSu);
				daoBook.updateSeat7(dtoSeat);
				
			} else { // (seat_num==8)일때 
				
				getSeatSu = dtoSeat.getSeat8();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat8(getSeatSu);
				daoBook.updateSeat8(dtoSeat);
				
			}
		}
		
		
	//	예매취소하기
		daoBook.deleteBook(bookCancelNum); // 제일 마지막에 취소안하면 데이터 다 날라감ㅠㅠ	
		
		req.setAttribute("mypageNum", req.getParameter("mypageNum"));
		req.setAttribute("pageNum", req.getParameter("pageNum"));
		
		return "mypage.tiles";
	}
	
	
	
}






