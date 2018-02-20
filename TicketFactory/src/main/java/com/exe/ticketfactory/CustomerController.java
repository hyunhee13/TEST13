package com.exe.ticketfactory;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.exe.ticketfactory.board.dao.EnquiryCommentDAO;
import com.exe.ticketfactory.board.dao.EnquiryDAO;
import com.exe.ticketfactory.board.dao.EventDAO;
import com.exe.ticketfactory.board.dao.FaqDAO;
import com.exe.ticketfactory.board.dao.NoticeDAO;
import com.exe.ticketfactory.board.dao.YangdoCommentDAO;
import com.exe.ticketfactory.board.dao.YangdoDAO;
import com.exe.ticketfactory.board.dto.EnquiryCommentDTO;
import com.exe.ticketfactory.board.dto.EnquiryDTO;
import com.exe.ticketfactory.board.dto.EventDTO;
import com.exe.ticketfactory.board.dto.FaqDTO;
import com.exe.ticketfactory.board.dto.FileuploadDTO;
import com.exe.ticketfactory.board.dto.NoticeDTO;
import com.exe.ticketfactory.board.dto.ShowReviewDTO;
import com.exe.ticketfactory.board.dto.YangdoCommentDTO;
import com.exe.ticketfactory.board.dto.YangdoDTO;
import com.exe.ticketfactory.dao.Detail2DAO;
import com.exe.ticketfactory.dto.TicketDTO;
import com.jdbc.util.MyBoardUtil;
import com.jdbc.util.MyUtil;

@Controller
public class CustomerController {

	@Autowired
	@Qualifier("noticeDAO")
	NoticeDAO dao;
	
	@Autowired
	@Qualifier("faqDAO")
	FaqDAO fdao;
	
	@Autowired
	@Qualifier("enquiryDAO")
	EnquiryDAO edao;
	
	@Autowired
	@Qualifier("eqCommentDAO")
	EnquiryCommentDAO ecdao;
	
	@Autowired
	@Qualifier("ydCommentDAO")
	YangdoCommentDAO ydcdao;
	
	@Autowired
	@Qualifier("eventDAO")
	EventDAO eventdao;
	
	@Autowired
	@Qualifier("yangdoDAO")
	YangdoDAO yangdao;
	
	@Autowired
	@Qualifier("myBoardUtil")
	MyBoardUtil myUtil;
	
	@Autowired
	@Qualifier("myUtil")
	MyUtil myUtil2;
	
	@Autowired
	@Qualifier("detail2DAO")
	Detail2DAO dao2;
	
	
	//실시간 별점
	@RequestMapping(value = "/reviewBoard.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String reviewBoard(HttpServletRequest req,String showId, String showName,
			HttpServletResponse response) throws Exception {
		
		//////////페이징 처리///////////////////
		String cp = req.getContextPath();
		
		String pageNum =  req.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey == null){
			searchKey = "content";
			searchValue = "";
		}else{
			if(req.getMethod().equalsIgnoreCase("GET"))
				searchValue = 
					URLDecoder.decode(searchValue,"UTF-8");
		}
		
		//전체 데이터 개수
		int dataCount = dao2.getDataCount(searchKey, searchValue);
		
		//전체 페이지 수
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<ShowReviewDTO> lists =
				dao2.getListReview(start, end, searchKey, searchValue);
		
		//페이징 처리
		String param = "";
		if(!searchValue.equals("")){
			param  = "searchKey=" + searchKey;
			param += "&searchValue="
					+URLEncoder.encode(searchValue,"UTF-8");
		}
		
		String listUrl = cp + "/reviewBoard.action";
		
		if(!param.equals("")){
			listUrl = listUrl + "?" + param;
		}
		
		String pageIndexList = 
				myUtil2.pageIndexList(currentPage, totalPage, listUrl);
		
		/////////////////////////페이징 처리 끝/////////////////////////////////////////
		
		Iterator<ShowReviewDTO> it = lists.iterator();
		
