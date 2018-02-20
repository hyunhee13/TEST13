package com.exe.ticketfactory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.dto.ImageDTO;
import com.exe.ticketfactory.dto.PlaceDTO;
import com.exe.ticketfactory.dto.SeatDTO;
import com.exe.ticketfactory.dto.ShowDTO;

public class DetailDAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sqlSessionTemplate){
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	
	///////////////////////////////////////////////////////////////////////
	public List<ShowDTO> showList(){
		return sqlSessionTemplate.selectList("dataMapper.selectShowAll");
	}
	public List<ShowDTO> showListWithoutEvent(){
		return sqlSessionTemplate.selectList("dataMapper.selectShowAllWithoutEvent");
	}
	public List<ShowDTO> showListWithEvent(){
		return sqlSessionTemplate.selectList("dataMapper.selectShowAllWithEvent");
	}
	public ShowDTO getShow(String showId){
		return sqlSessionTemplate.selectOne("dataMapper.selectShowOne",showId);
	}
	public List<ShowDTO> getShowToday(String today){
		return sqlSessionTemplate.selectList("dataMapper.selectShowToday",today);
	}
	public List<ShowDTO> getShowByGenre(String genre){
		return sqlSessionTemplate.selectList("dataMapper.getShowByGenre",genre);
	}
	public List<ShowDTO> selectShowByGenre(String genre, int start, int end){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("showGenre", genre);
		map.put("start", start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("dataMapper.selectShowByGenre",map);
	}
	public List<ShowDTO> getShowByGenreDate(String genre,String date, String order){
		Map<String, String> map = new HashMap<String,String>();
		map.put("showGenre", genre);
		map.put("showDate", date);
		map.put("order", order);
		return sqlSessionTemplate.selectList("dataMapper.getShowByGenreDate",map);
	}
	public List<ShowDTO> getShowWithoutEvent(String genre, int start, int end){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("showGenre", genre);
		map.put("start", start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("dataMapper.selectShowWithoutEvent",map);
	}
	public List<ShowDTO> getShowWithEvent(String genre, int start, int end){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("showGenre", genre);
		map.put("start", start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("dataMapper.selectShowWithEvent",map);
	}
	public int getShowCount(String showGenre){
		return sqlSessionTemplate.selectOne("dataMapper.getShowCount",showGenre);
	}
	public int getShowCountWithoutEvent(String showGenre){
		return sqlSessionTemplate.selectOne("dataMapper.getShowCountWithoutEvent",showGenre);
	}
	public int getShowCountWithEvent(String showGenre){
		return sqlSessionTemplate.selectOne("dataMapper.getShowCountWithEvent",showGenre);
	}
	///////////////////////////////////////////////////////////////////////
	public List<PlaceDTO> placeList(){
		return sqlSessionTemplate.selectList("dataMapper.selectPlaceAll");
	}
	public PlaceDTO getPlace(String placeId){
		return sqlSessionTemplate.selectOne("dataMapper.selectPlaceOne",placeId);
	}
	
	///////////////////////////////////////////////////////////////////////
	public List<SeatDTO> timeList(){
		return sqlSessionTemplate.selectList("dataMapper.selectTimeAll");
	}
	public List<SeatDTO> getTime(String showId){
		return sqlSessionTemplate.selectList("dataMapper.selectTimeOne",showId);
	}
	public List<SeatDTO> getTimeByDay(String showId, String showDay){
		Map<String, String> map = new HashMap<String, String>();
		map.put("showId", showId);
		map.put("showDay", showDay);
		return sqlSessionTemplate.selectList("dataMapper.selectTimeByDay",map);
	}
	public List<SeatDTO> getDayDist(String showId){
		return sqlSessionTemplate.selectList("dataMapper.selectDayDist",showId);
	}
	public List<SeatDTO> getDistDate(String showId){
		return sqlSessionTemplate.selectList("dataMapper.selectDistDate",showId);
	}
	public List<SeatDTO> getTimeByDate(String showId, String showDate){
		List<SeatDTO> lists = null;
		Map<String, String> map = new HashMap<>();
		map.put("showId", showId);
		map.put("showDate", showDate);
		lists= sqlSessionTemplate.selectList("dataMapper.selectTimeByDate",map);
		return lists;
	}
	///////////////////////////////////////////////////////////////////////
	public ImageDTO getImage(String showId){
		return sqlSessionTemplate.selectOne("dataMapper.selectImageOne",showId);
	}
	
	public List<ImageDTO> imageList(){
		return sqlSessionTemplate.selectList("dataMapper.selectImageAll");
	}
	////////////////////////////////////////////////////////////////////////
	public String getOneplus(String showId){
		return sqlSessionTemplate.selectOne("dataMapper.selectOneplus",showId);
	}
	public void insertOneplus(String showId){
		sqlSessionTemplate.insert("dataMapper.insertOneplus",showId);
	}
	public void deleteOneplus(String showId){
		sqlSessionTemplate.delete("dataMapper.deleteOneplus",showId);
	}
	public String getAvgStar(String showId){
		return sqlSessionTemplate.selectOne("dataMapper.selectAvgStar",showId);
	}
	/////////////////////////////////////////////////////////////////////////////
	

}
