package com.exe.ticketfactory.board.dao;
import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.EventDTO;


public class EventDAO {
	
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}
	
	public int getMaxNum(){
		
		int maxEbNum = 0;
		maxEbNum = sessionTemplate.selectOne("customerMapper.ebMaxNum");
		
		return maxEbNum;
		
	}
	
	public void insertData(EventDTO dto){
		
		sessionTemplate.insert("customerMapper.ebInsertData",dto);
		
	}
	
	public List<EventDTO> getList(int start,int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<EventDTO> lists =
				sessionTemplate.selectList("customerMapper.ebGetLists",params);
		
		return lists;
		
	}
	
	public List<EventDTO> hitCountList(){
		
		List<EventDTO> lists =
				sessionTemplate.selectList("customerMapper.ebGetHitCountList");
		
		return lists;
		
	}
	
	public int getDataCount(){
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		int result = 
				sessionTemplate.selectOne("customerMapper.ebGetDataCount",params);
		
		return result;
		
	}
	
	//���� �Ѹ��� ������ ���
	public EventDTO getReadData(int ebNum){
		
		EventDTO dto = sessionTemplate.selectOne("customerMapper.ebGetReadData",ebNum);
		
		return dto;
		
	}
	//����
	public void updateData(EventDTO dto){
		
		sessionTemplate.update("customerMapper.ebUpdateData",dto);
		
	}
	
	//�̹��� ����
	
	
	
	//����
	public void deleteData(int ebNum){
		
		sessionTemplate.delete("customerMapper.ebDeleteData",ebNum);
	
	}
	//��ȸ������
	public void updateHitCount(int ebNum){
		
		sessionTemplate.update("customerMapper.ebUpdateHitCount",ebNum);
	
	}
	
	
	//���ϻ���
	public void fileDeleteData(String fileName, String path)
		throws Exception{
		
		File file = null;
		String fullFileName = path + File.separator + fileName;
		file = new java.io.File(fullFileName);
		if(file.exists())
			file.delete();
		
		
	}
	

}
