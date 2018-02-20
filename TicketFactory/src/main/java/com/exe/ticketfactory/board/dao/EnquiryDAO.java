package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.EnquiryDTO;

public class EnquiryDAO {
	
	private SqlSessionTemplate sessionTemplate;

	//����������
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}

	//���ǰԽ��� num�ִ밪
	public int getMaxNum(){
		
		int maxNum = 0;
		
		maxNum = sessionTemplate.selectOne("customerMapper.eqMaxNum");
		
		return maxNum;
	}
	//�Է�
	public void insertData(EnquiryDTO dto){
		
		sessionTemplate.insert("customerMapper.eqInsertData",dto);
		
	}
	
	//��ü������
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
	
	//��������͸� ���ڴ�
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
	
	//��ü �����ͼ� ���ϱ�
	public int getDataCount(String searchKey,String searchValue){
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result = 
			sessionTemplate.selectOne("customerMapper.eqGetDataCount",params);
		
		return result;
		
	}
	
	//��� �����ͼ� ���ϱ�
	public int getMemberDataCount(String searchKey,String searchValue,String eqId){
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("eqId", eqId);
		
		int result = 
			sessionTemplate.selectOne("customerMapper.eqGetMemberDataCount",params);
		
		return result;
		
	}

	//�Ѹ��� ������ ���
	public EnquiryDTO getReadData(int eqNum){
		
		EnquiryDTO dto = sessionTemplate.selectOne("customerMapper.eqGetReadData",eqNum);
		
		return dto;
		
	}
	
	//����
	public void deleteData(int eqNum){
		
		sessionTemplate.delete("customerMapper.eqDeleteData",eqNum);
		sessionTemplate.delete("customerMapper.eq_DeleteData",eqNum);
	
	}

}
