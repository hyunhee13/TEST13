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
		
	//	session���� ȸ�����̵� �ҷ�����
		if ((TicketDTO)session.getAttribute("loginDto")==null){
			
			
			return "redirect:/layout.action?showId="+showId;
			
		}
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		
		String userId = ticket.getUserId();
		//System.out.println(userId);
		

		


		TicketDTO dtoCus = daoBook.getReadCustom(userId);
		req.setAttribute("dtoCus", dtoCus); // ȸ�������ѱ��
		
		
		showId = (String)session.getAttribute("showId"); // ���ǿ��� showId �ҷ�����
		
		ShowDTO showdto = dao.getShow(showId); // showId�� ���� �ش� �������� �ҷ�����
		
		
		List<BookDTO> lists = new ArrayList<BookDTO>(); // ���ų��� ����ֱ�
		
		
		
		//OnePlus Ƽ�� ���---------------------------------------------------------------------------------------
		
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
			dtoBook.setSeat(req.getParameter("seat"+i)); // �¼� ���
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
				dtoBook.setSeat(req.getParameter("seat"+i)); // �¼� ���
				dtoBook.setSeat_num(Integer.parseInt(req.getParameter("seat_num"+i)));
				
				lists.add(dtoBook);
			}
			
		}
		
		
		
		
		//OnePlus Ƽ�� ���---------------------------------------------------------------------------------------
				
		/*for(int i=0; i<count; i++) {
			
			BookDTO dtoBook = new BookDTO();
			dtoBook.setShowDay(req.getParameter("bookDate"+i));
			dtoBook.setShowTime(req.getParameter("showTime"+i));
			dtoBook.setBookSu(Integer.parseInt(req.getParameter("bookSu"+i)));
			dtoBook.setBookPrice(Integer.parseInt(req.getParameter("bookPrice"+i)));
			dtoBook.setSeat(req.getParameter("seat"+i)); // �¼� ���
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
	
	
	
//	�������Ա�(ajax) page ------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/account.action", method={RequestMethod.POST,RequestMethod.GET})
	public String account(){
		
		return "accountInfo";
	}
	
	

//	����page���� ���� �Ϸ��� �Ѿ ȭ�� (����������-���ų��� ȭ��) ------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/bookMyPage.action", method={RequestMethod.POST,RequestMethod.GET})
	public String bookMyPage(BookDTO dtoBook, ShowDTO dtoShow, TicketDTO dtoCus, SeatDTO dtoTime, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		HttpSession session = req.getSession();
		
//		String userId = (String)session.getAttribute("loginDto"); // ���ǿ��� ȸ�����̵� �ҷ���(userId)
		String showId = (String)session.getAttribute("showId"); // ���ǿ��� �������̵� �ҷ���(showId)
		
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		
/*		if(ticket.getUserId()==null){
			req.setAttribute("loginMsg", "login");
			return "main.tiles";
		}*/
		String userId = ticket.getUserId();
		
		dtoCus = daoBook.getReadCustom(userId); // ����� ���� �ҷ�����
		
		
		dtoShow = daoBook.getReadShow(showId);
		String showName = dtoShow.getShowName(); // �����̸�
		
		
