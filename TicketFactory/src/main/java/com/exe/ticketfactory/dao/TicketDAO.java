package com.exe.ticketfactory.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.dto.BookDTO;
import com.exe.ticketfactory.dto.SearchDTO;
import com.exe.ticketfactory.dto.TicketDTO;



public class TicketDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate){
		this.sessionTemplate = sessionTemplate;
	}
	
	public void insertData(TicketDTO dto){
		
		sessionTemplate.insert("signMapper.insertData",dto);
		
	}
	
	
	public List<BookDTO> getBookAll(String userId){
		
		List<BookDTO> lists =
				sessionTemplate.selectList("signMapper.getBookAll", userId);

		return lists;
	}
	
	
	//구매내역 부분
	public int getBookCount(String userId){
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			
			params.put("userId", userId);
			
			int totalCount =
			sessionTemplate.selectOne("signMapper.getBookCount", params);
		
			return totalCount;
		}
	
	public TicketDTO checkId(String userId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		
		TicketDTO dto =
		sessionTemplate.selectOne("signMapper.checkId", params);
	
		return dto;
	}
	
	public TicketDTO login(String userId,String userPwd){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		params.put("userPwd", userPwd);
		
		TicketDTO dto =
		sessionTemplate.selectOne("signMapper.login", params);
	
		return dto;
	}
	
	public void updateData(TicketDTO dto){

		sessionTemplate.update("signMapper.updateData", dto);
		
	}
	
	public void deleteData(String userId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		
		sessionTemplate.delete("signMapper.deleteData", params);
	}
	
	public TicketDTO search_id(String userName,String userEmail){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userName", userName);
		params.put("userEmail", userEmail);
		
		TicketDTO dto =
		sessionTemplate.selectOne("signMapper.search_id", params);
	
		return dto;
	}
	
	public TicketDTO search_pwd(String userId,String userEmail){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		params.put("userEmail", userEmail);
		
		TicketDTO dto =
		sessionTemplate.selectOne("signMapper.search_pwd", params);
	
		return dto;
	}

	
//	검색키워드로 데이터뿌리기!!!!
	public List<SearchDTO> searchList(String search_word, int start, int end) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("search_word", search_word);
		
		List<SearchDTO> searchList = sessionTemplate.selectList("signMapper.searchData", params);
		return searchList;
	}
	
//	검색된 키워드의 데이터들 총 갯수
	public int getDataCount(String search_word) {
		
		int result = sessionTemplate.selectOne("signMapper.getDataCount", search_word);
		return result;
	}
	

	
}
