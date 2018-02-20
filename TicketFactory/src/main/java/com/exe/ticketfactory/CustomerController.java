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
	
	
	//�ǽð� ����
	@RequestMapping(value = "/reviewBoard.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String reviewBoard(HttpServletRequest req,String showId, String showName,
			HttpServletResponse response) throws Exception {
		
		//////////����¡ ó��///////////////////
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
		
		//��ü ������ ����
		int dataCount = dao2.getDataCount(searchKey, searchValue);
		
		//��ü ������ ��
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<ShowReviewDTO> lists =
				dao2.getListReview(start, end, searchKey, searchValue);
		
		//����¡ ó��
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
		
		/////////////////////////����¡ ó�� ��/////////////////////////////////////////
		
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
		
		//////////����¡ ó��///////////////////
		String cp = req.getContextPath();
	
		
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		
		//��ü ������ ����
		List<String> reviewCount = dao2.getReviewCount();
		int dataCount = reviewCount.size();
		System.out.println(dataCount+"��!!!!");
		
		//��ü ������ ��
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		System.out.println(totalPage+"������!!!");
		
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<ShowReviewDTO> lists =
				dao2.getReviewAvg(start, end);
		
		//����¡ ó��
		String listUrl = cp + "/changeReviewBoard.action";
		
		String pageIndexList = 
				myUtil2.pageIndexList(currentPage, totalPage, listUrl);
		System.out.println(pageIndexList);
		
		/////////////////////////����¡ ó�� ��/////////////////////////////////////////
		
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
	
	//�����۾���
	@RequestMapping(value = "/notiCreated.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String notiCreated(){
		
		return "/admin/noticeCreated.tiles";
	}
	
	//���۽� �������׺κ�
	@RequestMapping(value = "/centerNotice.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String centerNotice(HttpServletResponse resp,HttpServletRequest req){
		
		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		//��ü�����Ͱ���
		int dataCount = dao.getDataCount();
				
		//��ü��������
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<NoticeDTO> lists = 
				dao.getList(start, end);
		
		/*//����¡ ó��
		String listUrl = cp + "/centerNotice.action";*/
		
		String pageIndexList =
				myUtil.pageIndexList(currentPage, totalPage);
/*
		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);*/
	
		//�ۺ��� �ּ� ����
		String articleUrl = 
			cp + "/notiArticle.action?pageNum=" + currentPage;
	
		//������ �� �������� �����͸� �ѱ��
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		req.setAttribute("currentPage", currentPage);
		
	
		return "customerCenterNotice.tiles";
	}
	
	//�����۾���
	@RequestMapping(value="/notiCreated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String created_ok(NoticeDTO dto,HttpServletRequest req,HttpServletResponse resp){
		
		int maxNum = dao.getMaxNum();
		
		dto.setNotiNum(maxNum+1);

		dao.insertData(dto);
		
		return "redirect:/notiList.action";
		
	}
		
	//��������Ʈ
	@RequestMapping(value="/notiList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String noticelist(HttpServletRequest req,HttpServletResponse resp){


		
		//System.out.println(adminId);

		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		//��ü�����Ͱ���
		int dataCount = dao.getDataCount();
				
		//��ü��������
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<NoticeDTO> lists = 
				dao.getList(start, end);
		
		//����¡ ó��
		String listUrl = cp + "/notiList.action";
		
		/*String pageIndexList =
				myUtil.pageIndexList(currentPage, totalPage);*/

		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
		//�ۺ��� �ּ� ����
		String articleUrl = 
			cp + "/notiArticle.action?pageNum=" + currentPage;
	
		//������ �� �������� �����͸� �ѱ��
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
	
	//�����ۺ���
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
	
	//�� ������Ʈ!
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
		
	//����������Ʈ
	@RequestMapping(value="/notiUpdated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String updated_ok(NoticeDTO dto,HttpServletRequest req,HttpServletResponse resp) throws Exception{

		String pageNum = req.getParameter("pageNum");
		
		dao.updateData(dto);
		
		return "redirect:/notiList.action?pageNum=" + pageNum;

	}	
	
	//��������
	@RequestMapping(value="/notiDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String deleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int notiNum =Integer.parseInt(req.getParameter("notiNum"));
		
		dao.deleteData(notiNum);
		
		return "redirect:/notiList.action?pageNum=" + pageNum;
	}
	
	//FAQ����Ʈ
	@RequestMapping(value = "/faqList.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String centerFaq(HttpServletResponse resp,HttpServletRequest req){
		

		
		//System.out.println(adminId);
		
		String cp = req.getContextPath();
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
	
		List<FaqDTO> fhlists = fdao.fgetHitCountList();

		//��ü�����Ͱ���
		int dataCount = fdao.faqGetDataCount();
				
		//��ü��������
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<FaqDTO> lists = 
				fdao.fgetList(start, end);
		
		//����¡ ó��
		String listUrl = cp + "/faqList.action";
		
		/*String fpageIndexList =
				myUtil.faqPageIndexList(currentPage, totalPage);
*/
		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
		//�ۺ��� �ּ� ����
		String articleUrl = 
			cp + "/faqArticle.action?pageNum=" + currentPage;
	
		//������ �� �������� �����͸� �ѱ��
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
	
	//FAQ����
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
	
	//FAQ�ۺ���
	@RequestMapping(value="/faqArticle.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String faqAriticle(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String cp = req.getContextPath();
		
		int faqNum = Integer.parseInt(req.getParameter("faqNum"));
		String pageNum = req.getParameter("pageNum");
		
		//��ȸ�� ����
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
	
	//FAQ������Ʈ
	@RequestMapping(value="/faqUpdated_ok.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String faqupdated_ok(FaqDTO dto,HttpServletRequest req,HttpServletResponse resp) throws Exception{

		String pageNum = req.getParameter("pageNum");
		
		fdao.updateData(dto);
		
		return "redirect:/faqList.action?pageNum=" + pageNum;

	}	
	
	//FAQ����
	@RequestMapping(value="/faqDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String faqDeleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int faqNum =Integer.parseInt(req.getParameter("faqNum"));
		
		fdao.faqDeleteData(faqNum);
		
		return "redirect:/faqList.action?pageNum=" + pageNum;
	}
	
	//refund ȯ��/��Ҿȳ�
	@RequestMapping(value="/refundList.action",method={RequestMethod.GET,RequestMethod.POST})
	public String refundlist(){
			
		return "refundList.tiles";
		
	}
	
	//���� �Խ��� ����Ʈ
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
		
		//��ü�����Ͱ���
		int dataCount = 0;
		
		if(adminId=="" || adminId==null){
			
			TicketDTO tdto = (TicketDTO) session.getAttribute("loginDto");
			String eqId = tdto.getUserId();
			
			System.out.println(eqId);
			System.out.println("����Գ�?");
		
			dataCount = edao.getMemberDataCount(searchKey, searchValue, eqId);
			
		}else{
			
			dataCount = edao.getDataCount(searchKey, searchValue);
			
		}
		
		//��ü��������
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
			System.out.println("����Գ�?2");

			lists =
				edao.getMemberList(start, end, searchKey, searchValue,eqId);
			
		}else{
			
			lists =
				edao.getList(start, end, searchKey, searchValue);

		}
		
		// �Ϸù�ȣ
		int listNum, n = 0;
		
		Iterator<EnquiryDTO> it = lists.iterator();
		while (it.hasNext()) {

		EnquiryDTO eq = (EnquiryDTO) it.next();
		listNum = dataCount - (start + n - 1);
		
		//��ۼ�
		eq.setCommentNum(ecdao.GetDataCount(eq.getEqNum()));
		eq.setEqListNum(listNum);
		n++;
		}
		
		//����¡ ó��
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
		
		//�ۺ��� �ּ� ����
		String articleUrl = 
			cp + "/eqArticle.action?pageNum=" + currentPage;
			
		if(!param.equals(""))
			articleUrl = articleUrl + "&" + param;
		
		//������ �� �������� �����͸� �ѱ��
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("articleUrl",articleUrl);
		
		if(adminId=="" || adminId==null){
			
			return "enquiryList.tiles";	
			
		}
		
		return "/admin/enquiryList.tiles";	
		
	}
	
	//���� �Խ��� �ۺ���
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
		
	//���� �Խ��� �۾���
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
	
	//���ǻ���
	@RequestMapping(value="/eqDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String eqDeleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int eqNum =Integer.parseInt(req.getParameter("eqNum"));
		
		edao.deleteData(eqNum);
		
		return "redirect:/eqList.action?pageNum=" + pageNum;
	}
	
	//���� ��۾���
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
	
	//���� ��۸���Ʈ
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
		//��ü�����Ͱ���
		int dataCount = ecdao.GetDataCount(eqNum);
				
		//��ü��������
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
			
		//����¡ ó��
		/*String listUrl = cp + "/faqList.action";*/
		
		String pageIndexList =
				myUtil.ajaxPageIndexList(currentPage, totalPage);

		/*String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);*/
	
	
		//������ �� �������� �����͸� �ѱ��
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("currentPage", currentPage);
		
	
		return "enquiryComment";
		
	}
	
	//���� ��ۻ���
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
	
	//�̺�Ʈ�Խ��� ����Ʈ ����
	@RequestMapping(value="/eventList.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventList(HttpServletRequest req,HttpServletResponse resp){
		
		//���ε� �� ���� �����θ� ���ؼ� �ִ´� 
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;

		String cp = req.getContextPath();

		String attach_path = "resources/" + year + monthStr + "Title/";

		//����¡ó��
		
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		//��ü�����Ͱ���
		int dataCount = eventdao.getDataCount();
				
		//��ü��������
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
				
		if(currentPage > totalPage)
			currentPage = totalPage;
				
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<EventDTO> lists = 
				eventdao.getList(start, end);
		
		//����¡ ó��
		String listUrl = cp + "/eventList.action";
		
		/*String pageIndexList =
				myUtil.pageIndexList(currentPage, totalPage);*/

		String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
		//�ۺ��� �ּ� ����
		String articleUrl = 
			cp + "/eventArticle.action?pageNum=" + currentPage;
		
		//�̹��� url
		String imageUrl =  cp + "/" + attach_path ;
		
	
		//������ �� �������� �����͸� �ѱ��
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
	
	//�̺�Ʈ�Խ��� �۾��� ����
	@RequestMapping(value="/eventCreated.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventCreated(HttpServletRequest req,HttpServletResponse resp){
		
		return "/admin/eventCreated.tiles";
		
	}
	
	@RequestMapping(value="/eventCreated_ok.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String eventCreated_ok(MultipartHttpServletRequest req,
			HttpServletResponse resp,EventDTO dto) throws IOException{
		
		//���ε� �� ���� ������ �׽�Ʈ
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
				//�����̸�
				String originalName =file.getOriginalFilename();
				
				//Ȯ���� ��������
				String fileNameExt = originalName.substring(originalName.indexOf("."));
				
				//�����̸� ����
				String newFileName;
				
				newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
						      Calendar.getInstance());
				newFileName += System.nanoTime();
				newFileName += "title";
				newFileName += fileNameExt;
		
				dto.setEbTitleimage(newFileName);
				
				//���� ���� �׽�Ʈ
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
	
	//�̺�Ʈ�Խ��� �ۺ��� ����
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
	
	//�̺�Ʈ ������Ʈ!
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

		//���ε� �� ���� ������ �׽�Ʈ
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
				//�����̸�
				String originalName =file.getOriginalFilename();
				
				//Ȯ���� ��������
				String fileNameExt = originalName.substring(originalName.indexOf("."));
				
				//�����̸� ����
				String newFileName;
				
				newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
						      Calendar.getInstance());
				newFileName += System.nanoTime();
				newFileName += "title";
				newFileName +=  fileNameExt;
		
				dto.setEbTitleimage(newFileName);

				//���� ���� �׽�Ʈ
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
	
	//�����̺�Ʈ����
	@RequestMapping(value="/eventDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String eventdeleted(HttpServletRequest req,HttpServletResponse resp,
			EventDTO dto) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int ebNum =Integer.parseInt(req.getParameter("ebNum"));
		
		//���ε� �� ���� ������ �׽�Ʈ
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;
	
		String path = req.getSession().getServletContext().getRealPath("");
		String attach_path = "resources/" + year + monthStr + "Title/";
		String savePath = path + File.separator + attach_path;

		//��������
		dto = eventdao.getReadData(ebNum);	

		eventdao.fileDeleteData(dto.getEbTitleimage(), savePath);
		
		eventdao.deleteData(ebNum);
		
		return "redirect:/eventList.action?pageNum=" + pageNum;
	}
	
	//�絵�Խ��� ����Ʈ ����
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
		
		//��ü�����Ͱ���
		int dataCount = yangdao.getDataCount(searchKey, searchValue);
		
		//��ü��������
		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<YangdoDTO> lists =
			yangdao.getList(start, end, searchKey, searchValue);
		
