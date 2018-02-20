package com.exe.ticketfactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.exe.ticketfactory.dao.Detail2DAO;
import com.exe.ticketfactory.dao.DetailDAO;
import com.exe.ticketfactory.dto.BookDTO;
import com.exe.ticketfactory.dto.ImageDTO;
import com.exe.ticketfactory.dto.PlaceDTO;
import com.exe.ticketfactory.dto.QnaDTO;
import com.exe.ticketfactory.dto.ReviewDTO;
import com.exe.ticketfactory.dto.SeatDTO;
import com.exe.ticketfactory.dto.ShowDTO;
import com.exe.ticketfactory.dto.TicketDTO;
import com.jdbc.util.MyUtil;



@Controller("com.exe.ticketfactory.homeController")
public class HomeController {

	@Autowired
	@Qualifier("detailDAO")
	DetailDAO dao;
	
	@Autowired
	@Qualifier("detail2DAO")
	Detail2DAO dao2;
	
	@Autowired
	@Qualifier("myUtil")
	MyUtil myUtil;

	
	@RequestMapping(value = "/", method = {RequestMethod.GET,RequestMethod.POST})
	public String home(HttpServletRequest req, HttpServletResponse resp) {

		List<ShowDTO> lists = dao.showList();
		req.setAttribute("lists", lists);
		return "home";
	}
	
/*	@RequestMapping(value="/start.action", method={RequestMethod.GET, RequestMethod.POST})
	public String start(HttpServletRequest req){
		
		List<ShowDTO> lists = dao.showList();
		Iterator<ShowDTO> it = lists.iterator();
		while(it.hasNext()){
			ShowDTO vo = it.next();
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			} 
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
			}
		}
		
		
		String[] day = {"일","월","화","수","목","금","토"};
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
		List<ShowDTO> todayTemp = dao.getShowToday(sdf.format(date));
		List<ShowDTO> today = new ArrayList<ShowDTO>();
		Iterator<ShowDTO> iter = todayTemp.iterator();
		while(iter.hasNext()){
			ShowDTO vo = iter.next();
			
			Iterator<SeatDTO> seatIter = dao.getDayDist(vo.getShowId()).iterator();
			while(seatIter.hasNext()){
				SeatDTO vs = seatIter.next();
				if(day[cal.get(Calendar.DAY_OF_WEEK)-1].equals(vs.getShowDay())){
					//System.out.println(day[cal.get(Calendar.DAY_OF_WEEK)-1] + "요일");
					//System.out.println(vo.getShowName()+"은 " +vs.getShowDay()+"상영" + "("+vo.getShowFrom()+"~"+vo.getShowTo()+")");
					if(vo.getShowPrice().indexOf("전석")==-1){
						vo.setSeatState("좌석 별로 다름");
					} 
					if(dao.getOneplus(vo.getShowId())!=null){
						vo.setEvent("oneplus");
					}
					today.add(vo);
					break;
				}
			}
		}
		
		req.setAttribute("todayList", today);
		req.setAttribute("lists", lists);
		return "start.tiles";
	}*/
	
	
	@RequestMapping(value="today.action", method={RequestMethod.GET, RequestMethod.POST})
	public String more(HttpServletRequest req,String genre,String order) throws Exception{

		List<ShowDTO> lists = new ArrayList<ShowDTO>();
		List<ShowDTO> areaLists = new ArrayList<ShowDTO>();
		String showGenre="";
		String[] showArea = null;
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");


			if(order==null){
				order="showId";
			}
			
		if(genre==null){
			genre = "1";
		}
		if(Integer.parseInt(genre)<6){
			switch (Integer.parseInt(genre)) {
			case 1:
				showGenre = "연극";
				break;
			case 2:
				showGenre = "뮤지컬";
				break;
			case 3:
				showGenre = "클래식";
				break;
			case 4:
				showGenre = "국악";
				break;
			case 5:
				showGenre= "오페라";
				break;
			default:
				break;
			}
			lists = dao.getShowByGenreDate(showGenre,sdf.format(date),"showId");
		}else{
			switch (Integer.parseInt(genre)) {
			case 6:
				showArea = new String[3];
				showArea[0] = "서울";
				showArea[1] = "서울특별시";
				showArea[2] = "서울시";
				break;
			case 7:
				showArea = new String[1];
				showArea[0] = "경기";
				break;
			case 8:
				showArea = new String[4];
				showArea[0] = "충북";
				showArea[1] = "대전광역시";
				showArea[2] = "충청남도";
				showArea[3] = "충청북도";
				break;
			case 9:
				showArea = new String[6];
				showArea[0] = "대구광역시";
				showArea[1] = "경상남도";
				showArea[2] = "경상북도";
				showArea[3] = "부산광역시";
				showArea[4] = "울산광역시";
				showArea[5] = "부산시";
				break;
			case 10:
				showArea = new String[3];
				showArea[0] = "광주광역시";
				showArea[1] = "전라북도";
				showArea[2] = "전라남도";
				break;
			case 11:
				showArea = new String[4];
				showArea[0] = "제주특별자치도";
				showArea[1] = "인천광역시";
				showArea[2] = "인천";
				showArea[3] = "강원도";
				break;
			default:
				break;
			}
			lists = dao.showList();
		}


		Iterator<ShowDTO> it = lists.iterator();

		while(it.hasNext()){
			ShowDTO vo = it.next();
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			}
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
			}
			if(dao.getAvgStar(vo.getShowId())==null){
				vo.setAvgStar(0);
			}else{
				vo.setAvgStar(Integer.parseInt(dao.getAvgStar(vo.getShowId())));
			}
			if(vo.getShowName().indexOf(" [")!=-1){
				String[] showName = vo.getShowName().split(" \\[");
				vo.setShowName(showName[0]);
			}
			