//		int usedPoint = Integer.parseInt(req.getParameter("usedPoint")); // ����� ����Ʈ
		int usedPoint = Integer.parseInt(req.getParameter("totalUsedPoint"));
		
		int userPoint = dtoCus.getUserPoint(); // ������� ���� ���� ����Ʈ
		
		
		
		int totalPrice = Integer.parseInt(req.getParameter("totalPrice")); // ���� ������ �ݾ�(Ƽ�ϰ�-����Ʈ)
	//	dtoBook.setBookPrice(totalPrice); // ���� �����ݾ� ���� ----------> ���������ݾ׸��� (���ε� ���� * Ƽ�����) = �� ����� �������� �ٲٱ� 

		int addPoint = (totalPrice)/1000*5; // �� �����ݾ��� 5%��
		System.out.println(addPoint);
		System.out.println("a��");
		if(usedPoint != 0) {
			dtoCus.setUserPoint(userPoint - usedPoint);
			daoBook.updateSubPoint(dtoCus); // ����Ʈ �����Ȱ� ����
		}
		
		dtoCus.setUserPoint(dtoCus.getUserPoint() + addPoint); // �����ݾ��� 5% ����Ʈ ����
		daoBook.updateSavePoint(dtoCus); 
		
		
		
		
	//	DIV �� ��ŭ �ݺ��� ������ bookList�� ���
		
		int divCount = Integer.parseInt(req.getParameter("i")); // DIV��
		System.out.println("DIV : " + divCount);
		
		
		//	����(����+����)���� ���Ź�ȣ ����(10�ڸ�)
		String bookNum = "";
		Random random = new Random();
		
		String text[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9".split(",");
		
		for (int i=0; i<15; i++) {
			bookNum += text[random.nextInt(text.length)];
		}
		
		
	//	for�� �������� ���������ҰԿ�~
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
				
				dtoBook.setUserId(userId); // ����� ���̵� ����
				dtoBook.setShowId(showId); // ���� showId ����
			//	bookDate(���ų�¥)�� sysdate�� ����˴ϴ�
				
				payment = req.getParameter("accou"); // ���� ��� �ҷ�����
			/*	if(payment.equals("�������Ա�")) {
					dtoBook.setBookState("���Ա�");
				} else {
					dtoBook.setBookState("�Ϸ�");
				}
				*/
				dtoBook.setBookState(payment);
				dtoBook.setUsedPoint(usedPoint);
			
				dtoBook.setBookNum(bookNum + "_" + s); // ���Ź�ȣ(����) ����
				
				
				dtoBook.setSeat(req.getParameter("seat_grade"+s)); // �¼����
				dtoBook.setSeat_num(Integer.parseInt(req.getParameter("seat_num"+s))); // �¼���޿� ���� ��ȣ
				
				showDay = req.getParameter("showDay"+s); // ������¥
				showTime = req.getParameter("showTime"+s); // �����ð�
				
				dtoBook.setShowDay(showDay);
				dtoBook.setShowTime(showTime);
				
				
				
			//	dtoBook.setBookSu(Integer.parseInt(req.getParameter("chanSu")));
				bookSu = Integer.parseInt(req.getParameter("bookSu"+s)); // Ƽ�ϼ���
				dtoBook.setBookSu(bookSu);
				

				originalTicketPrice = Integer.parseInt(req.getParameter("price"+s))/bookSu; // ���ε� Ƽ�� 1��� ����
				
				priceSu = Integer.parseInt(req.getParameter("price"+s)); // Ƽ�� ���� ���� * Ƽ�� ��� = ���հ�
				dtoBook.setBookPrice(priceSu);
				
				daoBook.insertBook(dtoBook); // ����table�� �� �Է�
			}
			
			
		//	dtoBook = daoBook.getReadSuccess(bookNum + "_" + s);	
			
		} // divCount for��...end
		
		
		
