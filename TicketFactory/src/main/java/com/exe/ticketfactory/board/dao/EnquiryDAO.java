package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.EnquiryDTO;

public class EnquiryDAO {
	
	private SqlSessionTemplate sessionTemplate;

	//의존성주입
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}

	//문의게시판 num최대값
	public int getMaxNum(){
		
		int maxNum = 0;
		
		maxNum = sessionTemplate.selectOne("customerMapper.eqMaxNum");
		
		return maxNum;
	}
	//입력
	public void insertData(EnquiryDTO dto){
		
		sessionTemplate.insert("customerMapper.eqInsertData",dto);
		
	}
	
	//전체데이터
	public List<EnquiryDTO> getList(int start, int end,
		String searchKey, String searchValue){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		List<EnquiryDTO> lists = 
				sessionTemplate.selectList("customerMapper.eqGetLists",params);
		
		return lists;
		
	}
	
	//멤버데이터만 뽑자능
	public List<EnquiryDTO> getMemberList(int start, int end,
		String searchKey, String searchValue, String eqId){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("eqId", eqId);
		
		List<EnquiryDTO> lists = 
				sessionTemplate.selectList("customerMapper.eqMemberGetLists",params);
		
		return lists;
		
	}
	
	//전체 데이터수 구하기
	public int getDataCount(String searchKey,String searchValue){
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result = 
			sessionTemplate.selectOne("customerMapper.eqGetDataCount",params);
		
		return result;
		
	}
	
	//멤버 데이터수 구하기
	public int getMemberDataCount(String searchKey,String searchValue,String eqId){
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("eqId", eqId);
		
		int result = 
			sessionTemplate.selectOne("customerMapper.eqGetMemberDataCount",params);
		
		return result;
		
	}

	//한명의 데이터 출력
	public EnquiryDTO getReadData(int eqNum){
		
		EnquiryDTO dto = sessionTemplate.selectOne("customerMapper.eqGetReadData",eqNum);
		
		return dto;
		
	}
	
	//삭제
	public void deleteData(int eqNum){
		
		sessionTemplate.delete("customerMapper.eqDeleteData",eqNum);
		sessionTemplate.delete("customerMapper.eq_DeleteData",eqNum);
	
	}

}
