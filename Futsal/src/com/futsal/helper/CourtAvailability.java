package com.futsal.helper;

import java.util.Date;

import com.futsal.dao.CourtDao;

public class CourtAvailability {
	
	private CourtDao courtDAO = new CourtDao();

	public boolean courtAvailable(int court){
    	boolean bookingAvailable = false;
    	boolean eventAvailable = false;
    	
		Date datetime = new Date();
		bookingAvailable = courtDAO.checkCourtAvailabilityBooking(datetime, court);
		eventAvailable = courtDAO.checkCourtAvailabilityEvent(datetime);
		return bookingAvailable && eventAvailable;
	}
	
	public boolean courtAvailable(int court, Date datetime){
    	boolean bookingAvailable = false;
    	boolean eventAvailable = false;
    	
		bookingAvailable = courtDAO.checkCourtAvailabilityBooking(datetime, court);
		eventAvailable = courtDAO.checkCourtAvailabilityEvent(datetime);
		return bookingAvailable && eventAvailable;
	}
	
}