		while(it.hasNext()){
			
			ShowReviewDTO stardto = it.next();
			
			int star_num = stardto.getStar();
			
			switch (star_num) {
			case 1:
				stardto.setStar2("/ticketfactory/resources/image/star1.JPG");
				break;
			case 2:
				stardto.setStar2("/ticketfactory/resources/image/star2.JPG");
				break;
			case 3:
				stardto.setStar2("/ticketfactory/resources/image/star3.JPG");
				break;
			case 4:
				stardto.setStar2("/ticketfactory/resources/image/star4.JPG");
				break;
			case 5:
				stardto.setStar2("/ticketfactory/resources/image/star5.JPG");
				break;
			}
			
		}

		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("lists", lists);
		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){
			return "reviewBoard.tiles";
		}
		return "/admin/reviewBoard.tiles";
	}
	
	
	@RequestMapping(value="changeReviewBoard.action", method={RequestMethod.GET, RequestMethod.POST})
	public String changeReviewBoard(HttpServletRequest req,String pageNum){
		
		//////////페이징 처리///////////////////
		String cp = req.getContextPath();
	
		
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		
		//전체 데이터 개수
		List<String> reviewCount = dao2.getReviewCount();
		int dataCount = reviewCount.size();
		System.out.println(dataCount+"개!!!!");
		
		//전체 페이지 수
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		System.out.println(totalPage+"페이지!!!");
		
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<ShowReviewDTO> lists =
				dao2.getReviewAvg(start, end);
		
		//페이징 처리
		String listUrl = cp + "/changeReviewBoard.action";
		
		String pageIndexList = 
				myUtil2.pageIndexList(currentPage, totalPage, listUrl);
		System.out.println(pageIndexList);
		
		/////////////////////////페이징 처리 끝/////////////////////////////////////////
		
		Iterator<ShowReviewDTO> it = lists.iterator();
		
		while(it.hasNext()){
			
			ShowReviewDTO stardto = it.next();
			System.out.println(stardto.getShowName());
			
			int star_num = dao2.getStarAvg(stardto.getShowId());
			stardto.setStar(star_num);
			
			switch (star_num) {
			case 1:
				stardto.setStar2("/ticketfactory/resources/image/star1.JPG");
				break;
			case 2:
				stardto.setStar2("/ticketfactory/resources/image/star2.JPG");
				break;
			case 3:
				stardto.setStar2("/ticketfactory/resources/image/star3.JPG");
				break;
			case 4:
				stardto.setStar2("/ticketfactory/resources/image/star4.JPG");
				break;
			case 5:
				stardto.setStar2("/ticketfactory/resources/image/star5.JPG");
				break;
			}
			
		}

		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("lists", lists);
		req.setAttribute("mode", "play");
		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){
			return "reviewBoard.tiles";
		}
		return "/admin/reviewBoard.tiles";
		//return "reviewPlay";
	}
	
	//공지글쓰기
	@RequestMapping(value = "/notiCreated.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String notiCreated(){
		
		return "/admin/noticeCreated.tiles";
	}
	
	//아작스 공지사항부분
	@RequestMapping(value = "/centerNotice.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String centerNotice(HttpServletResponse resp,HttpServletRequest req){
		
		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		//전체데이터갯수
		int dataCount = dao.getDataCount();
				
		//전체페이지수
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<NoticeDTO> lists = 
				dao.getList(start, end);
		
		/*//페이징 처리
		String listUrl = cp + "/centerNotice.action";*/
		
		String pageIndexList =
				myUtil.pageIndexList(currentPage, totalPage);
/*
		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);*/
	
		//글보기 주소 정리
		String articleUrl = 
			cp + "/notiArticle.action?pageNum=" + currentPage;
	
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		req.setAttribute("currentPage", currentPage);
		
	
		return "customerCenterNotice.tiles";
	}
	
	//공지글쓰기
	@RequestMapping(value="/notiCreated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String created_ok(NoticeDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int maxNum = dao.getMaxNum();
		
		dto.setNotiNum(maxNum+1);

		dao.insertData(dto);
		
		return "redirect:/notiList.action";
		
	}
		
	//공지리스트
	@RequestMapping(value="/notiList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String noticelist(HttpServletRequest req,HttpServletResponse resp){


		
		//System.out.println(adminId);

		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		//전체데이터갯수
		int dataCount = dao.getDataCount();
				
		//전체페이지수
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<NoticeDTO> lists = 
				dao.getList(start, end);
		
		//페이징 처리
		String listUrl = cp + "/notiList.action";
		
		/*String pageIndexList =
				myUtil.pageIndexList(currentPage, totalPage);*/

		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
		//글보기 주소 정리
		String articleUrl = 
			cp + "/notiArticle.action?pageNum=" + currentPage;
	
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		req.setAttribute("currentPage", currentPage);
		
		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){
			return "noticeList.tiles";		
		}
		return "/admin/noticeList.tiles";
		
	}
	
	//공지글보기
	@RequestMapping(value="/notiArticle.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String noticeAriticle(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String cp = req.getContextPath();
		
		int notiNum = Integer.parseInt(req.getParameter("notiNum"));
		String pageNum = req.getParameter("pageNum");
		
		NoticeDTO dto = dao.getReadData(notiNum);
		
		if(dto==null){
			String url = cp + "/notiList.action";
			resp.sendRedirect(url);
		}
	
		dto.setNotiContent(dto.getNotiContent().replaceAll("\n", "<br/>"));
		
		String param = "pageNum=" + pageNum;
		
		req.setAttribute("dto", dto);
		req.setAttribute("params",param);
		req.setAttribute("pageNum",pageNum);	

		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		System.out.println("noticeArticle"+adminId);
		if(adminId=="" || adminId==null){
			return "noticeArticle.tiles";		
		}
		return "/admin/noticeArticle.tiles";
		
	
	}
	
	//앙 업데이트!
	@RequestMapping(value="/notiUpdated.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String updated(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String cp = req.getContextPath();
		
		int notiNum = Integer.parseInt(req.getParameter("notiNum"));
		String pageNum = req.getParameter("pageNum");
		
		NoticeDTO dto = dao.getReadData(notiNum);
		
		if(dto == null){
			String url = cp + "/notiList.action";
			resp.sendRedirect(url);
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("pageNum", pageNum);
		
		return "/admin/noticeUpdated.tiles";
		
	}	
		
	//공지업데이트
	@RequestMapping(value="/notiUpdated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String updated_ok(NoticeDTO dto,HttpServletRequest req,HttpServletResponse resp) throws Exception{

		String pageNum = req.getParameter("pageNum");
		
		dao.updateData(dto);
		
		return "redirect:/notiList.action?pageNum=" + pageNum;

	}	
	
	//공지삭제
	@RequestMapping(value="/notiDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String deleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int notiNum =Integer.parseInt(req.getParameter("notiNum"));
		
		dao.deleteData(notiNum);
		
		return "redirect:/notiList.action?pageNum=" + pageNum;
	}
	
	//FAQ리스트
	@RequestMapping(value = "/faqList.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String centerFaq(HttpServletResponse resp,HttpServletRequest req){
		

		
		//System.out.println(adminId);
		
		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
	
		List<FaqDTO> fhlists = fdao.fgetHitCountList();

		//전체데이터갯수
		int dataCount = fdao.faqGetDataCount();
				
		//전체페이지수
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<FaqDTO> lists = 
				fdao.fgetList(start, end);
		
		//페이징 처리
		String listUrl = cp + "/faqList.action";
		
		/*String fpageIndexList =
				myUtil.faqPageIndexList(currentPage, totalPage);
*/
		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
		//글보기 주소 정리
		String articleUrl = 
			cp + "/faqArticle.action?pageNum=" + currentPage;
	
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("fhlists", fhlists);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		req.setAttribute("currentPage", currentPage);
		
		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){	
			return "faqList.tiles";		
		}
		return "/admin/faqList.tiles";	
	}
	
	//FAQ쓰기
	@RequestMapping(value = "/faqCreated.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String faqCreated(){
	
		return "/admin/faqCreated.tiles";
	}
	
	@RequestMapping(value="/faqCreated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String faq_ok(FaqDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int maxNum = fdao.getMaxNum();
		
		dto.setFaqNum(maxNum+1);

		fdao.insertData(dto);
		
		return "redirect:/faqList.action";
		
	}
	
	//FAQ글보기
	@RequestMapping(value="/faqArticle.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String faqAriticle(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String cp = req.getContextPath();
		
		int faqNum = Integer.parseInt(req.getParameter("faqNum"));
		String pageNum = req.getParameter("pageNum");
		
		//조회수 증가
		fdao.faqUpdateHitCount(faqNum);
		FaqDTO dto = fdao.getReadData(faqNum);
		
		if(dto==null){
			String url = cp + "/notiList.action";
			resp.sendRedirect(url);
		}
		
		dto.setFaqContent(dto.getFaqContent().replaceAll("\n", "<br/>"));
		
		String param = "pageNum=" + pageNum;
		
		req.setAttribute("dto", dto);
		req.setAttribute("params",param);
		req.setAttribute("pageNum",pageNum);	

		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		System.out.println("faqAriticle"+adminId);
		if(adminId=="" || adminId==null){	
			return "faqArticle.tiles";		
		}
		return "/admin/faqArticle.tiles";
	}
	
	@RequestMapping(value="/faqUpdated.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String faqupdated(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String cp = req.getContextPath();
		
		int faqNum = Integer.parseInt(req.getParameter("faqNum"));
		String pageNum = req.getParameter("pageNum");
		
		FaqDTO dto = fdao.getReadData(faqNum);
		
		if(dto == null){
			String url = cp + "/faqList.action";
			resp.sendRedirect(url);
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("pageNum", pageNum);
		
		
		return "/admin/faqUpdated.tiles";
		
	}	
	
	//FAQ업데이트
	@RequestMapping(value="/faqUpdated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String faqupdated_ok(FaqDTO dto,HttpServletRequest req,HttpServletResponse resp) throws Exception{

		String pageNum = req.getParameter("pageNum");
		
		fdao.updateData(dto);
		
		return "redirect:/faqList.action?pageNum=" + pageNum;

	}	
	
	//FAQ삭제
	@RequestMapping(value="/faqDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String faqDeleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int faqNum =Integer.parseInt(req.getParameter("faqNum"));
		
		fdao.faqDeleteData(faqNum);
		
		return "redirect:/faqList.action?pageNum=" + pageNum;
	}
	
	//refund 환불/취소안내
	@RequestMapping(value="/refundList.action",method={RequestMethod.GET,RequestMethod.POST})
	public String refundlist(){
			
		return "refundList.tiles";
		
	}
	
	//문의 게시판 리스트
	@RequestMapping(value="/eqList.action",
		method={RequestMethod.GET,RequestMethod.POST})
	public String enquirylist(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		HttpSession session = req.getSession();
		String adminId = (String) session.getAttribute("adminId");

		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey == null){
			
			searchKey = "eqSubject";
			searchValue = "";
			
		}else{
			
			if(req.getMethod().equalsIgnoreCase("GET"))
				searchValue =
					URLDecoder.decode(searchValue, "UTF-8");
			
		}
		
		//전체데이터갯수
		int dataCount = 0;
		
		if(adminId=="" || adminId==null){
			
			TicketDTO tdto = (TicketDTO) session.getAttribute("loginDto");
			String eqId = tdto.getUserId();
			
			System.out.println(eqId);
			System.out.println("여기왔냐?");
		
			dataCount = edao.getMemberDataCount(searchKey, searchValue, eqId);
			
		}else{
			
			dataCount = edao.getDataCount(searchKey, searchValue);
			
		}
		
		//전체페이지수
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<EnquiryDTO> lists = new ArrayList<EnquiryDTO>();
		
		if(adminId=="" || adminId==null){
			
			TicketDTO tdto = (TicketDTO) session.getAttribute("loginDto");
			String eqId = tdto.getUserId();
			
			System.out.println(eqId);
			System.out.println("여기왔냐?2");

			lists =
				edao.getMemberList(start, end, searchKey, searchValue,eqId);
			
		}else{
			
			lists =
				edao.getList(start, end, searchKey, searchValue);

		}
		
		// 일련번호
		int listNum, n = 0;
		
		Iterator<EnquiryDTO> it = lists.iterator();
		while (it.hasNext()) {

		EnquiryDTO eq = (EnquiryDTO) it.next();
		listNum = dataCount - (start + n - 1);
		
		//댓글수
		eq.setCommentNum(ecdao.GetDataCount(eq.getEqNum()));
		eq.setEqListNum(listNum);
		n++;
		}
		
		//페이징 처리
		String param = "";
		if(!searchValue.equals("")){
			param = "searchKey=" + searchKey;
			param+= "&searchValue=" 
				+ URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String listUrl = cp + "/eqList.action";
		if(!param.equals("")){
			listUrl = listUrl + "?" + param;				
		}
		
		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		//글보기 주소 정리
		String articleUrl = 
			cp + "/eqArticle.action?pageNum=" + currentPage;
			
		if(!param.equals(""))
			articleUrl = articleUrl + "&" + param;
		
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		
		if(adminId=="" || adminId==null){
			
			return "enquiryList.tiles";	
			
		}
		
		return "/admin/enquiryList.tiles";	
		
	}
	
	//문의 게시판 글보기
	@RequestMapping(value="/eqArticle.action",method={RequestMethod.GET,RequestMethod.POST})
		public String eqArticle(HttpServletRequest req,HttpServletResponse resp)throws Exception{
				
		String cp = req.getContextPath();
		
		int eqNum = Integer.parseInt(req.getParameter("eqNum"));
		String pageNum = req.getParameter("pageNum");
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey != null)
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		EnquiryDTO dto = edao.getReadData(eqNum);
		
		if(dto==null){
			String url = cp + "/eqList.action";
			resp.sendRedirect(url);
		}

		dto.setEqContent(dto.getEqContent().replaceAll("\n", "<br/>"));
		
		String param = "pageNum=" + pageNum;
		if(searchKey!=null){
			param += "&searchKey=" + searchKey;
			param += "&searchValue=" 
				+ URLEncoder.encode(searchValue, "UTF-8");
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("params",param);
		req.setAttribute("pageNum",pageNum);	

		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){	
			return "enquiryArticle.tiles";		
		}
		return "/admin/enquiryArticle.tiles";
			
		}
		
	//문의 게시판 글쓰기
	@RequestMapping(value="/eqCreated.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eqCreated(HttpServletRequest req){
			
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){	
			return "enquiryCreated.tiles";		
		}

		return "/admin/enquiryCreated.tiles";
		
	}
	
	@RequestMapping(value="/eqCreated_ok.action",method={RequestMethod.GET,RequestMethod.POST})
	public String eqCreated_ok(EnquiryDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int maxNum = edao.getMaxNum();
		
		dto.setEqNum(maxNum + 1);
		
		edao.insertData(dto);
			
		return "redirect:/eqList.action";
		
	}
	
	//문의삭제
	@RequestMapping(value="/eqDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String eqDeleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int eqNum =Integer.parseInt(req.getParameter("eqNum"));
		
		edao.deleteData(eqNum);
		
		return "redirect:/eqList.action?pageNum=" + pageNum;
	}
	
	//문의 댓글쓰기
	@RequestMapping(value="/eqcCreated.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eqcCreated(EnquiryCommentDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int eqNum = Integer.parseInt(req.getParameter("eqNum"));
		
		int maxNum = ecdao.getMaxNum();
		
		HttpSession session = req.getSession();
		
		if(session.getAttribute("loginDto")!=null){
			TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
			dto.setEqId(ticket.getUserId());
		}else if(session.getAttribute("adminId")!=null){
			dto.setEqId((String)session.getAttribute("adminId"));
		}
		dto.setEqNum(eqNum);
		dto.setEqcNum(maxNum + 1);
		
		ecdao.insertData(dto);
			
		return eqcList(req, resp);
		
	}
	
	//문의 댓글리스트
	@RequestMapping(value="/eqcList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eqcList(HttpServletRequest req,HttpServletResponse resp){
	
		String pageNum = req.getParameter("pageNum");
		int eqNum = Integer.parseInt(req.getParameter("eqNum"));
		
		int currentPage = 1;
		
		if(pageNum!=null && pageNum!=""){
			currentPage = Integer.parseInt(pageNum);
		}else{
			pageNum = "1";
		}
		//전체데이터갯수
		int dataCount = ecdao.GetDataCount(eqNum);
				
		//전체페이지수
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<EnquiryCommentDTO> lists = 
				ecdao.getList(start, end, eqNum);
		
		int listNum,n = 0;
		
		Iterator<EnquiryCommentDTO> it = lists.iterator();
		while(it.hasNext()){
			
			EnquiryCommentDTO ec = (EnquiryCommentDTO)it.next();
			listNum = dataCount-(start+n-1);
			ec.setEqcListNum(listNum);
			ec.setEqcContent(ec.getEqcContent().replaceAll("\n", "<br/>"));
			n++;
			
		}
			
		//페이징 처리
		/*String listUrl = cp + "/faqList.action";*/
		
		String pageIndexList =
				myUtil.ajaxPageIndexList(currentPage, totalPage);

		/*String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);*/
	
	
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("currentPage", currentPage);
		
	
		return "enquiryComment";
		
	}
	
	//문의 댓글삭제
	@RequestMapping(value="/eqcDeleted.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eqcDeleted(HttpServletRequest req,HttpServletResponse resp){
		
		int eqcNum = Integer.parseInt(req.getParameter("eqcNum"));
		int eqNum = Integer.parseInt(req.getParameter("eqNum"));
		String pageNum = req.getParameter("pageNum");
		
		ecdao.DeleteData(eqcNum);
		
		req.setAttribute("eqNum", eqNum);
		req.setAttribute("pageNum",pageNum);
		
		return eqcList(req, resp);

	}
	
	//이벤트게시판 리스트 헤헤
	@RequestMapping(value="/eventList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventList(HttpServletRequest req,HttpServletResponse resp){
		
		//업로드 한 파일 저장경로를 위해서 넣는다 
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;

		String cp = req.getContextPath();

		String attach_path = "resources/" + year + monthStr + "Title/";

		//페이징처리
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		//전체데이터갯수
		int dataCount = eventdao.getDataCount();
				
		//전체페이지수
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<EventDTO> lists = 
				eventdao.getList(start, end);
		
		//페이징 처리
		String listUrl = cp + "/eventList.action";
		
		/*String pageIndexList =
				myUtil.pageIndexList(currentPage, totalPage);*/

		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
		//글보기 주소 정리
		String articleUrl = 
			cp + "/eventArticle.action?pageNum=" + currentPage;
		
		//이미지 url
		String imageUrl =  cp + "/" + attach_path ;
		
	
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("imageUrl", imageUrl);
		
		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		System.out.println("eventList adminId"+adminId);
		if(adminId=="" || adminId==null){	
			return "eventList.tiles";		
		}
		return "/admin/eventList.tiles";
		
	}
	
	//이벤트게시판 글쓰기 헤헤
	@RequestMapping(value="/eventCreated.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventCreated(HttpServletRequest req,HttpServletResponse resp){
		
		return "/admin/eventCreated.tiles";
		
	}
	
	@RequestMapping(value="/eventCreated_ok.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventCreated_ok(MultipartHttpServletRequest req,
			HttpServletResponse resp,EventDTO dto) throws IOException{
		
		//업로드 한 파일 저장경로 테스트
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;

		String cp = req.getContextPath();
		
		String path = req.getSession().getServletContext().getRealPath("/");
		String attach_path = "resources/" + year + monthStr + "Title/";
		
		MultipartFile file = req.getFile("upload");
		
		/*System.out.println(file.getOriginalFilename());*/
		
		if(file != null && file.getSize()>0){
			
			try {
				//실제이름
				String originalName =file.getOriginalFilename();
				
				//확장자 가져오기
				String fileNameExt = originalName.substring(originalName.indexOf("."));
				
				//파일이름 변경
				String newFileName;
				
				newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
						      Calendar.getInstance());
				newFileName += System.nanoTime();
				newFileName += "title";
				newFileName += fileNameExt;
		
				dto.setEbTitleimage(newFileName);
				
				//폴더 생성 테스트
				File folderTest = new File(path + "/" + attach_path);
				
				if(!folderTest.exists()){
								
					folderTest.mkdirs();
				}
		
				FileOutputStream fos =
						new FileOutputStream(path + "/" + attach_path + newFileName);
				

				InputStream is = file.getInputStream();
				
				byte[] buffer = new byte[1024];
				
				while(true){
					
					int data = is.read(buffer, 0, buffer.length);
					
					if(data==-1)
						break;
					
					fos.write(buffer, 0, data);
				}
				
				is.close();
				fos.close();
				
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}else{
			
			String url = cp + "/eventList.action";
			resp.sendRedirect(url);
	
		}

		int maxNum = eventdao.getMaxNum();
	
		dto.setEbNum(maxNum+1);
	
		eventdao.insertData(dto);

		return "redirect:/eventList.action";
		
	}
	
	//이벤트게시판 글보기 헤헤
	@RequestMapping(value="/eventArticle.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventArticle(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		
		String cp = req.getContextPath();
		
		int ebNum = Integer.parseInt(req.getParameter("ebNum"));
		String pageNum = req.getParameter("pageNum");
		
		eventdao.updateHitCount(ebNum);
		EventDTO dto = eventdao.getReadData(ebNum);
		
		if(dto==null){
			String url = cp + "/eventList.action";
			resp.sendRedirect(url);
		}

		String param = "pageNum=" + pageNum;
		
		req.setAttribute("dto", dto);
		req.setAttribute("params",param);
		req.setAttribute("pageNum",pageNum);	

		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){	
			return "eventArticle.tiles";		
		}
		return "/admin/eventArticle.tiles";
		
	}
	
	//이벤트 업데이트!
	@RequestMapping(value="/eventUpdated.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String eventupdated(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String cp = req.getContextPath();
		
		int ebNum = Integer.parseInt(req.getParameter("ebNum"));
		String pageNum = req.getParameter("pageNum");
		
		EventDTO dto = eventdao.getReadData(ebNum);
		
		if(dto == null){
			String url = cp + "/eventList.action";
			resp.sendRedirect(url);
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("pageNum", pageNum);
		
		return "/admin/eventUpdated.tiles";
		
	}	
	@RequestMapping(value="/eventUpdated_ok.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventupdated_ok(MultipartHttpServletRequest req,
			HttpServletResponse resp,EventDTO dto) throws IOException{
		
		String pageNum = req.getParameter("pageNum");

		//업로드 한 파일 저장경로 테스트
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;

		String cp = req.getContextPath();
		
		String path = req.getSession().getServletContext().getRealPath("/");
		String attach_path = "resources/" + year + monthStr + "Title/";
		
		MultipartFile file = req.getFile("upload");
		
		/*System.out.println(file.getOriginalFilename());*/
		
		if(file != null && file.getSize()>0){
			
			try {
				//실제이름
				String originalName =file.getOriginalFilename();
				
				//확장자 가져오기
				String fileNameExt = originalName.substring(originalName.indexOf("."));
				
				//파일이름 변경
				String newFileName;
				
				newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
						      Calendar.getInstance());
				newFileName += System.nanoTime();
				newFileName += "title";
				newFileName +=  fileNameExt;
		
				dto.setEbTitleimage(newFileName);

				//폴더 생성 테스트
				File folderTest = new File(path + "/" + attach_path);
				
				if(!folderTest.exists()){
								
					folderTest.mkdirs();
				}
		
				FileOutputStream fos =
						new FileOutputStream(path + "/" + attach_path + newFileName);
				

				InputStream is = file.getInputStream();
				
				byte[] buffer = new byte[1024];
				
				while(true){
					
					int data = is.read(buffer, 0, buffer.length);
					
					if(data==-1)
						break;
					
					fos.write(buffer, 0, data);
				}
				
				is.close();
				fos.close();
				
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}else{
			
			String url = cp + "/eventList.action";
			resp.sendRedirect(url);
	
		}

		eventdao.updateData(dto);
		
		return "redirect:/eventList.action?pageNum=" + pageNum;

	}	
	
	//ㅎㅎ이벤트삭제
	@RequestMapping(value="/eventDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String eventdeleted(HttpServletRequest req,HttpServletResponse resp,
			EventDTO dto) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int ebNum =Integer.parseInt(req.getParameter("ebNum"));
		
		//업로드 한 파일 저장경로 테스트
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;
	
		String path = req.getSession().getServletContext().getRealPath("");
		String attach_path = "resources/" + year + monthStr + "Title/";
		String savePath = path + File.separator + attach_path;

		//물리삭제
		dto = eventdao.getReadData(ebNum);	

		eventdao.fileDeleteData(dto.getEbTitleimage(), savePath);
		
		eventdao.deleteData(ebNum);
		
		return "redirect:/eventList.action?pageNum=" + pageNum;
	}
	
	//양도게시판 리스트 헤헤
	@RequestMapping(value="/yangdoList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String yangdoList(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		
		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchKey == null){
			
			searchKey = "ydSubject";
			searchValue = "";
			
		}else{
			
			if(req.getMethod().equalsIgnoreCase("GET"))
				searchValue =
					URLDecoder.decode(searchValue, "UTF-8");
			
		}
		
		//전체데이터갯수
		int dataCount = yangdao.getDataCount(searchKey, searchValue);
		
		//전체페이지수
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<YangdoDTO> lists =
			yangdao.getList(start, end, searchKey, searchValue);
		
