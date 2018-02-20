package com.exe.ticketfactory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.ShowReviewDTO;
import com.exe.ticketfactory.dto.BookDTO;
import com.exe.ticketfactory.dto.ImageDTO;
import com.exe.ticketfactory.dto.PlaceDTO;
import com.exe.ticketfactory.dto.QnaDTO;
import com.exe.ticketfactory.dto.SeatDTO;
import com.exe.ticketfactory.dto.ShowDTO;
import com.exe.ticketfactory.dto.ReviewDTO;

public class Detail2DAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sqlSessionTemplate){
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	
	///////////////////////////////////////////////////////////////////////
	public List<ShowDTO> showList(){
		return sqlSessionTemplate.selectList("dataMapper2.selectShowAll");
	}
	public ShowDTO getShow(String showId){
		return sqlSessionTemplate.selectOne("dataMapper2.selectShowOne",showId);
	}
	///////////////////////////////////////////////////////////////////////
	
	
	public List<PlaceDTO> placeList(){
		return sqlSessionTemplate.selectList("dataMapper2.selectPlaceAll");
	}
	public PlaceDTO getPlace(String placeId){
		return sqlSessionTemplate.selectOne("dataMapper2.selectPlaceOne",placeId);
	}
	
	
	///////////////////////////////////////////////////////////////////////
	public List<SeatDTO> timeList(){
		return sqlSessionTemplate.selectList("dataMapper2.selectTimeAll");
	}
	public List<SeatDTO> getTime(String showId){
		return sqlSessionTemplate.selectList("dataMapper2.selectTimeOne",showId);
	}
	public List<SeatDTO> getTimeByDay(String showId, String showDay){
		Map<String, String> map = new HashMap<String, String>();
		map.put("showId", showId);
		map.put("showDay", showDay);
		return sqlSessionTemplate.selectList("dataMapper2.selectTimeByDay",map);
	}
	public List<SeatDTO> getDayDist(String showId){
		return sqlSessionTemplate.selectList("dataMapper2.selectDayDist",showId);
	}
	///////////////////////////////////////////////////////////////////////
	
	
	public ImageDTO getImage(String showId){
		return sqlSessionTemplate.selectOne("dataMapper2.selectImageOne",showId);
	}
	
	public List<ImageDTO> imageList(){
		return sqlSessionTemplate.selectList("dataMapper2.selectImageAll");
	}
	
	public void insertComment(ReviewDTO dto){
		
		sqlSessionTemplate.insert("dataMapper2.insertComment",dto);
		
	}
	
	public List<SeatDTO> getTimeByDate(String showId, String showDate){
		Map<String, String> map = new HashMap<String, String>();
		map.put("showId", showId);
		map.put("showDate", showDate);
		return sqlSessionTemplate.selectList("dataMapper2.selectTimeByDate",map);
	}
	
	public List<SeatDTO> getDistDate(String showId){
		return sqlSessionTemplate.selectList("dataMapper2.selectDistDate",showId);
	}
	
	
//Review Test 해보기 //////////////////////////////////////////
	//1.num의 최대값
	public int getMaxNum(){
		
		int maxNum = 0;
		
		maxNum = 
				sqlSessionTemplate.selectOne("dataMapper2.maxNum");
		
		return maxNum;
		
	}
	
	
	public void insertData(ReviewDTO dto){
		
/*		HttpSession session = req.getSession();
		
		String showId = (String)session.getAttribute("showId");
			
		dto.setShowId(showId);*/
		
		sqlSessionTemplate.insert("dataMapper2.insertData",dto);
		
	}
	
	//list
/*	public List<ReviewDTO> getList(int start, int end,
			String searchKey, String searchValue,String showId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		List<ReviewDTO> lists = 
				sqlSessionTemplate.selectList("dataMapper2.getLists" , params);
		

		return lists;

	}*/
	
	
	public List<ReviewDTO> getList(String showId){
		
		List<ReviewDTO> lists = 
				sqlSessionTemplate.selectList("dataMapper2.getLists_d",showId);
		
		return lists;
	}
	
	
	
	//하나의 데이터 개수
	public int getDataCount(String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result= 
				sqlSessionTemplate.selectOne("dataMapper2.getDataCount" , params);

		return result;

	}
	
	public void updateData(ReviewDTO dto){
		
		sqlSessionTemplate.update("dataMapper2.updateData",dto);
		
	}
	
	//하나의 데이터 가져오기
	public ReviewDTO getReadData(int num){
		
		ReviewDTO dtoOne = 
				sqlSessionTemplate.selectOne("dataMapper2.getReadData",num);

		return dtoOne;

	}
	
	public List<BookDTO> getReadDataByUserId(String userId, String showId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		params.put("showId", showId);
		
		List<BookDTO> lists =
				sqlSessionTemplate.selectList("dataMapper2.getReadDataByUserId", params);
		
		return lists;
		
		
	}
	
	//delete
	public void deleteData(int num){
		
		sqlSessionTemplate.delete("dataMapper2.deleteData",num);
			
		
	}
	
	
//Q & A Test 해보기 //////////////////////////////////////////
	
	public int getMaxBoardNumQna(){
		
		int maxNum = 0;
		
		maxNum = 
				sqlSessionTemplate.selectOne("dataMapper2.maxBoardNumQna");
		
		return maxNum;
		
	}
	
	public void insertDataQna(QnaDTO dto){
		
		
		sqlSessionTemplate.insert("dataMapper2.insertDataQna", dto);
		
	}
	
	public List<QnaDTO> getListDataQna(String showId){
		
		List<QnaDTO> lists = 
				sqlSessionTemplate.selectList("dataMapper2.listDataQna",showId);
		
		return lists;
		
	}
	
	public int getDataCountQna(String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result= 
				sqlSessionTemplate.selectOne("dataMapper2.dataCountQna" , params);

		return result;

	}
	
	public void getUpdateReplyData(QnaDTO dto){
	
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		hMap.put("groupNum", dto.getGroupNum());
		hMap.put("orderNo", dto.getOrderNo());
		
		sqlSessionTemplate.update("dataMapper2.orderNoUpdateQna", hMap);	
		
	}
	
	
	//delete
	public void deleteDataQna(int boardNum){
		
		sqlSessionTemplate.delete("dataMapper2.deleteDataQna",boardNum);
			
		
	}
	
	//delete
	public void deleteDataEX(int boardNum){
		
		sqlSessionTemplate.delete("dataMapper2.deleteDataEX",boardNum);
			
		
	}

	//실시간리뷰
	public List<ShowReviewDTO> getListReview(int start, int end,
			String searchKey, String searchValue){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		List<ShowReviewDTO> lists = 
				sqlSessionTemplate.selectList("dataMapper2.getListsReview",params);
		
		return lists;
		
	}
	
	public List<ShowReviewDTO> getReviewAvg(int start, int end){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("dataMapper2.getReviewAvg",map);
	}
	
	public List<String> getReviewCount(){
		return sqlSessionTemplate.selectList("dataMapper2.getReviewCount");
	}
	
	public int getStarAvg(String showId){
		return sqlSessionTemplate.selectOne("dataMapper2.getStarAvg",showId);
	}
	

	
}	





