			//System.out.println(vo.getShowPrice());
		if(vo.getShowPrice().indexOf("원")<0){
			vo.setPriceForCompare(0);
		}else{
			String[] priceTemp = vo.getShowPrice().split(", ");
			if(priceTemp.length==1){
				vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
				//System.out.println("전석임" + vo.getPriceForCompare());
			}else{
				vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
				
				for(String temp:priceTemp){
					//System.out.println("비교"+temp);
					int price = Integer.parseInt(temp.substring(temp.indexOf(" ")+1, temp.indexOf("원")).replace(",", ""));
					if(vo.getPriceForCompare()>=price){
						vo.setPriceForCompare(price);
					}
				}
				//System.out.println("전석아님"+vo.getPriceForCompare());
			}
		}
			
			
			if(showArea!=null){
				PlaceDTO pdto = dao.getPlace(vo.getPlaceId());
				if(dao.getTimeByDate(vo.getShowId(),sdf.format(date)).size()!=0){
				for(int k=0;k<showArea.length;k++){
					if(showArea[k].equals(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")))){
						areaLists.add(vo);
						//System.out.println(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")));
					}
				}
				}
				lists = null;
			}

		}
		
		if(order=="price" || order.equals("price")){
			ComparePrice comp = new ComparePrice();
			if(lists!=null){
				Collections.sort(lists, comp);
			}else{
				Collections.sort(areaLists,comp);
			}
		}
		
		if(order=="star" || order.equals("star")){
			CompareStar comp = new CompareStar();
			if(lists!=null){
				Collections.sort(lists,comp);
			}else{
				Collections.sort(areaLists, comp);
			}
		}
		

		String[] yoil = {"일","월","화","수","목","금","토"}; 
		Calendar cal = Calendar.getInstance();
		String today = String.format("%d년 %d월 %d일 (%s)",cal.get(Calendar.YEAR),cal.get(Calendar.MONTH)+1,cal.get(Calendar.DATE),
				yoil[cal.get(Calendar.DAY_OF_WEEK)-1]);

		req.setAttribute("order", order);
		req.setAttribute("genre", genre);
		req.setAttribute("today", today);
		req.setAttribute("show", lists);
		req.setAttribute("area", areaLists);