/*		// 일련번호
		int listNum, n = 0;
		
		Iterator<YangdoDTO> it = lists.iterator();
		while (it.hasNext()) {

		YangdoDTO dto = (YangdoDTO) it.next();
		listNum = dataCount - (start + n - 1);
		
		//댓글수
		dto.setCommentNum(ecdao.GetDataCount(eq.getEqNum()));
		eq.setEqListNum(listNum);
		n++;
		}*/
		
		//페이징 처리
		String param = "";
		if(!searchValue.equals("")){
			param = "searchKey=" + searchKey;
			param+= "&searchValue=" 
				+ URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String listUrl = cp + "/yangdoList.action";
		if(!param.equals("")){
			listUrl = listUrl + "?" + param;				
		}
		
		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		//글보기 주소 정리
		String articleUrl = 
			cp + "/yangdoArticle.action?pageNum=" + currentPage;
			
		if(!param.equals(""))
			articleUrl = articleUrl + "&" + param;
		
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
	
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){	
			return "yangdoList.tiles";		
		}
		return "/admin/yangdoList.tiles";
		}
	
	
	//양도글쓰기 
	@RequestMapping(value="/yangdoCreated.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String yangCreated(HttpServletRequest req,HttpServletResponse resp){
		
		
		return "yangdoCreated.tiles";
	}
	

	@RequestMapping(value="/yangdoCreated_ok.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String yangCreated_ok(YangdoDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int maxNum = yangdao.getMaxNum();
		
		dto.setYdNum(maxNum+1);
		dto.setYdIpAddr(req.getRemoteAddr());
		
		yangdao.insertData(dto);
			
		return "redirect:/yangdoList.action";
		
		}
	
	//양도게시판 글볼거라능 헤헤
	@RequestMapping(value="/yangdoArticle.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String yangArticle(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		
		String cp = req.getContextPath();
	
		int ydNum = Integer.parseInt(req.getParameter("ydNum"));
		
		String pageNum = req.getParameter("pageNum");
		
		yangdao.updateHitCount(ydNum);
		YangdoDTO dto = yangdao.getReadData(ydNum);
		
		if(dto==null){
			String url = cp + "/yangdoList.action";
			resp.sendRedirect(url);
		}

		String param = "pageNum=" + pageNum;
		
		req.setAttribute("dto", dto);
		req.setAttribute("params",param);
		req.setAttribute("pageNum",pageNum);	
		
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		if(adminId=="" || adminId==null){	
			return "yangdoArticle.tiles";		
		}
		return "/admin/yangdoArticle.tiles";
		}
	
	//양도삭제
	@RequestMapping(value="/yangdoDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String yangdoDeleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int ydNum =Integer.parseInt(req.getParameter("ydNum"));
		
		yangdao.deleteData(ydNum);
		ydcdao.DeleteData(ydNum);
		
		return "redirect:/yangdoList.action?pageNum=" + pageNum;
	}
	
	//양도 댓글쓰기
	@RequestMapping(value="/ydcCreated.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydcCreated(YangdoCommentDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int ydNum = Integer.parseInt(req.getParameter("ydNum"));
		
		int maxNum = ydcdao.getMaxNum();

		dto.setYdNum(ydNum);
		dto.setYdcNum(maxNum + 1);
		
		String ydcId="";
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		if(adminId==null && ticket==null){
			return ydcList(req,resp);
		}
		if(adminId==""||adminId==null){
			ydcId = ticket.getUserId();
		}else{
			ydcId = adminId;
		}
		
		System.out.println(adminId);
		
		dto.setYdcId(ydcId);
		dto.setYdcGroupNum(dto.getYdcNum());
		dto.setYdcDepth(0);
		dto.setYdcParentNum(0);
		dto.setYdcOrderNum(0);
		
		ydcdao.insertData(dto);
			
		return ydcList(req, resp);
		
	}
	
	//양도 댓글 리스트
	@RequestMapping(value="/ydcList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydcList(HttpServletRequest req,HttpServletResponse resp){
		
		String pageNum = req.getParameter("pageNum");
		int ydNum = Integer.parseInt(req.getParameter("ydNum"));
	
		
		/*System.out.println(pageNum);
		System.out.println(ydNum);*/
		
		int currentPage = 1;
		
		if(pageNum!=null && pageNum!=""){
			currentPage = Integer.parseInt(pageNum);
		}else{
			pageNum = "1";
		}
		//전체데이터갯수
		int dataCount = ydcdao.GetDataCount(ydNum);
				
		//전체페이지수
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<YangdoCommentDTO> lists = 
				ydcdao.getList(start, end, ydNum);
		
		int n = 0;
		
		Iterator<YangdoCommentDTO> it = lists.iterator();
		while(it.hasNext()){

			YangdoCommentDTO ydc = (YangdoCommentDTO)it.next();
			ydc.setYdcContent(ydc.getYdcContent().replaceAll("\n", "<br/>"));
			n++;
		}
			
		//페이징 처리
		/*String listUrl = cp + "/faqList.action";*/
		
		String pageIndexList =
				myUtil.ajaxPageIndexList(currentPage, totalPage);

		/*String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);*/

	
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("currentPage", currentPage);

	
		return "yangdoComment";
		
	}
	
	//양도 댓글삭제
	@RequestMapping(value="/ydcDeleted.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydcDeleted(HttpServletRequest req,HttpServletResponse resp){
		
		int ydcNum = Integer.parseInt(req.getParameter("ydcNum"));
		int ydNum = Integer.parseInt(req.getParameter("ydNum"));
		String pageNum = req.getParameter("pageNum");
		
		ydcdao.DeleteData(ydcNum);
	
		
		req.setAttribute("ydNum", ydNum);
		req.setAttribute("pageNum",pageNum);
		
		return ydcList(req, resp);

	}
	
	//양도 리플dkdkdkdㅏ어미라ㅓㅣㅏㅇ너리ㅏ머
	@RequestMapping(value="/yangdoReply.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydc(HttpServletRequest req,HttpServletResponse resp){
		
		int reNum = Integer.parseInt(req.getParameter("reNum"));
	
		req.setAttribute("reNum",reNum);
		
		return "yangdoReply";
		
	}
	
	//양도 리플도전
	@RequestMapping(value="/ydcReply.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydcReply(HttpServletRequest req,HttpServletResponse resp){
		
		
		return "yangdoReply.tiles";
		
	}
	
	
	//양도 리플도전
	@RequestMapping(value="/ydcReply_ok.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydcReply_ok(HttpServletRequest req,HttpServletResponse resp){
		
		String ydcId="";
		HttpSession session = req.getSession();
		String adminId = (String)session.getAttribute("adminId");
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		
		if(adminId==""||adminId==null){
			ydcId = ticket.getUserId();
		}else{
			ydcId = adminId;
		}
		
		System.out.println(ydcId);
		

		int ydcNum = Integer.parseInt(req.getParameter("ydcNum"));
		String pageNum = req.getParameter("pageNum");
		String ydcContent = req.getParameter("ydcContent");

		/*System.out.println(ydcNum);*/
		
		YangdoCommentDTO dto = ydcdao.getReadData(ydcNum);
		
		if(dto==null)
			return "dto없수무이다";
		
		dto.setYdcContent("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + ydcContent);
		
		int ydcGroupNum = dto.getYdcGroupNum();
		int ydcOrderNum = dto.getYdcOrderNum();
		
		ydcdao.replyUpdateData(ydcGroupNum, ydcOrderNum);
		
		int maxNum = ydcdao.getMaxNum();
		
		dto.setYdcId(ydcId);
		dto.setYdcNum(maxNum+1);
		dto.setYdcIpAddr(req.getRemoteAddr());
		dto.setYdcDepth(dto.getYdcDepth()+1);
		dto.setYdcOrderNum(dto.getYdcOrderNum()+1);
		dto.setYdcParentNum(ydcNum);
		
		ydcdao.insertData(dto);

		req.setAttribute("pageNum",pageNum);

		
		return ydcList(req, resp);

	}

	//ckeditor 업로드
	@RequestMapping(value="/fileUpload.action",
			method={RequestMethod.POST})
	public String fileUpload(HttpServletRequest req,
			FileuploadDTO dto,Model model){
		
		//업로드 한 파일 저장경로 테스트
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;

		//-------------------------------------
		
		
		HttpSession session = req.getSession();
		
		//원본
		//D:\sts-bundle\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Project\
		String root_path = session.getServletContext().getRealPath("/");
		
		//무조건 resources 에 있어야 불러 오더라~ 에디터 개색
		String attach_path = "resources/" + year + monthStr +"/";
	
		//파일가져오고
		MultipartFile upload = dto.getUpload();
		String fileName = "";
		String CKEditorFuncNum = "";
		
		if(upload != null){
			
			//실제이름
			fileName = upload.getOriginalFilename();
			
			//jpg 확장자 가져오기
			String fileNameExt = fileName.substring(fileName.indexOf(".")+1);
			
			//저장할 새로운 파일명을 만든다.
			String newFileName;
			
			newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
					         Calendar.getInstance());
			newFileName += System.nanoTime();
			newFileName += "." + fileNameExt;
		
			dto.setFilename(newFileName);
			CKEditorFuncNum = dto.getCKEditorFuncNum();
			
			try {
				
				//저장 된 곳 
				//D:\sts-bundle\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Project\resources\files\018.jpg
				File file = new File(root_path + attach_path + newFileName);
				/*logger.info(root_path + attach_path + filename);*/
				
				System.out.println(file);
			
				if(!file.exists()){
					
					file.mkdirs();
				}
		
				upload.transferTo(file);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		//file경로 /board/resources/달수
		fileName = dto.getFilename();
		String file_path = "/ticketfactory/" + attach_path + fileName;
		
		
		model.addAttribute("file_path",file_path);
		model.addAttribute("CKEditorFuncNum",CKEditorFuncNum);
		
		
		/*System.out.println(file_path);*/
		
		return "fileUpload";

	}
	
}
