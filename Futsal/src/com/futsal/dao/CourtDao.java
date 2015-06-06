package com.futsal.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.futsal.bean.Booking;
import com.futsal.bean.Court;
import com.futsal.bean.Event;
import com.futsal.connection.ConnectionProvider;
import com.futsal.helper.CheckInterval;

public class CourtDao implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Connection con;
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

	public List<Court> getCourtList() {
		
		if(con == null)
			con = ConnectionProvider.getCon();
		List<Court> courts = new ArrayList<>();
		try {
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery("select distinct * from court");
			
			while(rs.next()){
				Court court = new Court();
				court.setCourtId(rs.getInt("court_id"));
				court.setCourtNum(rs.getInt("court_num"));
				courts.add(court);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return courts;
		
	}
	
	public boolean checkCourtAvailabilityBooking(Date dateCheck, int courtId){
		
		// return boolean value if the selected court is available
		
		boolean isAvailable = true;
		
		if(con == null)
			con = ConnectionProvider.getCon();
		try {
			PreparedStatement ps = con.prepareStatement("select to_char(b.booking_start, 'DD/MM/YYYY HH24:MI') as"
					+ " booking_start, to_char(b.booking_end, 'DD/MM/YYYY HH24:MI') as booking_end, "
					+ "co.court_num as court from booking b, courtbooking cb, court co where b.booking_id = cb.booking_id "
					+ "and cb.court_id = co.court_id and co.court_id = ?");
			ps.setInt(1, courtId);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next() && isAvailable){
				Date start = sdf.parse(rs.getString("booking_start"));
				Date end = sdf.parse(rs.getString("booking_end"));
				if(CheckInterval.check(start, end, dateCheck)){
					isAvailable = false;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return isAvailable;
	}
	
	public boolean checkCourtAvailabilityEvent(Date dateCheck){
		
		// return boolean value if the selected court is available
		
		boolean isAvailable = true;
		
		if(con == null)
			con = ConnectionProvider.getCon();
		try {
			PreparedStatement ps = con.prepareStatement("select to_char(e.event_start, 'DD/MM/YYYY HH24:MI') as"
					+ " event_start, to_char(e.event_end, 'DD/MM/YYYY HH24:MI') as event_end, "
					+ "co.court_num as court from event e, eventbooking eb, court co where e.event_id = eb.event_id "
					+ "and eb.court_id = co.court_id");
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next() && isAvailable){
				Date start = sdf.parse(rs.getString("event_start"));
				Date end = sdf.parse(rs.getString("event_end"));
				if(CheckInterval.check(start, end, dateCheck)){
					isAvailable = false;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return isAvailable;
	}
	
	public List<Booking> listBookingOnSelectedDate(Date date){
		
		if(con == null)
			con = ConnectionProvider.getCon();
		List<Booking> books = new ArrayList<>();
		try {
			PreparedStatement ps = con.prepareStatement("select b.booking_id as booking_id, "
					+ "b.booking_name as booking_name, to_char(b.booking_start, 'DD/MM/YYYY HH24:MI') "
					+ "as booking_start, to_char(b.booking_end, 'DD/MM/YYYY HH24:MI') as booking_end, "
					+ "c.court_num as court from booking b, courtbooking cb, court c where "
					+ "b.booking_id = cb.booking_id and cb.court_id = c.court_id and ? "
					+ "between b.booking_start and b.booking_end order by booking_id");
			ps.setTimestamp(1, new java.sql.Timestamp(date.getTime()));
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				Booking booking = new Booking();
				booking.setBookId(rs.getInt("booking_id"));
				booking.setBookName(rs.getString("booking_name"));
				booking.setBookStart(sdf.parse(rs.getString("booking_start")));
				booking.setBookEnd(sdf.parse(rs.getString("booking_end")));
				booking.setBookCourtId(rs.getInt("court"));
				books.add(booking);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return books;
		
	}
	
	public List<Event> listEventOnSelectedDate(Date date){
		
		if(con == null)
			con = ConnectionProvider.getCon();
		List<Event> events = new ArrayList<>();
		try {
			PreparedStatement ps = con.prepareStatement("select distinct e.event_id as event_id, "
					+ "e.event_name as event_name, to_char(e.event_start, 'DD/MM/YYYY HH24:MI') "
					+ "as event_start, to_char(e.event_end, 'DD/MM/YYYY HH24:MI') as event_end "
					+ "from event e, eventbooking eb, court c where "
					+ "e.event_id = eb.event_id and eb.court_id = c.court_id and ? "
					+ "between e.event_start and e.event_end order by event_id");
			ps.setTimestamp(1, new java.sql.Timestamp(date.getTime()));
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				Event event = new Event();
				event.setEventId(rs.getInt("event_id"));
				event.setEventName(rs.getString("event_name"));
				event.setEventStart(sdf.parse(rs.getString("event_start")));
				event.setEventEnd(sdf.parse(rs.getString("event_end")));
				events.add(event);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return events;
		
	}
	
}