		return "show_content.tiles";
	}

	@RequestMapping(value="tomorrow.action", method={RequestMethod.GET, RequestMethod.POST})
	public String tomorrow(HttpServletRequest req, String genre, String order){
		
		List<ShowDTO> lists = new ArrayList<ShowDTO>();
		List<ShowDTO> areaLists = new ArrayList<ShowDTO>();
		String showGenre="";
		String[] showArea = null;
		Date date = new Date();
		date.setTime(date.getTime() + (1000*60*60*24)*1);
		SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");

			if(order==null){
				order="showId";
			}
		
		if(genre==null){
			lists = dao.showList();
		}else{
			if(Integer.parseInt(genre)<6){
				switch (Integer.parseInt(genre)) {
				case 1:
					showGenre = "연극";
					break;
				case 2:
					showGenre = "뮤지컬";
					break;
				case 3:
					showGenre = "클래식";
					break;
				case 4:
					showGenre = "국악";
					break;
				case 5:
					showGenre= "오페라";
					break;
				default:
					break;
				}
				lists = dao.getShowByGenreDate(showGenre,sdf.format(date),"showId");
			}else{
				switch (Integer.parseInt(genre)) {
				case 6:
					showArea = new String[3];
					showArea[0] = "서울";
					showArea[1] = "서울특별시";
					showArea[2] = "서울시";
					break;
				case 7:
					showArea = new String[1];
					showArea[0] = "경기";
					break;
				case 8:
					showArea = new String[4];
					showArea[0] = "충북";
					showArea[1] = "대전광역시";
					showArea[2] = "충청남도";
					showArea[3] = "충청북도";
					break;
				case 9:
					showArea = new String[6];
					showArea[0] = "대구광역시";
					showArea[1] = "경상남도";
					showArea[2] = "경상북도";
					showArea[3] = "부산광역시";
					showArea[4] = "울산광역시";
					showArea[5] = "부산시";
					break;
				case 10:
					showArea = new String[3];
					showArea[0] = "광주광역시";
					showArea[1] = "전라북도";
					showArea[2] = "전라남도";
					break;
				case 11:
					showArea = new String[4];
					showArea[0] = "제주특별자치도";
					showArea[1] = "인천광역시";
					showArea[2] = "인천";
					showArea[3] = "강원도";
					break;
				default:
					break;
				}
				lists = dao.showList();
			}
		}

		Iterator<ShowDTO> it = lists.iterator();
		
		while(it.hasNext()){
			ShowDTO vo = it.next();
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			}
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
			}
			if(dao.getAvgStar(vo.getShowId())==null){
				vo.setAvgStar(0);
			}else{
				vo.setAvgStar(Integer.parseInt(dao.getAvgStar(vo.getShowId())));
			}
			if(vo.getShowName().indexOf(" [")!=-1){
				String[] showName = vo.getShowName().split(" \\[");
				vo.setShowName(showName[0]);
			}
			
		
				//System.out.println(vo.getShowPrice());
			if(vo.getShowPrice().indexOf("원")<0){
				vo.setPriceForCompare(0);
			}else{
				String[] priceTemp = vo.getShowPrice().split(", ");
				if(priceTemp.length==1){
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
					//System.out.println("전석임" + vo.getPriceForCompare());
				}else{
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
					
					for(String temp:priceTemp){
						//System.out.println("비교"+temp);
						int price = Integer.parseInt(temp.substring(temp.indexOf(" ")+1, temp.indexOf("원")).replace(",", ""));
						if(vo.getPriceForCompare()>=price){
							vo.setPriceForCompare(price);
						}
					}
					//System.out.println("전석아님"+vo.getPriceForCompare());
				}
			}
				
			
		
			if(showArea!=null){
				PlaceDTO pdto = dao.getPlace(vo.getPlaceId());
				if(dao.getTimeByDate(vo.getShowId(),sdf.format(date)).size()!=0){
				for(int k=0;k<showArea.length;k++){
					if(showArea[k].equals(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")))){
						areaLists.add(vo);
						//System.out.println(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")));
					}
				}
				}
				lists = null;
			}
		
		}
		
		if(order=="price" || order.equals("price")){
			ComparePrice comp = new ComparePrice();
			if(lists!=null){
				Collections.sort(lists, comp);
			}else{
				Collections.sort(areaLists,comp);
			}
		}
		
		if(order=="star" || order.equals("star")){
			CompareStar comp = new CompareStar();
			if(lists!=null){
				Collections.sort(lists,comp);
			}else{
				Collections.sort(areaLists, comp);
			}
		}

	
		String[] yoil = {"일","월","화","수","목","금","토"}; 
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		String tomorrow = String.format("%d년 %d월 %d일 (%s)",cal.get(Calendar.YEAR),cal.get(Calendar.MONTH)+1,cal.get(Calendar.DATE),
				yoil[cal.get(Calendar.DAY_OF_WEEK)-1]);
		
		req.setAttribute("genre", genre);
		req.setAttribute("tomorrow", tomorrow);
		req.setAttribute("show", lists);
		req.setAttribute("area", areaLists);
		req.setAttribute("listNum", req.getAttribute("listNum"));
		
		

		return "show_content_tomorrow.tiles";
	}
	
	@RequestMapping(value="reserve_ticket.action")
	public String reserve_ticket(HttpServletRequest req, String genre,String order, String pageNum){
		
		List<ShowDTO> lists = new ArrayList<ShowDTO>();
		List<ShowDTO> areaLists = new ArrayList<ShowDTO>();
		List<ShowDTO> showLists = new ArrayList<ShowDTO>();
		List<ShowDTO> tempAreaLists = new ArrayList<ShowDTO>();

		String showGenre="";
		String[] showArea = null;
		
		int currentPage = 1;
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		int numPerPage=12;
		int dataCount=0;
		int totalPage=0;
		
		if(order==null)
			order="showId";
		if(genre==null)
			genre="1";
		
			if(Integer.parseInt(genre)<6){
				switch (Integer.parseInt(genre)) {
				case 1:
					showGenre = "연극";
					break;
				case 2:
					showGenre = "뮤지컬";
					break;
				case 3:
					showGenre = "클래식";
					break;
				case 4:
					showGenre = "국악";
					break;
				case 5:
					showGenre= "오페라";
					break;
				default:
					break;
				}
			
				lists = dao.getShowByGenre(showGenre);
				
				
			}else{
				switch (Integer.parseInt(genre)) {
				case 6:
					showArea = new String[3];
					showArea[0] = "서울";
					showArea[1] = "서울특별시";
					showArea[2] = "서울시";
					break;
				case 7:
					showArea = new String[1];
					showArea[0] = "경기도";
					break;
				case 8:
					showArea = new String[4];
					showArea[0] = "충북";
					showArea[1] = "대전광역시";
					showArea[2] = "충청남도";
					showArea[3] = "충청북도";
					break;
				case 9:
					showArea = new String[6];
					showArea[0] = "대구광역시";
					showArea[1] = "경상남도";
					showArea[2] = "경상북도";
					showArea[3] = "부산광역시";
					showArea[4] = "울산광역시";
					showArea[5] = "부산시";
					break;
				case 10:
					showArea = new String[3];
					showArea[0] = "광주광역시";
					showArea[1] = "전라북도";
					showArea[2] = "전라남도";
					break;
				case 11:
					showArea = new String[4];
					showArea[0] = "제주특별자치도";
					showArea[1] = "인천광역시";
					showArea[2] = "인천";
					showArea[3] = "강원도";
					break;
				default:
					break;
				}
				
				lists = dao.showList();
			}
		

		Iterator<ShowDTO> it = lists.iterator();
		
		while(it.hasNext()){
			ShowDTO vo = it.next();
			PlaceDTO pdto = dao.getPlace(vo.getPlaceId());
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			}
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
			}
			if(dao.getAvgStar(vo.getShowId())==null){
				vo.setAvgStar(0);
			}else{
				vo.setAvgStar(Integer.parseInt(dao.getAvgStar(vo.getShowId())));
			}
			if(vo.getShowName().indexOf(" [")!=-1){
				String[] showName = vo.getShowName().split(" \\[");
				vo.setShowName(showName[0]);
			}
			
			if(vo.getShowPrice().indexOf("원")<0){
				vo.setPriceForCompare(0);
			}else{
				String[] priceTemp = vo.getShowPrice().split(", ");
				if(priceTemp.length==1){
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
				}else{
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
					
					for(String temp:priceTemp){
						int price = Integer.parseInt(temp.substring(temp.indexOf(" ")+1, temp.indexOf("원")).replace(",", ""));
						if(vo.getPriceForCompare()>=price){
							vo.setPriceForCompare(price);
						}
					}
				}
			}

			if(showArea!=null){
				for(int k=0;k<showArea.length;k++){
					if(showArea[k].equals(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")))){
						tempAreaLists.add(vo);
					}
				}
				lists = null;
			}else{
				tempAreaLists = null;
			}
			vo.setPlaceName(pdto.getPlaceName());
			vo.setPlaceAddr(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")));
		
		}//while 모든 기본 세팅 끝, 연극별 lists와 장소별 tempAreaLists가 완료된 상태,
		
		
		//정렬상태 체크하고!!!
		if(order=="price" || order.equals("price")){
			ComparePrice comp = new ComparePrice();
			if(lists!=null){
				Collections.sort(lists, comp);
			}else{
				Collections.sort(tempAreaLists,comp);
			}
		}
		
		if(order=="star" || order.equals("star")){
			CompareStar comp = new CompareStar();
			if(lists!=null){
				Collections.sort(lists,comp);
			}else{
				Collections.sort(tempAreaLists,comp);
			}
		}
		
		
		//페이징 처리
		if(lists==null && tempAreaLists!=null){
			dataCount = tempAreaLists.size();
			totalPage = myUtil.getPageCount(numPerPage, dataCount);
			if(currentPage>totalPage)
				currentPage = totalPage;
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			if(end>=dataCount){
				end=dataCount-1;
			}
			for(int j=start-1;j<=end;j++){
				areaLists.add(tempAreaLists.get(j));
			}
			
		}else if(lists!=null && tempAreaLists==null){
			dataCount = lists.size();
			totalPage = myUtil.getPageCount(numPerPage, dataCount);
			if(currentPage>totalPage)
				currentPage = totalPage;
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			if(end>=dataCount)
				end=dataCount-1;
			for(int j=start-1;j<=end;j++){
				showLists.add(lists.get(j));
			}
		}
		
		
		String cp = req.getContextPath();
		String listUrl = cp + "/reserve_ticket.action?genre="+genre;
		if(order!="showId" && !order.equals("showId")){
			listUrl += "&order=" +order;
		}
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("genre", genre);
		req.setAttribute("show", showLists);
		req.setAttribute("area", areaLists);
		
		return "reserve_ticket.tiles";
	}
	
	@RequestMapping(value="oneplusPopUp.action" ,method={RequestMethod.POST, RequestMethod.GET})
	public String onplusPopUp(HttpServletRequest req, String selected,String state,String genre){
		
		List<ShowDTO> lists = new ArrayList<ShowDTO>();
		//System.out.println(selected);
		String[] temp = selected.split(" ");
		for(String showId:temp){
			lists.add(dao.getShow(showId));
		}
		req.setAttribute("showIds", temp);
		req.setAttribute("lists", lists);
		req.setAttribute("selected", selected);
		req.setAttribute("state", state);
		req.setAttribute("genre", genre);
		
		return "oneplusPopUp";
	}
	
	@RequestMapping(value="addOneplus.action", method={RequestMethod.POST})
	public void addOneplus(String selected){
		//System.out.println("등록할 티켓들");
		String[] temp = selected.split(" ");
		for(String showId:temp){
			showId=showId.replaceAll(" ", "");
			//System.out.println(showId);
			dao.insertOneplus(showId);
		}
	
	}
	
	@RequestMapping(value="removeOneplus.action", method={RequestMethod.POST})
	public void removeOneplus(String selected){
		String[] temp = selected.split(" ");
		for(String showId:temp){
			showId = showId.replaceAll(" ", "");
			dao.deleteOneplus(showId);
		}
	}
	
	@RequestMapping(value="admin05.action", method={RequestMethod.POST, RequestMethod.GET})
	public String adminOneplus(HttpServletRequest req, String genre, String pageNum, String order,String state){
		
		List<ShowDTO> lists = new ArrayList<ShowDTO>();
		List<ShowDTO> areaLists = new ArrayList<ShowDTO>();
		Map<Integer,ShowDTO> mapArea = new HashMap<Integer,ShowDTO>();
		int i=0;
		
		String showGenre="";
		String[] showArea = null;
		
		int currentPage = 1;
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		int numPerPage=10;
		int dataCount=0;
		int totalPage=0;
		
		if(order==null)
			order="showId";
		if(genre==null)
			genre="1";
		
		
			if(Integer.parseInt(genre)<6){
				switch (Integer.parseInt(genre)) {
				case 1:
					showGenre = "연극";
					break;
				case 2:
					showGenre = "뮤지컬";
					break;
				case 3:
					showGenre = "클래식";
					break;
				case 4:
					showGenre = "국악";
					break;
				case 5:
					showGenre= "오페라";
					break;
				default:
					break;
				}
			
				
				
				
				if(state==null || state=="add" || state.equals("add")){
					state="add";
					dataCount = dao.getShowCountWithoutEvent(showGenre);
					totalPage = myUtil.getPageCount(numPerPage, dataCount);
					if(currentPage>totalPage)
						currentPage = totalPage;
					int start = (currentPage-1)*numPerPage+1;
					int end = currentPage*numPerPage;
					lists = dao.getShowWithoutEvent(showGenre, start, end);
					//System.out.println(state);
				}else{
					dataCount = dao.getShowCountWithEvent(showGenre);
					totalPage = myUtil.getPageCount(numPerPage, dataCount);
					if(currentPage>totalPage)
						currentPage = totalPage;
					int start = (currentPage-1)*numPerPage+1;
					int end = currentPage*numPerPage;
					lists = dao.getShowWithEvent(showGenre, start, end);
					//System.out.println(state);
					//System.out.println(showGenre);
					//System.out.println(dataCount);
					
				}
				
			}else{
				switch (Integer.parseInt(genre)) {
				case 6:
					showArea = new String[3];
					showArea[0] = "서울";
					showArea[1] = "서울특별시";
					showArea[2] = "서울시";
					break;
				case 7:
					showArea = new String[1];
					showArea[0] = "경기도";
					break;
				case 8:
					showArea = new String[4];
					showArea[0] = "충북";
					showArea[1] = "대전광역시";
					showArea[2] = "충청남도";
					showArea[3] = "충청북도";
					break;
				case 9:
					showArea = new String[6];
					showArea[0] = "대구광역시";
					showArea[1] = "경상남도";
					showArea[2] = "경상북도";
					showArea[3] = "부산광역시";
					showArea[4] = "울산광역시";
					showArea[5] = "부산시";
					break;
				case 10:
					showArea = new String[3];
					showArea[0] = "광주광역시";
					showArea[1] = "전라북도";
					showArea[2] = "전라남도";
					break;
				case 11:
					showArea = new String[4];
					showArea[0] = "제주특별자치도";
					showArea[1] = "인천광역시";
					showArea[2] = "인천";
					showArea[3] = "강원도";
					break;
				default:
					break;
				}
				if(state==null || state=="add" || state.equals("add")){
					state="add";
					lists = dao.showListWithoutEvent();
					//System.out.println(state);
				}else{
					lists = dao.showListWithEvent();
					//System.out.println(state);
				}
				
			}
		

		Iterator<ShowDTO> it = lists.iterator();
		
		while(it.hasNext()){
			ShowDTO vo = it.next();
			PlaceDTO pdto = dao.getPlace(vo.getPlaceId());
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			}
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
			}
			if(dao.getAvgStar(vo.getShowId())==null){
				vo.setAvgStar(0);
			}else{
				vo.setAvgStar(Integer.parseInt(dao.getAvgStar(vo.getShowId())));
			}
			if(vo.getShowName().indexOf(" [")!=-1){
				String[] showName = vo.getShowName().split(" \\[");
				vo.setShowName(showName[0]);
			}
			
			if(vo.getShowPrice().indexOf("원")<0){
				vo.setPriceForCompare(0);
			}else{
				String[] priceTemp = vo.getShowPrice().split(", ");
				if(priceTemp.length==1){
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
				}else{
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
					
					for(String temp:priceTemp){
						int price = Integer.parseInt(temp.substring(temp.indexOf(" ")+1, temp.indexOf("원")).replace(",", ""));
						if(vo.getPriceForCompare()>=price){
							vo.setPriceForCompare(price);
						}
					}
				}
			}

			if(showArea!=null){
				//System.out.println(showArea[0]+"지역!");
				for(int k=0;k<showArea.length;k++){
					if(showArea[k].equals(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")))){
						//System.out.println(vo.getShowId()+vo.getShowName()+"추가되는 공연");
						mapArea.put(i, vo);
						i++;
					}
				}
				lists = null;
			}
			/*if(mapArea.size()==0){
				mapArea=null;
			}*/
			//System.out.println(mapArea.size()+"개");
			vo.setPlaceName(pdto.getPlaceName());
			vo.setPlaceAddr(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")));
		
		}
		
		if(lists==null && mapArea!=null){
			dataCount = mapArea.size();
			if(mapArea.size()!=0){
			totalPage = myUtil.getPageCount(numPerPage, dataCount);
			if(currentPage>totalPage)
				currentPage = totalPage;
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			if(end>=dataCount){
				end=dataCount-1;
			}
			for(int j = start;j<=end;j++){
				areaLists.add(mapArea.get(j));

			}}else if(mapArea.size()==0){
				areaLists = null;
			}
			
		}
		
		
		if(order=="price" || order.equals("price")){
			ComparePrice comp = new ComparePrice();
			if(lists!=null){
				Collections.sort(lists, comp);
			}else{
				Collections.sort(areaLists,comp);
			}
		}
		
		if(order=="star" || order.equals("star")){
			CompareStar comp = new CompareStar();
			if(lists!=null){
				Collections.sort(lists,comp);
			}else{
				Collections.sort(areaLists, comp);
			}
		}
	
		String cp = req.getContextPath();
		String listUrl = cp + "/admin05.action?genre="+genre+"&state="+state;
		String pageIndexList = myUtil.adminPageIndexList(currentPage, totalPage, listUrl,genre,state);
		
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("genre", genre);
		req.setAttribute("show", lists);
		req.setAttribute("area", areaLists);
		req.setAttribute("state", state);
		
		return "adminOneplus";
	}
	
