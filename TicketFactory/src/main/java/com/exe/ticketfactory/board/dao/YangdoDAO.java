package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.YangdoDTO;

public class YangdoDAO {
	
	private SqlSessionTemplate sessionTemplate;

	//의존성주입
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}

	//맥넘
	public int getMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("customerMapper.ydMaxNum");
		return maxNum;
		
	}
	
	//입력
	public void insertData(YangdoDTO dto){
		
		sessionTemplate.insert("customerMapper.ydInsertData",dto);
		
	}
		
	//전체데이터
	public List<YangdoDTO> getList(int start, int end,
		String searchKey, String searchValue){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		List<YangdoDTO> lists = 
				sessionTemplate.selectList("customerMapper.ydGetLists",params);
		
		return lists;
		
	}
	
	//전체 데이터수 구하기
	public int getDataCount(String searchKey,String searchValue){
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result = 
			sessionTemplate.selectOne("customerMapper.ydGetDataCount",params);
		
		return result;
		
	}
	
	//한명의 데이터 출력
	public YangdoDTO getReadData(int ydNum){
		
		YangdoDTO dto = sessionTemplate.selectOne("customerMapper.ydGetReadData",ydNum);
		
		return dto;
		
	}
	
	//수정
	public void updateData(YangdoDTO dto){
		
		sessionTemplate.update("customerMapper.ydUpdateData",dto);
		
	}

	//삭제
	public void deleteData(int ydNum){
		
		sessionTemplate.delete("customerMapper.ydDeleteData",ydNum);
		sessionTemplate.delete("customerMapper.ydDeleteAllData",ydNum);
		
	
	}
	
	//조회수증가
	public void updateHitCount(int ydNum){
		
		sessionTemplate.update("customerMapper.ydUpdateHitCount",ydNum);
	
	}
}
