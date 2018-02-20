package com.exe.ticketfactory;



import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.exe.ticketfactory.dao.BookDAO;
import com.exe.ticketfactory.dao.TicketDAO;
import com.exe.ticketfactory.dto.BookDTO;
import com.exe.ticketfactory.dto.EmailDTO;
import com.exe.ticketfactory.dto.GroupReservationDTO;
import com.exe.ticketfactory.dto.SearchDTO;
import com.exe.ticketfactory.dto.SeatDTO;
import com.exe.ticketfactory.dto.ShowDTO;
import com.exe.ticketfactory.dto.TicketDTO;
import com.jdbc.util.MyUtil;

@Controller
public class SignController {
	
	@Resource(name="ticketDAO")
	TicketDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@Autowired
	@Qualifier("bookDAO")
	BookDAO daoBook;
	

	@Autowired
	
	   private EmailSender emailSender;
	   @Autowired
	   private EmailDTO email;
	   @RequestMapping(value = "/mail.action", method = {RequestMethod.GET,RequestMethod.POST})
	    public ModelAndView sendEmailAction (HttpServletRequest request, ModelMap model, GroupReservationDTO dto,int count) throws Exception {
	        ModelAndView mav;
	        String groupName= dto.getGroupName();
	        String groupShowId = dto.getShowId();
	        int groupBookPrice = dto.getGroupBookPrice();
	        String groupBookEmail = dto.getGroupBookEmail();
	        String groupBookTel = dto.getGroupBookTel();
	        System.out.println(groupShowId);
	        
	        List<GroupReservationDTO> lists = new ArrayList<GroupReservationDTO>(); // ���ų��� ����ֱ�
			
//	    	����(����+����)���� ���Ź�ȣ ����(10�ڸ�)
			String bookNum = "";
			Random random = new Random();
			
			String text[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9".split(",");
			
			for (int i=0; i<15; i++) {
				bookNum += text[random.nextInt(text.length)];
			}
			GroupReservationDTO dtoGroup = new GroupReservationDTO();	
			for(int i=0; i<count; i++) {
				
				
				dtoGroup.setGroupName(groupName);
				dtoGroup.setShowId(groupShowId);
				dtoGroup.setGroupBookPrice(groupBookPrice);
				dtoGroup.setGroupBookEmail(groupBookEmail);
				dtoGroup.setGroupBookTel(groupBookTel);
				dtoGroup.setGroupBookNum(bookNum+i);
				dtoGroup.setGroupShowDay(request.getParameter("bookDate"+i));
				dtoGroup.setGroupShowTime(request.getParameter("showTime"+i));
				dtoGroup.setGroupBookSu(Integer.parseInt(request.getParameter("bookSu"+i)));
				dtoGroup.setGroupBookPriceEach(Integer.parseInt(request.getParameter("bookPrice"+i)));
				dtoGroup.setGroupBookSeat(request.getParameter("seat"+i)); // �¼� ���
				dtoGroup.setGroupSeat_Num(Integer.parseInt(request.getParameter("seat_num"+i)));
				
				daoBook.insertGroupBook(dtoGroup);
			}
			
			List<GroupReservationDTO> GroupList = new ArrayList<GroupReservationDTO>();
			
			for(int i=0; i<count; i++) {
				
				
				dtoGroup = daoBook.getReadSuccessGroup(bookNum+i);
				
				GroupList.add(dtoGroup);
				
				SeatDTO dtoSeat = new SeatDTO();
				
				dtoSeat.setShowDate(dtoGroup.getGroupShowDay());
				dtoSeat.setShowTime(dtoGroup.getGroupShowTime());
				dtoSeat.setShowId(dtoGroup.getShowId());
				
				dtoSeat = daoBook.getReadTimeTableGroup(dtoSeat);
				
				
				int seat_num = dtoGroup.getGroupSeat_Num();
				int bookSu = dtoGroup.getGroupBookSu();
				
				int subSeat = 0; // �������� �¼���
				int getSeatSu = 0; // �ش� �¼��� ���� �¼���
				
				if(seat_num==1) {
					
					getSeatSu = dtoSeat.getSeat1();
					
					subSeat = getSeatSu - bookSu;
					
					
					dtoSeat.setSeat1(subSeat);
			//		daoBook.updateSeat(dtoTime);
					daoBook.updateSeat1(dtoSeat);
					
				} else if(seat_num==2) {
					
					getSeatSu = dtoSeat.getSeat2();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat2(subSeat);
					daoBook.updateSeat2(dtoSeat);
					
				} else if(seat_num==3) {
					
					getSeatSu = dtoSeat.getSeat3();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat3(subSeat);
					daoBook.updateSeat3(dtoSeat);
					
				} else if(seat_num==4) {
					
					getSeatSu = dtoSeat.getSeat4();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat4(subSeat);
					daoBook.updateSeat4(dtoSeat);
					
				} else if(seat_num==5) {
					
					getSeatSu = dtoSeat.getSeat5();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat5(subSeat);
					daoBook.updateSeat5(dtoSeat);
					
				} else if(seat_num==6) {
					
					getSeatSu = dtoSeat.getSeat6();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat6(subSeat);
					daoBook.updateSeat6(dtoSeat);
					
				} else if(seat_num==7) {
					
					getSeatSu = dtoSeat.getSeat7();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat7(subSeat);
					daoBook.updateSeat7(dtoSeat);
					
				} else { // seat_num==8�� ���
					
					getSeatSu = dtoSeat.getSeat8();
					
					subSeat = getSeatSu - bookSu;
					
					dtoSeat.setSeat8(subSeat);
					daoBook.updateSeat8(dtoSeat);
				}
				
				
				
				
			}
			
	     
	        
	      
	        
	        
	            email.setContent("�����ȣ:skdjfhskjh112");
	            email.setReceiver(groupBookEmail);
	            email.setSubject("[����Ȯ��]"+groupName+"�� ���Ź�ȣ�� �߼��� ��Ƚ��ϴ�.");
	            emailSender.SendEmail(email);
	           
	            mav= new ModelAndView("/admin/adminPage.tiles");
	            return mav;
	
	            
	        
	    }

	
	
	
	@RequestMapping(value="/sign.action", method={RequestMethod.GET,RequestMethod.POST})
	public String sign(HttpServletRequest request){
		
		
		
		return "sign.tiles";
		
	}
	
	@RequestMapping(value="/sign_ok.action", method={RequestMethod.GET,RequestMethod.POST})
	public String sign_ok(TicketDTO dto){
		
		dao.insertData(dto);
		
		return "redirect:/main.action";
		
	}
	
	
	@RequestMapping(value="/mypage.action", method={RequestMethod.GET,RequestMethod.POST})
	public String mypage(HttpServletRequest request){
		
		String mypageNum = request.getParameter("mypageNum");
		String pageNum = request.getParameter("pageNum");
		if(mypageNum==null){
		mypageNum = (String) request.getAttribute("mypageNum");
		}
		
		request.setAttribute("mypageNum", mypageNum);
		request.setAttribute("pageNum", pageNum);
		return "mypage.tiles";
		
	}
	
	@RequestMapping(value="/mypage_01.action", method={RequestMethod.GET,RequestMethod.POST})
	public String mypage_01(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		String cp = request.getContextPath();
		
		int numPerPage = 2;
		int totalPage = 0;
		int totalDataCount = 0;
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null)
			pageNum = (String)session.getAttribute("pageNum");
		
		session.removeAttribute("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!= null && !pageNum.equals(""))
			currentPage = Integer.parseInt(pageNum);
		
		/*String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		
		if(searchKey ==null){
			searchKey = "subject";
			searchValue = "";
		}
		
		if(request.getMethod().equalsIgnoreCase("GET"))
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("searchKey", searchKey);
		hMap.put("searchValue", searchValue);*/
		
		TicketDTO dto = (TicketDTO) session.getAttribute("loginDto");
		
		String userId =  dto.getUserId();
		
		totalDataCount = dao.getBookCount(userId);
		
		if(totalDataCount!=0)
			totalPage = myUtil.getPageCount(numPerPage, totalDataCount);
		int start = (currentPage-1)* numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<Object> All_list = new ArrayList<Object>();
		/*List<Object> lists = 
				dao.getBookList(start, end, userId);*/
		
		List<BookDTO> lists = 
				dao.getBookAll(userId);
		
		
		
		int  n = 0;
		Iterator<BookDTO> it = lists.iterator();
		/*ListIterator<Object> it = lists.listIterator();*/
		String comBookNum [] = new String[totalDataCount];
		while(it.hasNext()){
			
			BookDTO vo = (BookDTO)it.next();
			
			String bookNum = vo.getBookNum();
			
			
			System.out.println(bookNum);
			
			int increase_num = 0;
			if(n==0){
				System.out.println("����");
				comBookNum[n] = bookNum.substring(0, 15);
				bookNum = bookNum.substring(0, 15);
				List<BookDTO> lists_bookNum = daoBook.cancelList(bookNum);
				All_list.add(lists_bookNum);
			}else{
				
			
				bookNum = bookNum.substring(0, 15);
					for(int j = 0;j<comBookNum.length;j++ ){
					if(bookNum.equals(comBookNum[j])){
						
						increase_num +=1; 
						System.out.println(increase_num+"��������");
					}
			
				}
				if(increase_num==0){
					List<BookDTO> lists_bookNum = daoBook.cancelList(bookNum);
					System.out.println(increase_num);
					All_list.add(lists_bookNum);
					System.out.println(comBookNum[n]);
					
				}
					
				
				
			}
			comBookNum[n] = bookNum.substring(0, 15);
			n++;
			
			
			
		}
		
		String  params = "";
		String urlList = "";
		
		
		/*if(!searchValue.equals("")){
			
			searchValue = URLEncoder.encode(searchValue, "UTF-8");
			params = "searchKey=" + searchKey +
					"&searchValue=" + searchValue;
			
		}*/
		
		if(params.equals("")){
			urlList = cp + "/mypage.action?mypageNum=01";
			
		}
		
		
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("all_list", All_list);
		request.setAttribute("lists", lists);
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalDataCount", totalDataCount);
		request.setAttribute("pageIndexList",myUtil.pageIndexList(currentPage, totalPage, urlList));
	
		
		
		return "mypage_01";

		
	}
	
	@RequestMapping(value="/mypage_02.action", method={RequestMethod.GET,RequestMethod.POST})
	public String mypage_02(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		String cp = request.getContextPath();
		
		int numPerPage = 2;
		int totalPage = 0;
		int totalDataCount = 0;
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null)
			pageNum = (String)session.getAttribute("pageNum");
		
		session.removeAttribute("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!= null && ! pageNum.equals(""))
			currentPage = Integer.parseInt(pageNum);
		
		/*String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		
		if(searchKey ==null){
			searchKey = "subject";
			searchValue = "";
		}
		
		if(request.getMethod().equalsIgnoreCase("GET"))
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("searchKey", searchKey);
		hMap.put("searchValue", searchValue);*/
		
		TicketDTO dto = (TicketDTO) session.getAttribute("loginDto");
		
		String userId =  dto.getUserId();
		
		totalDataCount = dao.getBookCount(userId);
		
		if(totalDataCount!=0)
			totalPage = myUtil.getPageCount(numPerPage, totalDataCount);
		int start = (currentPage-1)* numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<Object> All_list = new ArrayList<Object>();
		/*List<Object> lists = 
				dao.getBookList(start, end, userId);*/
		
		List<BookDTO> lists = 
				dao.getBookAll(userId);
		
		
		
		int  n = 0;
		Iterator<BookDTO> it = lists.iterator();
		/*ListIterator<Object> it = lists.listIterator();*/
		String comBookNum [] = new String[totalDataCount];
		while(it.hasNext()){
			
			BookDTO vo = (BookDTO)it.next();
			
			String bookNum = vo.getBookNum();
			
			
			
			
			int increase_num = 0;
			if(n==0){
				comBookNum[n] = bookNum.substring(0, 15);
				bookNum = bookNum.substring(0, 15);
				List<BookDTO> lists_bookNum = daoBook.cancelList(bookNum);
				All_list.add(lists_bookNum);
			}else{
				
			
				bookNum = bookNum.substring(0, 15);
					for(int j = 0;j<comBookNum.length;j++ ){
					if(bookNum.equals(comBookNum[j])){
						
						increase_num +=1; 
						System.out.println(increase_num);
					}
			
				}
				if(increase_num==0){
					List<BookDTO> lists_bookNum = daoBook.cancelList(bookNum);
					System.out.println(increase_num);
					All_list.add(lists_bookNum);
					System.out.println(comBookNum[n]);
					
				}
					
				
				
			}
			comBookNum[n] = bookNum.substring(0, 15);
			n++;
			
			
			
		}
		
		String  params = "";
		String urlList = "";
		
		
		/*if(!searchValue.equals("")){
			
			searchValue = URLEncoder.encode(searchValue, "UTF-8");
			params = "searchKey=" + searchKey +
					"&searchValue=" + searchValue;
			
		}*/
		
		if(params.equals("")){
			urlList = cp + "/mypage.action?mypageNum=02";
			
		}
		
		
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("all_list", All_list);
		request.setAttribute("lists", lists);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalDataCount", totalDataCount);
		request.setAttribute("pageIndexList",myUtil.pageIndexList(currentPage, totalPage, urlList));
	
		
		
		return "mypage_02";

		
	}
	
	@RequestMapping(value="/mypage_03.action", method={RequestMethod.GET,RequestMethod.POST})
	public String mypage_03(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		TicketDTO dto = (TicketDTO) session.getAttribute("loginDto");
		
		String[] email_total = dto.getUserEmail().split("@");
		String email_first = email_total[0];
		String email_last = email_total[1];
		String mypageNum = request.getParameter("mypageNum");
		String pageNum = request.getParameter("pageNum");
		
		request.setAttribute("email_first", email_first);
		request.setAttribute("email_last", email_last);
		request.setAttribute("mypageNum", mypageNum);
		request.setAttribute("pageNum", pageNum);
		
		return "mypage_03";
		
	}
	
	@RequestMapping(value="/mypage_04.action", method={RequestMethod.GET,RequestMethod.POST})
	public String mypage_04(){
		
		return "mypage_04";
		
	}
	
	

	
	/*@RequestMapping(value="/login_checker.action", method={RequestMethod.GET,RequestMethod.POST})
	public String login_checker(HttpServletRequest request){
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		TicketDTO dto = dao.login(userId, userPwd);
		String message = "";
		
		if(dto==null){
			
		    message = "ID Ȥ�� �н����尡 ���� �ʽ��ϴ�.";
		    
		    
			
		}else{
			message = userId;
			HttpSession session = request.getSession(true);
			
			session.setAttribute("loginDto", dto);
		}
		
		request.setAttribute("message", message);
		
		return "login_checker";
		
	}*/
	
	@RequestMapping(value="/login_checker.action", method={RequestMethod.GET,RequestMethod.POST})
	public String login_checker(HttpServletRequest request){
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String whoRU = request.getParameter("whoRU");
		String message = "";
		
		System.out.println(whoRU);
		//������ ȸ����
		if(whoRU=="������" || whoRU.equals("������")){
			
			if(userId.equals("admin") && userPwd.equals("123456" )){
				message = "success";			
				HttpSession session = request.getSession(true);				
				session.setAttribute("adminId", userId);
				//return "redirect:/adminPage.action";
			}else{			
				message = "������ ID/��й�ȣ�� Ʋ�Ƚ��ϴ�.";			
			}
					
		}else{	
		TicketDTO dto = dao.login(userId, userPwd);	
		
		if(dto==null){		
		    message = "ID Ȥ�� �н����尡 ���� �ʽ��ϴ�.";		    
			
		}else{
			message = "success";
			HttpSession session = request.getSession(true);		
			session.setAttribute("loginDto", dto);
			session.removeAttribute("adminId");
		}		
		}		
		request.setAttribute("message", message);
		return "login_checker";
		
	}
	
	@RequestMapping(value="/login_out.action", method={RequestMethod.GET,RequestMethod.POST})
	public String login_out(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("loginDto");
		session.invalidate();
		
		return "redirect:/main.action";
		
	}
	
	@RequestMapping(value="/update.action", method={RequestMethod.GET,RequestMethod.POST})
	public String update(TicketDTO dto,HttpServletRequest request){
		
		String pageNum = "01";
		String userId = dto.getUserId();
		dao.updateData(dto);
		
		dto = dao.checkId(userId);

		HttpSession session = request.getSession(true);
		
		String mypageNum = "01";
				
		
		
		session.setAttribute("loginDto", dto);
		request.setAttribute("mypageNum", mypageNum);
		request.setAttribute("pageNum", pageNum);
		
		return "redirect:/mypage.action?pageNum="+pageNum+"&mypageNum=" + mypageNum;
		
	}
	
	@RequestMapping(value="/delete.action", method={RequestMethod.GET,RequestMethod.POST})
	public String delete(HttpServletRequest request){
		
		return "delete.tiles";
		
	}
	
	@RequestMapping(value="/delete_ok.action", method={RequestMethod.GET,RequestMethod.POST})
	public String delete_ok(HttpServletRequest request){
		
		String userId = request.getParameter("userId");
		dao.deleteData(userId);
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("loginDto");
		session.invalidate();
		
		return "redirect:/main.action";//main���� �ٲܺκ�
	}
	
	@RequestMapping(value="/search_id_checker.action", method={RequestMethod.GET,RequestMethod.POST})
	public String search_id_checker(HttpServletRequest request){
		
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		System.out.println(userName);
		System.out.println(userEmail);
		TicketDTO dto = dao.search_id(userName, userEmail);
		String message = "";
		if(dto!=null){
			message = dto.getUserId();
			
		}else{
			message = "not_exist";
		}
		
		request.setAttribute("message", message);
		
		return "search_id_checker";
		
	}
	
	@RequestMapping(value="/search_pwd_checker.action", method={RequestMethod.GET,RequestMethod.POST})
	public String search_pwd_checker(HttpServletRequest request){
		
		String userId = request.getParameter("userId");
		String userEmail = request.getParameter("userEmail");
		System.out.println(userId);
		System.out.println(userEmail+"aaaa");
		TicketDTO dto = dao.search_pwd(userId, userEmail);
		String message = "";
		if(dto!=null){
			message = dto.getUserPwd();
			
		}else{
			message = "not_exist";
		}
		
		request.setAttribute("message", message);
		
		return "search_id_checker";
		
	}
	
	@RequestMapping(value="/show_content.action", method={RequestMethod.GET,RequestMethod.POST})
	public String show_content(HttpServletRequest request){
		
		
		
		return "show_content.tiles";
		
	}
	
	@RequestMapping(value="/login_id_checker.action", method={RequestMethod.GET,RequestMethod.POST})
	public String login_id_checker(HttpServletRequest request){
		
		String userId = request.getParameter("userId");
		TicketDTO dto = dao.checkId(userId);
		String message = "";
		if(dto==null){
			
			message = "��밡���� ���̵� �Դϴ�.";
			
		}else{
			message = "������� ���̵� �Դϴ�.";
		}
		
		request.setAttribute("message", message);
		
		return "login_id_checker";
		
	}

	@RequestMapping(value="/group.action", method={RequestMethod.GET,RequestMethod.POST})
	public String group(HttpServletRequest request){
		
		
		return "group";
		
	}
	
	
	@RequestMapping(value="/search_play.action", method={RequestMethod.POST,RequestMethod.GET})
	public String searchData(ShowDTO dtoShow,SearchDTO dtoSearch, HttpServletRequest req) throws Exception {
		
		String cp = req.getContextPath();
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		String search_word = req.getParameter("searchPlayName");
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			search_word = URLDecoder.decode(search_word, "UTF-8");
		}
		
		int dataCount = dao.getDataCount(search_word); // ��ü�����Ͱ���
		
		int numPerPage = 5;
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
			
			List<SearchDTO> searchList = dao.searchList(search_word, start, end);
			
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
		
	//	����¡
		String param = "";
		
		if(!search_word.equals("")) {
			param =  URLEncoder.encode(search_word, "UTF-8");
		}
		
		
		String listUrl =param;
	
		
		String pageIndexList = myUtil.pageIndexListModal(currentPage, totalPage, listUrl);
		
		
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		
		return "search_play";
	}
	
		
	}
	




