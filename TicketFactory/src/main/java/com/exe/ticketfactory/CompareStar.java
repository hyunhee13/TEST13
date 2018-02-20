package com.exe.ticketfactory;

import java.util.Comparator;

import com.exe.ticketfactory.dto.ShowDTO;

public class CompareStar implements Comparator<ShowDTO>{
	
	@Override
	public int compare(ShowDTO dto1, ShowDTO dto2) {
		int firstS = dto1.getAvgStar();
		int secondS = dto2.getAvgStar();
		
		if(firstS > secondS){
			return -1;
		}else if( firstS < secondS ){
			return 1;
		}else{
			return 0;
		}
	}
	
	

}
