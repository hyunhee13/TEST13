package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.NoticeDTO;

public class NoticeDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	//������ ����
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate){
		this.sessionTemplate = sessionTemplate;
	}

	//���� num�ִ밪
	public int getMaxNum(){
		
		int maxNum = 0;
		
		maxNum = sessionTemplate.selectOne("customerMapper.maxNum");
		
		return maxNum;
	}
	
	//���� �Է�(created.jsp->created_ok.jsp)
	public void insertData(NoticeDTO dto){
		
		sessionTemplate.insert("customerMapper.insertData",dto);
		
	}
	
	//���� ��ü������
	public List<NoticeDTO> getList(int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<NoticeDTO> lists = 
				sessionTemplate.selectList("customerMapper.getLists",params);
		
		return lists;
		
	}
		
	//���� ��ü �����ͼ� ���ϱ�
	public int getDataCount(){
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		int result = 
				sessionTemplate.selectOne("customerMapper.getDataCount",params);
		
		return result;
		
	}
	//���� �Ѹ��� ������ ���
	public NoticeDTO getReadData(int notiNum){
		
		NoticeDTO dto = sessionTemplate.selectOne("customerMapper.getReadData",notiNum);
		
		return dto;
		
	}
	
	//���� ����
	public void deleteData(int notiNum){
		
		sessionTemplate.delete("customerMapper.deleteData",notiNum);
	
	}
		
	//���� ����
	public void updateData(NoticeDTO dto){
		
		sessionTemplate.update("customerMapper.updateData",dto);
		
	}

}