/*		// �Ϸù�ȣ
		int listNum, n = 0;
		
		Iterator<YangdoDTO> it = lists.iterator();
		while (it.hasNext()) {

		YangdoDTO dto = (YangdoDTO) it.next();
		listNum = dataCount - (start + n - 1);
		
		//��ۼ�
		dto.setCommentNum(ecdao.GetDataCount(eq.getEqNum()));
		eq.setEqListNum(listNum);
		n++;
		}*/
		
		//����¡ ó��
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
		
		//�ۺ��� �ּ� ����
		String articleUrl = 
			cp + "/yangdoArticle.action?pageNum=" + currentPage;
			
		if(!param.equals(""))
			articleUrl = articleUrl + "&" + param;
		
		//������ �� �������� �����͸� �ѱ��
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
	
	
	//�絵�۾��� 
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
	
	//�絵�Խ��� �ۺ��Ŷ�� ����
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
	
	//�絵����
	@RequestMapping(value="/yangdoDeleted.action",
			method={RequestMethod.POST,RequestMethod.GET})
	public String yangdoDeleted(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String pageNum = req.getParameter("pageNum");
		int ydNum =Integer.parseInt(req.getParameter("ydNum"));
		
		yangdao.deleteData(ydNum);
		ydcdao.DeleteData(ydNum);
		
		return "redirect:/yangdoList.action?pageNum=" + pageNum;
	}
	
	//�絵 ��۾���
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
	
	//�絵 ��� ����Ʈ
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
		//��ü�����Ͱ���
		int dataCount = ydcdao.GetDataCount(ydNum);
				
		//��ü��������
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
			
		//����¡ ó��
		/*String listUrl = cp + "/faqList.action";*/
		
		String pageIndexList =
				myUtil.ajaxPageIndexList(currentPage, totalPage);

		/*String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);*/

	
		//������ �� �������� �����͸� �ѱ��
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList",pageIndexList);
		req.setAttribute("dataCount",dataCount);
		req.setAttribute("currentPage", currentPage);

	
		return "yangdoComment";
		
	}
	
	//�絵 ��ۻ���
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
	
	//�絵 ����dkdkdkd����̶�äӤ����ʸ�����
	@RequestMapping(value="/yangdoReply.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydc(HttpServletRequest req,HttpServletResponse resp){
		
		int reNum = Integer.parseInt(req.getParameter("reNum"));
	
		req.setAttribute("reNum",reNum);
		
		return "yangdoReply";
		
	}
	
	//�絵 ���õ���
	@RequestMapping(value="/ydcReply.action",
			method={RequestMethod.GET,RequestMethod.POST})
	public String ydcReply(HttpServletRequest req,HttpServletResponse resp){
		
		
		return "yangdoReply.tiles";
		
	}
	
	
	//�絵 ���õ���
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
			return "dto�������̴�";
		
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

	//ckeditor ���ε�
	@RequestMapping(value="/fileUpload.action",
			method={RequestMethod.POST})
	public String fileUpload(HttpServletRequest req,
			FileuploadDTO dto,Model model){
		
		//���ε� �� ���� ������ �׽�Ʈ
		Date date = new Date();
		int year = date.getYear() + 1900;
		int month = date.getMonth() +1;
		String monthStr = "";
		
		if(month<10) monthStr = "0" + month;
		else monthStr = "" + month;

		//-------------------------------------
		
		
		HttpSession session = req.getSession();
		
		//����
		//D:\sts-bundle\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Project\
		String root_path = session.getServletContext().getRealPath("/");
		
		//������ resources �� �־�� �ҷ� ������~ ������ ����
		String attach_path = "resources/" + year + monthStr +"/";
	
		//���ϰ�������
		MultipartFile upload = dto.getUpload();
		String fileName = "";
		String CKEditorFuncNum = "";
		
		if(upload != null){
			
			//�����̸�
			fileName = upload.getOriginalFilename();
			
			//jpg Ȯ���� ��������
			String fileNameExt = fileName.substring(fileName.indexOf(".")+1);
			
			//������ ���ο� ���ϸ��� �����.
			String newFileName;
			
			newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
					         Calendar.getInstance());
			newFileName += System.nanoTime();
			newFileName += "." + fileNameExt;
		
			dto.setFilename(newFileName);
			CKEditorFuncNum = dto.getCKEditorFuncNum();
			
			try {
				
				//���� �� �� 
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
		
		//file��� /board/resources/�޼�
		fileName = dto.getFilename();
		String file_path = "/ticketfactory/" + attach_path + fileName;
		
		
		model.addAttribute("file_path",file_path);
		model.addAttribute("CKEditorFuncNum",CKEditorFuncNum);
		
		
		/*System.out.println(file_path);*/
		
		return "fileUpload";

	}
	
}
