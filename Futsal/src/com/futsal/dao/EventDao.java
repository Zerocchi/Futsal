package com.futsal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

public class EventDao {

	private static int STATUS=0;
	private Connection con;
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

	// Get all the events plus court from the database
	public List<Event> getAllEvent() {
		
		if(con == null)
			con = ConnectionProvider.getCon();
		List<Event> events = new ArrayList<>();
		try {
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery("select distinct eb.event_id as event_id, e.event_name as event_name, e.event_type, "
					+ "to_char(e.event_start, 'DD/MM/YYYY HH24:MI') as event_start, to_char(e.event_end, 'DD/MM/YYYY HH24:MI') "
					+ "as event_end from event e, eventbooking eb where e.event_id = eb.event_id order by event_id");
			
			while(rs.next()){
				Event event = new Event();
				event.setEventId(rs.getInt("event_id"));
				event.setEventName(rs.getString("event_name"));
				event.setEventType(rs.getString("event_type"));
				event.setEventStart(sdf.parse(rs.getString("event_start")));
				event.setEventEnd(sdf.parse(rs.getString("event_end")));
				events.add(event);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return events;
	}
	
	public List<Event> getAllEventFromDate(Date date) {
		
		if(con == null)
			con = ConnectionProvider.getCon();
		List<Event> events = new ArrayList<>();
		try {
			PreparedStatement ps = con.prepareStatement("select e.event_id as event_id, e.event_name as event_name, "
					+ "to_char(e.event_start, 'DD/MM/YYYY HH24:MI') as event_start, to_char(e.event_end, 'DD/MM/YYYY HH24:MI') "
					+ "as event_end, c.court_num as court from event e, eventbooking eb, court c where e.event_id = eb.event_id "
					+ "and eb.court_id = c.court_id and e.event_start >= ? order by event_id");
			ps.setTimestamp(1, new java.sql.Timestamp(date.getTime()));
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				Event event = new Event();
				event.setEventId(rs.getInt("event_id"));
				event.setEventName(rs.getString("event_name"));
				event.setEventStart(sdf.parse(rs.getString("event_start")));
				event.setEventEnd(sdf.parse(rs.getString("event_end")));
				event.setEventCourtId(rs.getInt("court"));
				events.add(event);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return events;
	}
	
	// get event details by ID
	public Event getEventById(int id) {
		
		if(con == null)
			con = ConnectionProvider.getCon();
		Event event = new Event();
		try {
			PreparedStatement ps = con.prepareStatement("select e.event_id as event_id, e.event_name as event_name, event_type, "
					+ "to_char(e.event_start, 'DD/MM/YYYY HH24:MI') as event_start, "
					+ "to_char(e.event_end, 'DD/MM/YYYY HH24:MI') as event_end, c.court_num as court from event e, "
					+ "eventbooking eb, court c where e.event_id = eb.event_id and eb.court_id = c.court_id and "
					+ "e.event_id = ?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();
			
			if(rs.next()){
				event.setEventId(rs.getInt("event_id"));
				event.setEventName(rs.getString("event_name"));
				event.setEventType(rs.getString("event_type"));
				event.setEventStart(sdf.parse(rs.getString("event_start")));
				event.setEventEnd(sdf.parse(rs.getString("event_end")));
				event.setEventCourtId(rs.getInt("court"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return event;
	}

	// create new event
	public void newEvent(Event e) {
		
		try {
			if(con == null)
				con = ConnectionProvider.getCon();
			
			// insert into event
			PreparedStatement ps=con.prepareStatement("insert into event (event_id, event_name, event_type, event_start, event_end) "
					+ "values (eventseq.nextval, ?, ?, ?, ?)");  
			ps.setString(1, e.getEventName());
			ps.setString(2, e.getEventType());
			ps.setTimestamp(3, new java.sql.Timestamp(e.getEventStart().getTime()));
			ps.setTimestamp(4, new java.sql.Timestamp(e.getEventEnd().getTime()));
			              
			ps.executeUpdate();
			
			// get last event id
			int lastSeqValue = 0;
			Statement stat1 = con.createStatement();
			ResultSet rs1 = stat1.executeQuery("select event_id from event order by event_id desc");
			if(rs1.next()){
				lastSeqValue = rs1.getInt("event_id");
			}
			
			// insert into eventbooking using last sequence value for every court available
			CourtDao courtDAO = new CourtDao();
			for(Court court: courtDAO.getCourtList()){
				PreparedStatement ps1=con.prepareStatement("insert into eventbooking (eventbooking_id, event_id, court_id) "
						+ "values (eventbookseq.nextval, ?, ?)");  
				ps1.setInt(1, lastSeqValue);
				ps1.setInt(2, court.getCourtId());
				              
				ps1.executeUpdate();
			}
			
		} catch (SQLException err) {
            err.printStackTrace();
        }
	}


	public void updateEvent(Event e) {
		
		try {  
			if(con == null)
				con = ConnectionProvider.getCon();
			
			// Update event table
			PreparedStatement ps=con.prepareStatement("update event set event_name=?, event_type=?, event_start=?, event_end=? where event_id = ?");
			ps.setString(1,e.getEventName());
			ps.setString(2, e.getEventType());
			ps.setTimestamp(3, new java.sql.Timestamp(e.getEventStart().getTime()));
			ps.setTimestamp(4, new java.sql.Timestamp(e.getEventEnd().getTime()));
			ps.setInt(5, e.getEventId());

			ps.executeUpdate();  
			
		}catch(Exception err){
				err.printStackTrace();
		}  
		
		
	}

	public void deleteBookingById(int eventid) {
		
		// TODO:
		// check if eventbooking using the event key (avoids integrity-constraint violation)
		// if any, delete that first before deleting booking
		
		if(con == null)
			con = ConnectionProvider.getCon();
		Booking booking = new Booking();
		try {
			PreparedStatement ps = con.prepareStatement("select * from eventbooking where event_id = ?");
			ps.setInt(1, eventid);

			ResultSet rs = ps.executeQuery();
			
			if(rs.next()){
				PreparedStatement ps1=con.prepareStatement("delete from eventbooking where event_id = ?");
				ps1.setInt(1, eventid);
				              
				ps1.executeUpdate(); 
			}
			
			PreparedStatement ps2=con.prepareStatement("delete from event where event_id = ?");
			ps2.setInt(1, eventid);
			              
			ps2.executeUpdate(); 
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public boolean checkCourtAvailability(Date dateCheck, int courtId){
		
		// return boolean value if the selected court is available
		
		boolean isAvailable = true;
		
		if(con == null)
			con = ConnectionProvider.getCon();
		try {
			PreparedStatement ps = con.prepareStatement("select to_char(e.event_start, 'DD/MM/YYYY HH24:MI') as"
					+ " event_start, to_char(e.event_end, 'DD/MM/YYYY HH24:MI') as event_end, "
					+ "co.court_num as court from event e, eventbooking eb, court co where e.event_id = eb.event_id "
					+ "and eb.court_id = co.court_id and co.court_id = ?");
			ps.setInt(1, courtId);
			
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
}
