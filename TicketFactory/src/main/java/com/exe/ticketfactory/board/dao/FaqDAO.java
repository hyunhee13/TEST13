package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.FaqDTO;

public class FaqDAO {
	
	private SqlSessionTemplate sessionTemplate;
	
	//의존성 주입
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate){
		this.sessionTemplate = sessionTemplate;
	}
	
	//num최대값
	public int getMaxNum(){
		
		int maxFaqNum = 0;
		
		maxFaqNum = sessionTemplate.selectOne("customerMapper.faqMaxNum");
		
		return maxFaqNum;
	}
	//입력
	public void insertData(FaqDTO dto){
			
		sessionTemplate.insert("customerMapper.faqInsertData",dto);
			
	}
	//공지 전체데이터
	public List<FaqDTO> fgetList(int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<FaqDTO> lists = 
				sessionTemplate.selectList("customerMapper.faqGetLists",params);
		
		return lists;
		
	}
	
	//공지 hitCount수로 3명 리스트 뽑기
	public List<FaqDTO> fgetHitCountList(){
		
		List<FaqDTO> fhlists =
				sessionTemplate.selectList("customerMapper.faqGetHitCountList");
		
		return fhlists;
		
	}
			
	//공지 전체 데이터수 구하기
	public int faqGetDataCount(){
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		int result = 
				sessionTemplate.selectOne("customerMapper.faqGetDataCount",params);
		
		return result;
		
	}
	//공지 한명의 데이터 출력
	public FaqDTO getReadData(int faqNum){
		
		FaqDTO dto = sessionTemplate.selectOne("customerMapper.faqGetReadData",faqNum);
		
		return dto;
		
	}
			
	//삭제
	public void faqDeleteData(int faqNum){
		
		sessionTemplate.delete("customerMapper.faqDeleteData",faqNum);
	
	}
			
	//수정
	public void updateData(FaqDTO dto){
		
		sessionTemplate.update("customerMapper.faqUpdateData",dto);
		
	}
	
	//조회수증가
	public void faqUpdateHitCount(int faqNum){
		
		sessionTemplate.update("customerMapper.faqUpdateHitCount",faqNum);
	
	}

}
