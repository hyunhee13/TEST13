package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.YangdoCommentDTO;

public class YangdoCommentDAO {
	
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}
	
	//코멘트 num최대값
	public int getMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("customerMapper.ydcMaxNum");
		return maxNum;
		
	}
	
	//입력
	public void insertData(YangdoCommentDTO dto){
		
		sessionTemplate.insert("customerMapper.ydcInsertData",dto);
	}
	
	//공지 한명의 데이터 출력
	public YangdoCommentDTO getReadData(int ydcNum){
		
		YangdoCommentDTO dto = sessionTemplate.selectOne("customerMapper.ydcGetReadData",ydcNum);
		
		return dto;
		
	}
	
	//코멘트 전체데이터
	public List<YangdoCommentDTO> getList(int start, int end,int ydNum){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("ydNum", ydNum);
		
		List<YangdoCommentDTO> lists = 
				sessionTemplate.selectList("customerMapper.ydcGetLists",params);
		
		return lists;
			
		}
	
	//코멘트 전체 데이터수 구하기
	public int GetDataCount(int ydNum){
		
		int result = 
				sessionTemplate.selectOne("customerMapper.ydcGetDataCount",ydNum);
		
		return result;
		
	}
		
	//삭제
	public void DeleteData(int ydcNum){
		
		sessionTemplate.delete("customerMapper.ydcDeleteData",ydcNum);
	
	}
	
	//리플 슈발
	public void replyUpdateData(int ydcGroupNum, int ydcOrderNum){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("ydcGroupNum", ydcGroupNum);
		params.put("ydcOrderNum", ydcOrderNum);
	
		sessionTemplate.update("customerMapper.orderNumUpdate",params);
		
	}

}
