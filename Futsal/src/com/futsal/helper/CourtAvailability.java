package com.futsal.helper;

import java.util.Date;

import com.futsal.dao.CourtDao;

public class CourtAvailability {
	
	private CourtDao courtDAO = new CourtDao();

	public boolean courtAvailable(int court){
    	boolean bookingAvailable = false;
    	boolean eventAvailable = false;
    	
		Date datetime = new Date();
		
		if(courtDAO.listBookingOnDate(datetime, court).isEmpty()){
			bookingAvailable = true;
		} if(courtDAO.listEventOnDate(datetime).isEmpty()){
			eventAvailable = true;
		}

		return bookingAvailable && eventAvailable;
	}
	
	public boolean courtAvailable(int court, Date datetime){
    	boolean bookingAvailable = false;
    	boolean eventAvailable = false;
    	
    	if(courtDAO.listBookingOnDate(datetime, court).isEmpty()){
			bookingAvailable = true;
		} if(courtDAO.listEventOnDate(datetime).isEmpty()){
			eventAvailable = true;
		}
		return bookingAvailable && eventAvailable;
	}
	
	public boolean courtAvailable(int court, Date start, Date end){
		boolean bookingAvailable = false;
    	boolean eventAvailable = false;
    	
    	if(courtDAO.listBookingOnDate(start, end, court).isEmpty()){
			bookingAvailable = true;
		} if(courtDAO.listEventOnDate(start, end).isEmpty()){
			eventAvailable = true;
		}
		return bookingAvailable && eventAvailable;
	}
}
