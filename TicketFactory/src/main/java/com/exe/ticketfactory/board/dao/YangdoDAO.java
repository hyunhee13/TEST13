package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.YangdoDTO;

public class YangdoDAO {
	
	private SqlSessionTemplate sessionTemplate;

	//����������
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}

	//�Ƴ�
	public int getMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("customerMapper.ydMaxNum");
		return maxNum;
		
	}
	
	//�Է�
	public void insertData(YangdoDTO dto){
		
		sessionTemplate.insert("customerMapper.ydInsertData",dto);
		
	}
		
	//��ü������
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
	
	//��ü �����ͼ� ���ϱ�
	public int getDataCount(String searchKey,String searchValue){
			
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result = 
			sessionTemplate.selectOne("customerMapper.ydGetDataCount",params);
		
		return result;
		
	}
	
	//�Ѹ��� ������ ���
	public YangdoDTO getReadData(int ydNum){
		
		YangdoDTO dto = sessionTemplate.selectOne("customerMapper.ydGetReadData",ydNum);
		
		return dto;
		
	}
	
	//����
	public void updateData(YangdoDTO dto){
		
		sessionTemplate.update("customerMapper.ydUpdateData",dto);
		
	}

	//����
	public void deleteData(int ydNum){
		
		sessionTemplate.delete("customerMapper.ydDeleteData",ydNum);
		sessionTemplate.delete("customerMapper.ydDeleteAllData",ydNum);
		
	
	}
	
	//��ȸ������
	public void updateHitCount(int ydNum){
		
		sessionTemplate.update("customerMapper.ydUpdateHitCount",ydNum);
	
	}
}
