package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.EnquiryCommentDTO;

public class EnquiryCommentDAO {
	
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}
	
	//코멘트 num최대값
	public int getMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("customerMapper.eqcMaxNum");
		return maxNum;
		
	}
	
	//입력
	public void insertData(EnquiryCommentDTO dto){
		
		sessionTemplate.insert("customerMapper.eqcInsertData",dto);
	}
	
	//코멘트 전체데이터
	public List<EnquiryCommentDTO> getList(int start, int end,int eqNum){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("eqNum", eqNum);
		
		List<EnquiryCommentDTO> lists = 
				sessionTemplate.selectList("customerMapper.eqcGetLists",params);
		
		return lists;
			
		}
	
	//코멘트 전체 데이터수 구하기
		public int GetDataCount(int eqNum){
			
			int result = 
					sessionTemplate.selectOne("customerMapper.eqcGetDataCount",eqNum);
			
			return result;
			
		}
		
	//삭제
	public void DeleteData(int eqcNum){
		
		sessionTemplate.delete("customerMapper.eqcDeleteData",eqcNum);
	
	}

}
