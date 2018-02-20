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
	
	//�ڸ�Ʈ num�ִ밪
	public int getMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("customerMapper.ydcMaxNum");
		return maxNum;
		
	}
	
	//�Է�
	public void insertData(YangdoCommentDTO dto){
		
		sessionTemplate.insert("customerMapper.ydcInsertData",dto);
	}
	
	//���� �Ѹ��� ������ ���
	public YangdoCommentDTO getReadData(int ydcNum){
		
		YangdoCommentDTO dto = sessionTemplate.selectOne("customerMapper.ydcGetReadData",ydcNum);
		
		return dto;
		
	}
	
	//�ڸ�Ʈ ��ü������
	public List<YangdoCommentDTO> getList(int start, int end,int ydNum){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("ydNum", ydNum);
		
		List<YangdoCommentDTO> lists = 
				sessionTemplate.selectList("customerMapper.ydcGetLists",params);
		
		return lists;
			
		}
	
	//�ڸ�Ʈ ��ü �����ͼ� ���ϱ�
	public int GetDataCount(int ydNum){
		
		int result = 
				sessionTemplate.selectOne("customerMapper.ydcGetDataCount",ydNum);
		
		return result;
		
	}
		
	//����
	public void DeleteData(int ydcNum){
		
		sessionTemplate.delete("customerMapper.ydcDeleteData",ydcNum);
	
	}
	
	//���� ����
	public void replyUpdateData(int ydcGroupNum, int ydcOrderNum){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("ydcGroupNum", ydcGroupNum);
		params.put("ydcOrderNum", ydcOrderNum);
	
		sessionTemplate.update("customerMapper.orderNumUpdate",params);
		
	}

}