/*	@RequestMapping(value="setTime.action", method={RequestMethod.POST})
	@ResponseBody
	public String setTime(String showDate, String showId) throws UnsupportedEncodingException{
		//System.out.println(showDate);
		List<SeatDTO> time = dao.getTimeByDate(showId, showDate);
		String html = "<select id='selectTime' name='selectTime'>";
		html += "<option>Time List</option>";
		Iterator<SeatDTO> it = time.iterator();
		while(it.hasNext()){
			SeatDTO dto = it.next();
			html += "<option value='";
			html += dto.getShowTime();
			html += "'>" + dto.getShowTime() + "(" + dto.getSeat() +")";  
			html +=	"</option>";
		}
		html += "</select>";
		//System.out.println(html);
		return html;
	}*/
	
	@RequestMapping(value="setTime.action", method={RequestMethod.POST})
	public String setTime(String showDate, String showId ,HttpServletRequest request) {

		List<SeatDTO> time = dao.getTimeByDate(showId, showDate);
		ShowDTO show= dao.getShow(showId);
		
		if(dao.getOneplus(showId)!=null){
			show.setEvent("oneplus");
		}
		
		int[] price = new int[10]; 
		String[] seat = new String[10];
		int i=0;
		String[] priceTemp = show.getShowPrice().split(", ");
		for(String str:priceTemp){
			seat[i] = str.substring(0, str.indexOf("석")+1);
			price[i] = Integer.parseInt(str.substring(str.indexOf("석")+2, str.indexOf("원")).replace(",", ""));
		
			i++;
		}

		int su =priceTemp.length;
		System.out.println(su);
		
		request.setAttribute("show", show);
		request.setAttribute("su", su);
		request.setAttribute("SeatDTO", time);
		request.setAttribute("seat", seat);
		request.setAttribute("price", price);
		
		
		
		return "setTime";
		
/*		List<SeatDTO> time = dao.getTimeByDate(showId, showDate);
		ShowDTO show= dao.getShow(showId);
		
		
		int[] price = new int[10]; 
		String[] seat = new String[10];
		int i=0;
		String[] priceTemp = show.getShowPrice().split(", ");
		for(String str:priceTemp){
			seat[i] = str.substring(0, str.indexOf("석")+1);
			price[i] = Integer.parseInt(str.substring(str.indexOf("석")+2, str.indexOf("원")).replace(",", ""));
		
			i++;
		}

		int su =priceTemp.length;
		System.out.println(su);
		request.setAttribute("su", su);
		request.setAttribute("SeatDTO", time);
		request.setAttribute("seat", seat);
		request.setAttribute("price", price);
		
		
		
		return "setTime";*/
	}
	
	
	@RequestMapping(value="makeDiv.action", method={RequestMethod.POST})
	public String makeDiv(HttpServletRequest request) {
		
		String date = request.getParameter("date");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		String price = request.getParameter("price");
		String seat = request.getParameter("seat");
		String count = request.getParameter("count");
		String capacity_num = request.getParameter("capacity_num");
		String seat_num = request.getParameter("seat_num");
	
		
		
		request.setAttribute("date", date);
		request.setAttribute("day", day);
		request.setAttribute("time", time);
		request.setAttribute("price", price);
		request.setAttribute("seat", seat);
		request.setAttribute("count", count);
		request.setAttribute("capacity_num", capacity_num);
		request.setAttribute("seat_num", seat_num);
		
		return "makeDiv";
		
		
		
	}
	
	
	@RequestMapping(value="oneplus.action" , method={RequestMethod.GET, RequestMethod.POST})
	public String onePlus(HttpServletRequest req){
		
		List<ShowDTO> oneplus = new ArrayList<ShowDTO>();
		List<ShowDTO> lists = dao.showList();
		Iterator<ShowDTO> it = lists.iterator();
		
		while(it.hasNext()){
			ShowDTO vo = it.next();
			
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
				if(vo.getShowName().indexOf(" [")!=-1){
					String[] showName = vo.getShowName().split(" \\[");
					vo.setShowName(showName[0]);
				}
				oneplus.add(vo);
			}
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			} 
			
			if(vo.getShowPrice().indexOf("원")<0){
				vo.setPriceForCompare(0);
			}else{
				String[] priceTemp = vo.getShowPrice().split(", ");
				if(priceTemp.length==1){
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
				}else{
					vo.setPriceForCompare(Integer.parseInt(priceTemp[0].substring(priceTemp[0].indexOf(" ")+1, priceTemp[0].indexOf("원")).replace(",", "")));
					
					for(String temp:priceTemp){
						int price = Integer.parseInt(temp.substring(temp.indexOf(" ")+1, temp.indexOf("원")).replace(",", ""));
						if(vo.getPriceForCompare()>=price){
							vo.setPriceForCompare(price);
						}
					}
				}
			}
			
			PlaceDTO pdto = dao.getPlace(vo.getPlaceId());
			vo.setPlaceAddr(pdto.getPlaceAddr().substring(0,pdto.getPlaceAddr().indexOf(" ")));
		}
		
		req.setAttribute("lists", oneplus);
		return "oneplus.tiles";
	}
	
	@RequestMapping(value="main.action")
	public String main(HttpServletRequest req, HttpServletResponse resp){
		
		List<ShowDTO> lists = dao.showList();
		Iterator<ShowDTO> it = lists.iterator();
		while(it.hasNext()){
			ShowDTO vo = it.next();
			if(vo.getShowPrice().indexOf("전석")==-1){
				vo.setSeatState("좌석 별로 다름");
			} 
			if(dao.getOneplus(vo.getShowId())!=null){
				vo.setEvent("oneplus");
			}
		}
		
		
		String[] day = {"일","월","화","수","목","금","토"};
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
		List<ShowDTO> todayTemp = dao.getShowToday(sdf.format(date));
		List<ShowDTO> today = new ArrayList<ShowDTO>();
		Iterator<ShowDTO> iter = todayTemp.iterator();
		while(iter.hasNext()){
			ShowDTO vo = iter.next();
			
			Iterator<SeatDTO> seatIter = dao.getDayDist(vo.getShowId()).iterator();
			while(seatIter.hasNext()){
				SeatDTO vs = seatIter.next();
				if(day[cal.get(Calendar.DAY_OF_WEEK)-1].equals(vs.getShowDay())){
					//System.out.println(day[cal.get(Calendar.DAY_OF_WEEK)-1] + "요일");
					//System.out.println(vo.getShowName()+"은 " +vs.getShowDay()+"상영" + "("+vo.getShowFrom()+"~"+vo.getShowTo()+")");
					if(vo.getShowPrice().indexOf("전석")==-1){
						vo.setSeatState("좌석 별로 다름");
					} 
					if(dao.getOneplus(vo.getShowId())!=null){
						vo.setEvent("oneplus");
					}
					today.add(vo);
					break;
				}
			}
		}
		
		req.setAttribute("todayList", today);
		req.setAttribute("lists", lists);
		return "main.tiles";
	}

	/*@RequestMapping(value="/layout.action", method={RequestMethod.GET,RequestMethod.POST})
	public String layout(HttpServletRequest req, HttpServletResponse resp, String showId, String showName)
			throws Exception{

		ShowDTO showdto = dao.getShow(showId);
		List<SeatDTO> seatdto = dao.getTime(showId);
		HttpSession session = req.getSession();

		int[] price = new int[10]; 
		String[] seat = new String[10];
		int i=0;
		String[] priceTemp = showdto.getShowPrice().split(", ");
		for(String str:priceTemp){
			seat[i] = str.substring(0, str.indexOf("석")+1);
			price[i] = Integer.parseInt(str.substring(str.indexOf("석")+2, str.indexOf("원")).replace(",", ""));
			i++;
		}
		
		List<SeatDTO> distDate = dao.getDistDate(showId);
		
		
		session.setAttribute("showId", showId);
		req.setAttribute("show", showdto);
		req.setAttribute("time", seatdto);
		req.setAttribute("price", price);
		req.setAttribute("seat", seat);
		req.setAttribute("length", i-1);
		req.setAttribute("date", distDate);
		
		return "layout";
	}*/
	
	@RequestMapping(value="/layout.action", method={RequestMethod.GET,RequestMethod.POST})
	public String layout(HttpServletRequest req, HttpServletResponse resp,String placeId, String showId, String showName)
			throws Exception{
		
		String url = req.getParameter("url");
		
		if(url==null){
			url = "notice.action";
		}
		//System.out.println(showId+"layout.action");
		ShowDTO showdto = dao2.getShow(showId); // 해당 showId에 대한 공연 정보 불러오기
		if(dao.getOneplus(showId)!=null){
			showdto.setEvent("oneplus");
		}
		placeId = showdto.getPlaceId();
		PlaceDTO placedto = dao2.getPlace(placeId); // 해당 placeId에 대한 장소 정보 불러오기
		List<SeatDTO> seatdto = dao2.getTime(showId); // 해당 showId에 대한 공연날짜,시간,좌석 등 불러오기
		
		HttpSession session = req.getSession();

		int[] price = new int[10]; 
		String[] seat = new String[10];
		int i=0;
		String[] priceTemp = showdto.getShowPrice().split(", "); // 해당 공연에서 좌석등급(R석,S석 등)이 여러개일때를 대비하여..

		for(String str:priceTemp){
			seat[i] = str.substring(0, str.indexOf("석")+1); // 좌석 등급값
			price[i] = Integer.parseInt(str.substring(str.indexOf("석")+2, str.indexOf("원")).replace(",", "")); // 좌석 가격값
			i++;
		}
		
		List<SeatDTO> distDate = dao2.getDistDate(showId);
		
		session.setAttribute("showId", showId);
		req.setAttribute("url", url);
		req.setAttribute("show", showdto);
		req.setAttribute("time", seatdto);
		req.setAttribute("priceSeat", priceTemp);
		req.setAttribute("price", price);
		req.setAttribute("place", placedto);
		req.setAttribute("seat", seat);
		req.setAttribute("length", i-1);
		req.setAttribute("date", distDate);
		return "layout.tiles";
	}
	
	@RequestMapping(value="/notice.action", method={RequestMethod.POST})
	public String changeToNotice(HttpServletRequest req, HttpServletResponse resp,String placeId, String showId, String showName) {
		
		HttpSession session = req.getSession();
		ShowDTO showdto = dao2.getShow(showId);
		
		req.setAttribute("show", showdto);
		session.setAttribute("showId", showId);
		return "notice";
	}
	
