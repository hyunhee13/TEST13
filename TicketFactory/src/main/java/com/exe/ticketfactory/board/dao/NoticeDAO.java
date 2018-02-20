package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.NoticeDTO;

public class NoticeDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	//의존성 주입
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate){
		this.sessionTemplate = sessionTemplate;
	}

	//공지 num최대값
	public int getMaxNum(){
		
		int maxNum = 0;
		
		maxNum = sessionTemplate.selectOne("customerMapper.maxNum");
		
		return maxNum;
	}
	
	//공지 입력(created.jsp->created_ok.jsp)
	public void insertData(NoticeDTO dto){
		
		sessionTemplate.insert("customerMapper.insertData",dto);
		
	}
	
	//공지 전체데이터
	public List<NoticeDTO> getList(int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<NoticeDTO> lists = 
				sessionTemplate.selectList("customerMapper.getLists",params);
		
		return lists;
		
	}
		
	//공지 전체 데이터수 구하기
	public int getDataCount(){
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		int result = 
				sessionTemplate.selectOne("customerMapper.getDataCount",params);
		
		return result;
		
	}
	//공지 한명의 데이터 출력
	public NoticeDTO getReadData(int notiNum){
		
		NoticeDTO dto = sessionTemplate.selectOne("customerMapper.getReadData",notiNum);
		
		return dto;
		
	}
	
	//공지 삭제
	public void deleteData(int notiNum){
		
		sessionTemplate.delete("customerMapper.deleteData",notiNum);
	
	}
		
	//공지 수정
	public void updateData(NoticeDTO dto){
		
		sessionTemplate.update("customerMapper.updateData",dto);
		
	}

}