//	������� ����page���� ����, ������� ���ſϷ�page�� ���� ����	
		List<BookDTO> bookList = new ArrayList<BookDTO>();
		
		for(int s=0; s<divCount; s++) {
			
			
			String te1 = req.getParameter("seat_grade"+s);
			String te2 = req.getParameter("showDay"+s);
			String te3 = req.getParameter("showTime"+s);
			
			
			
			if(te1!=null && te2!=null && te3!=null) {
				

				dtoBook = daoBook.getReadSuccess(bookNum + "_" + s);
				
				bookList.add(dtoBook);
				
				
			//	�ܿ��¼������ڵ�(showId,showDate,showTime �� �ʿ���)
				dtoTime.setShowDate(dtoBook.getShowDay());
				dtoTime.setShowTime(dtoBook.getShowTime());
				dtoTime.setShowId(showId);
				
				dtoTime = daoBook.getReadTimeTable(dtoTime);
				

				
				int seat_num = dtoBook.getSeat_num(); // �ش� bookNum�� seat_num(�¼���ȣ)
				bookSu = dtoBook.getBookSu(); // �ش� bookNum�� Ƽ�ϼ���
				
				int subSeat = 0; // �������� �¼���
				int getSeatSu = 0; // �ش� �¼��� ���� �¼���
				
				
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
					
				} else { // seat_num==8�� ���
					
					getSeatSu = dtoTime.getSeat8();
					
					subSeat = getSeatSu - bookSu;
					
					dtoTime.setSeat8(subSeat);
					daoBook.updateSeat8(dtoTime);
				}
				
			}
			
		} // for��...end
		
		System.out.println("bookNum �׽�Ʈ : " + bookNum);
		req.setAttribute("bookCancelNum", bookNum); // ������Ҹ� ���� �׽�Ʈ
		
		
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
//	�������Աݰ����ϱ� ��ư Ŭ����, ���Ա�-> �Ϸ�� DB����
//	myPageȭ�� ����
	@RequestMapping(value="myPage.action", method={RequestMethod.POST,RequestMethod.GET})
	public String myPage(BookDTO dtoBook, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		if(req.getParameter("bookNum") != null) {
			
			dtoBook.setBookState("�������ԱݿϷ�");
			daoBook.updatePayment(dtoBook);
		}
		
		return "myPage";
	}


	
//	�ְ����ż��� -----------------------------------------------------------------------------------------------
	@RequestMapping(value="weekBest.action", method={RequestMethod.POST,RequestMethod.GET})
	public String weekBest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
	//	Best10 �ҷ�����
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
			if(dtoSearch.getShowPrice().indexOf("����")==-1){
				dtoSearch.setSeatState("�¼� ���� �ٸ�");
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
		
		int dataCount = daoBook.getDataCount(search_word); // ��ü�����Ͱ���
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // ��ü ��������
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		// �˻������� �ҷ�����
//		List<SearchDTO> searchList = daoBook.searchList(search_word, start, end); // �˻��� �����͵鿡 ���� ����
		
		// �׽�Ʈ ����
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
				if(dtoSearch.getShowPrice().indexOf("����")==-1){
					dtoSearch.setSeatState("�¼� ���� �ٸ�");
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
			if(dtoSearch.getShowPrice().indexOf("����")==-1){
				dtoSearch.setSeatState("�¼� ���� �ٸ�");
			}
		}*/
		
		
		
		
		
		
	//	����¡
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
	
	
//	������ ������(��ư�������ִ�)
	@RequestMapping(value="/admin.action", method={RequestMethod.POST,RequestMethod.GET})
	public String adminPage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String pageNum = req.getParameter("pageNum");
		
		if(pageNum== null) {
			pageNum = "1";
		}
		
		req.setAttribute("pageNum", pageNum);
		
		return "/admin/adminPage.tiles";
	}
	