/*	@RequestMapping(value="/review.action", method={RequestMethod.POST})
	public String changeToReview() {
		return "review";
	}*/
	
	//Review ----------------------------------------------------------------------
	
	@RequestMapping(value="/created.action")
	public ModelAndView created(){
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("created");
		
		return mav;
		
	}
	

	@RequestMapping(value="/created_ok.action",method={RequestMethod.GET,RequestMethod.POST})
	public String created_ok(ReviewDTO dto,HttpServletRequest req, String showId, String userId,
			HttpServletResponse response){
		
		HttpSession session = req.getSession();
		
		showId = (String)session.getAttribute("showId");
		TicketDTO ticketdto = (TicketDTO)session.getAttribute("loginDto");
		userId = ticketdto.getUserId();
		
		
		int maxNum = dao2.getMaxNum();
		dto.setUserId(userId);
		dto.setShowId(showId);
		dto.setNum(maxNum + 1);
		dto.setStar(Integer.parseInt(req.getParameter("star")));
		
		
		dao2.insertData(dto);
		
		return "redirect:/layout.action?url=review.action&showId="+showId;
		
	}
	
	@RequestMapping(value="/updateReview.action")
	public String updateReview(HttpServletRequest req,
			HttpServletResponse resp,String showId) throws Exception{
		
		System.out.println("updateReview.action");
		HttpSession session = req.getSession();
		
		showId = (String)session.getAttribute("showId");
		System.out.println(showId);
		int num = Integer.parseInt(req.getParameter("num"));
		
		ReviewDTO dto = dao2.getReadData(num);
		
		req.setAttribute("dto", dto);
		
		return "updateReview";
		
	}
	
	@RequestMapping(value="/updated_ok.action",method={RequestMethod.GET,RequestMethod.POST})
	public String updated_ok(ReviewDTO dto,HttpServletRequest req, String showId,
			HttpServletResponse response){
		
		HttpSession session = req.getSession();
		
		showId = (String)session.getAttribute("showId");

		
		dao2.updateData(dto);
		
		return "redirect:/layout.action?url=review.action&showId="+showId;
		
	}
	
	@RequestMapping(value="/deleted_ok.action",method={RequestMethod.GET,RequestMethod.POST})
	public String deleted_ok(ReviewDTO dto,HttpServletRequest req, 
			HttpServletResponse response) throws Exception{
		
		int num = Integer.parseInt(req.getParameter("num"));
		
		dao2.deleteData(num);
		
		HttpSession session = req.getSession();
		
		String showId = (String)session.getAttribute("showId");
		
		return "redirect:/layout.action?url=review.action&showId="+showId;
		
		
	}
	
		@RequestMapping(value="/review.action", method={RequestMethod.GET,RequestMethod.POST})
		public String listCmt(HttpServletRequest req,String showId, String showName,
				HttpServletResponse response) throws Exception{
			
			HttpSession session = req.getSession();
			
			showId = (String)session.getAttribute("showId");
			
			List<ReviewDTO> lists = dao2.getList(showId);
			
			ShowDTO showdto = dao2.getShow(showId);
			
			TicketDTO userId = (TicketDTO)session.getAttribute("loginDto");
			
			String message = "댓글 사용 불가";
			
			if(userId!=null){
				
			List<BookDTO> bookList = dao2.getReadDataByUserId(userId.getUserId(), showId);
			
			Iterator<BookDTO> Bookit = bookList.iterator();
			
			
			while(Bookit.hasNext()){
				
				BookDTO dto = Bookit.next();
				
				String showDay = "17." + dto.getShowDay();
				
				System.out.println(showDay);
				
				
				SimpleDateFormat format = new SimpleDateFormat("YY.MM.dd");
				
				Date getCurrentTime  = new Date();
				
				
				
				String currentTime = format.format(getCurrentTime);
				
				
				
				System.out.println(currentTime);
				
				
			
				
				int compare = showDay.compareTo(currentTime);
				String bookState = dto.getBookState();
				System.out.println(bookState+"cccc");
				if(compare<0 && bookState.equals("3")){
					
					message = "댓글사용가능";
					
				}
				
			}
			
				
			}
			
			Iterator<ReviewDTO> it = lists.iterator();
			
			while(it.hasNext()){
				
				ReviewDTO stardto = it.next();
				
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
			
			req.setAttribute("lists", lists);
			req.setAttribute("show", showdto);
			req.setAttribute("message", message);
			
			return "review";
			
		}
	
	
	@RequestMapping(value="/detail.action", method={RequestMethod.POST})
	public String changeToDetail(HttpServletRequest req, String showId) {
		ImageDTO dto = dao.getImage(showId);
		req.setAttribute("image", dto);
		return "detail";
	}
	
	@RequestMapping(value="/qna.action", method={RequestMethod.GET,RequestMethod.POST})
	public String changeToQna(QnaDTO dto,HttpServletRequest req,String showId, String showName,
			HttpServletResponse response) throws Exception{
		
		
		HttpSession session = req.getSession();
		showId = (String)session.getAttribute("showId");
		
		List<QnaDTO> listsQA = dao2.getListDataQna(showId);
		
		//포워딩 될 페이지에 데이터를 넘긴다
		req.setAttribute("listsQA", listsQA);
		
		return "qna";
	}
	
	@RequestMapping(value="/createdQna.action")
	public ModelAndView createdQna(){
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("createdQA");
		
		return mav;
		
	}
	
	@RequestMapping(value="/created_okQA.action",method={RequestMethod.GET,RequestMethod.POST})
	public String created_okQA(QnaDTO dto,HttpServletRequest req, String showId, String userIdQna,
			HttpServletResponse response){
		
		HttpSession session = req.getSession();
		
		showId = (String)session.getAttribute("showId");
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		userIdQna = ticket.getUserId();
		
		
				
		int maxNum = dao2.getMaxBoardNumQna();
		
		dto.setShowId(showId);
		dto.setUserId(userIdQna);
		dto.setBoardNum(maxNum + 1);
		dto.setGroupNum(dto.getBoardNum());
		
		dao2.insertDataQna(dto);
		
		return "redirect:/layout.action?url=qna.action&showId="+showId;
		
	}
	
	
	@RequestMapping(value="/createdQnaReply.action")
	public ModelAndView createdQnaReply(String showId,QnaDTO dto,HttpServletRequest req){
		
		HttpSession session = req.getSession();
		
		showId = (String)session.getAttribute("showId");
		
		ModelAndView mav = new ModelAndView();

		req.setAttribute("groupNum", dto.getBoardNum());
		req.setAttribute("boardNum", dto.getBoardNum());
		
		mav.setViewName("createdQnaReply");
		
		return mav;
		
	}



@RequestMapping(value="/created_okQnaReply.action",method={RequestMethod.GET,RequestMethod.POST})
	public String created_okQnaReply(QnaDTO dto,HttpServletRequest req,String showId,String userId,HttpServletResponse response){
		
		HttpSession session = req.getSession();
		
		showId = (String)session.getAttribute("showId");
		TicketDTO ticket = (TicketDTO)session.getAttribute("loginDto");
		userId = ticket.getUserId();
		
		dto.setContent("[답변]" + dto.getContent());

		dao2.getUpdateReplyData(dto);
		
		int maxBoardNum = dao2.getMaxBoardNumQna();
		
		dto.setShowId(showId);
		dto.setUserId(userId);
		dto.setBoardNum(maxBoardNum + 1);
		dto.setDepth(dto.getDepth() + 1);
		dto.setOrderNo(dto.getOrderNo() + 1);
		dto.setGroupNum(dto.getGroupNum());
		
		dao2.insertDataQna(dto);
		
		return "redirect:/layout.action?url=qna.action&showId="+showId;
		
	}



	@RequestMapping(value="/deleted_okQna.action",method={RequestMethod.GET,RequestMethod.POST})
	public String deleted_ok(QnaDTO dto,HttpServletRequest req, 
			HttpServletResponse response) throws Exception{
		
		int boardNum = dto.getBoardNum();
		
		dao2.deleteDataQna(boardNum);
		
		HttpSession session = req.getSession();
		
		String showId = (String)session.getAttribute("showId");
		
		return "redirect:/layout.action?url=qna.action&showId="+showId;
		
	}
	
	@RequestMapping(value="setDate.action", method={RequestMethod.GET,RequestMethod.POST})
	public String setDate(HttpServletRequest req, HttpServletResponse resp, String showId)
			throws Exception{
		
		List<SeatDTO> distDate = dao.getDistDate(showId);
		req.setAttribute("date", distDate);
		req.setAttribute("showId", showId);
		
		return "setDate";
		
	}
	
	@RequestMapping(value="group_reservation.action", method={RequestMethod.GET,RequestMethod.POST})
	public String group_reservation(HttpServletRequest req, HttpServletResponse resp,String placeId, String showId, String showName)
			throws Exception{
		
		
		
		
		
		
		
		
		/*if(showId!=null){
		
		ShowDTO showdto = dao.getShow(showId);
		//placeId = showdto.getPlaceId();
		//PlaceDTO placedto = dao.getPlace(placeId);
		List<SeatDTO> seatdto = dao.getTime(showId);
		

		int[] price = new int[10]; 
		String[] seat = new String[10];
		int i=0;
		String[] priceTemp = showdto.getShowPrice().split(", ");

		for(String str:priceTemp){
			seat[i] = str.substring(0, str.indexOf("석")+1);
			price[i] = Integer.parseInt(str.substring(str.indexOf("석")+2, str.indexOf("원")).replace(",", ""));
			i++;
		}
		
		List<SeatDTO> distDate = dao.getDistDate(showId);
		
		
		req.setAttribute("show", showdto);
		req.setAttribute("time", seatdto);
		req.setAttribute("priceSeat", priceTemp);
		req.setAttribute("price", price);
		//req.setAttribute("place", placedto);
		req.setAttribute("seat", seat);
		req.setAttribute("length", i-1);
		req.setAttribute("date", distDate);
		
		}*/
		
		
		return "group_reservation.tiles";
	}

	
	
	
	


}
