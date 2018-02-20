package com.exe.ticketfactory.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.ticketfactory.board.dto.FaqDTO;

public class FaqDAO {
	
	private SqlSessionTemplate sessionTemplate;
	
	//������ ����
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate){
		this.sessionTemplate = sessionTemplate;
	}
	
	//num�ִ밪
	public int getMaxNum(){
		
		int maxFaqNum = 0;
		
		maxFaqNum = sessionTemplate.selectOne("customerMapper.faqMaxNum");
		
		return maxFaqNum;
	}
	//�Է�
	public void insertData(FaqDTO dto){
			
		sessionTemplate.insert("customerMapper.faqInsertData",dto);
			
	}
	//���� ��ü������
	public List<FaqDTO> fgetList(int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<FaqDTO> lists = 
				sessionTemplate.selectList("customerMapper.faqGetLists",params);
		
		return lists;
		
	}
	
	//���� hitCount���� 3�� ����Ʈ �̱�
	public List<FaqDTO> fgetHitCountList(){
		
		List<FaqDTO> fhlists =
				sessionTemplate.selectList("customerMapper.faqGetHitCountList");
		
		return fhlists;
		
	}
			
	//���� ��ü �����ͼ� ���ϱ�
	public int faqGetDataCount(){
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		int result = 
				sessionTemplate.selectOne("customerMapper.faqGetDataCount",params);
		
		return result;
		
	}
	//���� �Ѹ��� ������ ���
	public FaqDTO getReadData(int faqNum){
		
		FaqDTO dto = sessionTemplate.selectOne("customerMapper.faqGetReadData",faqNum);
		
		return dto;
		
	}
			
	//����
	public void faqDeleteData(int faqNum){
		
		sessionTemplate.delete("customerMapper.faqDeleteData",faqNum);
	
	}
			
	//����
	public void updateData(FaqDTO dto){
		
		sessionTemplate.update("customerMapper.faqUpdateData",dto);
		
	}
	
	//��ȸ������
	public void faqUpdateHitCount(int faqNum){
		
		sessionTemplate.update("customerMapper.faqUpdateHitCount",faqNum);
	
	}

}
