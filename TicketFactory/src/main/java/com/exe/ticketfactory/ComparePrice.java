package com.exe.ticketfactory;

import java.util.Comparator;

import com.exe.ticketfactory.dto.ShowDTO;

public class ComparePrice implements Comparator<ShowDTO>{
	
	@Override
	public int compare(ShowDTO dto1, ShowDTO dto2) {
		int firstP = dto1.getPriceForCompare();
		int secondP = dto2.getPriceForCompare();
		
		if(firstP > secondP){
			return 1;
		}else if( firstP < secondP ){
			return -1;
		}else{
			return 0;
		}
	}

}