//	������ ������ - ���� ������ ���ؼ�
	@RequestMapping(value="/admin01.action", method={RequestMethod.POST,RequestMethod.GET})
	public String descBook(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.bookDescCount(); // ��ü�����Ͱ���
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // ��ü ��������
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		List<BookDTO> bookDescList = daoBook.bookDescList(start, end); // ���ŵ� ���� ����Ʈ
		Iterator<BookDTO> itBook = bookDescList.iterator();
		
		List<ShowDTO> showList = new ArrayList<ShowDTO>();
		List<BookDTO> bookList = new ArrayList<BookDTO>(); // �������� ������ ������ �ֱ� ����..
		
		while(itBook.hasNext()) {
			
			BookDTO dtoBook = itBook.next();
			
			String showId = dtoBook.getShowId();
			
			ShowDTO dtoShow = daoBook.getReadShow(showId); // ������ showId�� �ش� �������� �ҷ����̱�
			
			if(dtoShow.getShowPrice().indexOf("����")==-1){
				dtoShow.setSeatState("�¼� ���� �ٸ�");
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
	
//	������ ������ - ���� ������ ȸ����
	@RequestMapping(value="/admin02.action", method={RequestMethod.POST,RequestMethod.GET})
	public String descCustom(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.cusDescCount(); // ��ü�����Ͱ���
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // ��ü ��������
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		
		List<TicketDTO> bookDescList = daoBook.cusDescList(start, end); // ���ŵ� ���� ����Ʈ
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
	
//	������ ������ - ȸ�� ��޼�
	@RequestMapping(value="/admin03.action", method={RequestMethod.POST,RequestMethod.GET})
	public String customGrage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.customCount(); // �� ȸ������ ��
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // ��ü ��������
		
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
			
			dtoBook.setBookPrice(dtoBook.getBookPrice()); // �����ݾ�
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
	
	
//	������ ������ - ȸ������
	@RequestMapping(value="/admin04.action", method={RequestMethod.POST,RequestMethod.GET})
	public String customInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = daoBook.customCount(); // �� ȸ������ ��
		
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount); // ��ü ��������
		
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
	

	
	
	

	//	�������
	@RequestMapping(value="/bookCancel.action", method={RequestMethod.POST,RequestMethod.GET})
	public String bookCancel(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		BookDTO dtoBook = new BookDTO();
		TicketDTO dtoCus = new TicketDTO();
		SeatDTO dtoSeat = new SeatDTO();
		
		
		String bookCancelNum = req.getParameter("bookCancelNum"); // ���� ����� ���Ź�ȣ�� ����κ�
		System.out.println(bookCancelNum);
		
	//	�����Ǿ��� ����Ʈ �����ޱ�
	//	dtoBook = daoBook.getReadSuccess(bookCancelNum + "_0");
		dtoBook = daoBook.cancelData(bookCancelNum);
		System.out.println(dtoBook.getBookNum());
		
		String userId = dtoBook.getUserId(); // ȸ������
		dtoCus = daoBook.getReadCustom(userId);
		
		int userPoint = dtoCus.getUserPoint(); // ����� ���� ����Ʈ��
		int addPoint = dtoBook.getUsedPoint(); // Ƽ�Ͽ����Ҷ� ����ߴ� ����Ʈ��
		
		int upPoint = userPoint + addPoint;
		
		dtoCus.setUserPoint(upPoint);
		
		daoBook.updateSavePoint(dtoCus);
		
		
		
	//	�����Ǿ��� Ƽ�ϼ� �ǵ����ֱ�
		
		// �¼����̺� ���� �Է�
		String showId = dtoBook.getShowId();
		String showDate = dtoBook.getShowDay();
		String showTime = dtoBook.getShowTime();
		dtoSeat.setShowId(showId);
		dtoSeat.setShowDate(showDate);
		dtoSeat.setShowTime(showTime);
		
		dtoSeat = daoBook.getReadTimeTable(dtoSeat);
		
		BookDTO cancelBook = new BookDTO();
		
		
		List<BookDTO> cancelList = daoBook.cancelList(bookCancelNum); // ��������� ������ ����Ʈ
		Iterator<BookDTO> itBook = cancelList.iterator();
		
		while(itBook.hasNext()) {
			
			cancelBook = itBook.next();
			
			String cancelBookNum = cancelBook.getBookNum(); // ���Ź�ȣ
			System.out.println(cancelBookNum);
			
			int seat_num = cancelBook.getSeat_num(); // �¼���޹�ȣ
			System.out.println(seat_num);
			
			int cancelBookSu = cancelBook.getBookSu(); // Ƽ�ϼ���
			System.out.println(cancelBookSu);
			
			int getSeatSu = 0; // ���� �¼���޿� ���� ����� �¼��� �ҷ��ð���
			
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
				
			} else { // (seat_num==8)�϶� 
				
				getSeatSu = dtoSeat.getSeat8();
				
				getSeatSu = getSeatSu + cancelBookSu;
				
				dtoSeat.setSeat8(getSeatSu);
				daoBook.updateSeat8(dtoSeat);
				
			}
		}
		
		
	//	��������ϱ�
		daoBook.deleteBook(bookCancelNum); // ���� �������� ��Ҿ��ϸ� ������ �� ���󰨤Ф�	
		
		req.setAttribute("mypageNum", req.getParameter("mypageNum"));
		req.setAttribute("pageNum", req.getParameter("pageNum"));
		
		return "mypage.tiles";
	}
	
	
	
}






