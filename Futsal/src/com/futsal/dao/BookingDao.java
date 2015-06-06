package com.futsal.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import com.futsal.bean.Booking;
import com.futsal.bean.Court;
import com.futsal.connection.ConnectionProvider;
import com.futsal.helper.CheckInterval;

public class BookingDao implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static int STATUS=0;
	private Connection con;
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

	// Get all the bookings plus court from the database
	public List<Booking> getAllBooking() {
		
		if(con == null)
			con = ConnectionProvider.getCon();
		List<Booking> books = new ArrayList<>();
		try {
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery("select b.booking_id as booking_id, b.booking_name as booking_name, "
					+ "to_char(b.booking_start, 'DD/MM/YYYY HH24:MI') as booking_start, to_char(b.booking_end, 'DD/MM/YYYY HH24:MI') "
					+ "as booking_end, c.court_num as court from booking b, courtbooking cb, court c where b.booking_id = cb.booking_id "
					+ "and cb.court_id = c.court_id order by booking_id");
			
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
	
	// Get all the bookings plus court from the database
	public List<Booking> getAllBookingFromDate(Date date) {
			
			if(con == null)
				con = ConnectionProvider.getCon();
			List<Booking> books = new ArrayList<>();
			try {
				PreparedStatement ps = con.prepareStatement("select b.booking_id as booking_id, b.booking_name as booking_name, "
						+ "to_char(b.booking_start, 'DD/MM/YYYY HH24:MI') as booking_start, to_char(b.booking_end, 'DD/MM/YYYY HH24:MI') "
						+ "as booking_end, c.court_num as court from booking b, courtbooking cb, court c where b.booking_id = cb.booking_id "
						+ "and cb.court_id = c.court_id and b.booking_start >= ? order by booking_start");
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
	
	// get booking details by ID
	public Booking getBookingById(int id) {
		
		if(con == null)
			con = ConnectionProvider.getCon();
		Booking booking = new Booking();
		try {
			PreparedStatement ps = con.prepareStatement("select b.booking_id as booking_id, b.booking_name as booking_name, "
					+ "to_char(b.booking_start, 'DD/MM/YYYY HH24:MI') as booking_start, to_char(b.booking_end, 'DD/MM/YYYY HH24:MI') "
					+ "as booking_end, c.court_num as court from booking b, courtbooking cb, court c where b.booking_id = cb.booking_id "
					+ "and cb.court_id = c.court_id and b.booking_id = ?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();
			
			if(rs.next()){
				booking.setBookId(rs.getInt("booking_id"));
				booking.setBookName(rs.getString("booking_name"));
				booking.setBookStart(sdf.parse(rs.getString("booking_start")));
				booking.setBookEnd(sdf.parse(rs.getString("booking_end")));
				booking.setBookCourtId(rs.getInt("court"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return booking;
	}

	// create new booking
	public void newBooking(Booking b) {
		
		try {
			if(con == null)
				con = ConnectionProvider.getCon();
			
			// insert into booking
			PreparedStatement ps=con.prepareStatement("insert into booking (booking_id, booking_name, booking_start, booking_end) "
					+ "values (book_seq.nextval, ?, ?, ?)");  
			ps.setString(1, b.getBookName());
			ps.setTimestamp(2, new java.sql.Timestamp(b.getBookStart().getTime()));
			ps.setTimestamp(3, new java.sql.Timestamp(b.getBookEnd().getTime()));
			              
			ps.executeUpdate();
			
			// get last booking id
			int lastSeqValue = 0;
			Statement stat1 = con.createStatement();
			ResultSet rs1 = stat1.executeQuery("select booking_id from booking order by booking_id desc");
			if(rs1.next()){
				lastSeqValue = rs1.getInt("booking_id");
			}
			
			// insert into courtbooking using last sequence value
			PreparedStatement ps1=con.prepareStatement("insert into courtbooking (courtbooking_id, booking_id, court_id) "
					+ "values (courtbook_seq.nextval, ?, ?)");  
			ps1.setInt(1, lastSeqValue);
			ps1.setInt(2, b.getBookCourtId());
			              
			ps1.executeUpdate();
			
			
		} catch (SQLException e) {
            e.printStackTrace();
        }
	}


	public void updateBooking(Booking b) {
		// TODO Update both booking and courtbooking
		
		try {  
			if(con == null)
				con = ConnectionProvider.getCon();
			
			// Update booking table
			PreparedStatement ps=con.prepareStatement("update booking set booking_name=?, booking_start=?, booking_end=? where booking_id = ?");
			ps.setString(1,b.getBookName());
			ps.setTimestamp(2, new java.sql.Timestamp(b.getBookStart().getTime()));
			ps.setTimestamp(3, new java.sql.Timestamp(b.getBookEnd().getTime()));
			ps.setInt(4, b.getBookId());

			ps.executeUpdate();  
			
			// Update courtbooking
			PreparedStatement ps2=con.prepareStatement("update courtbooking set court_id=? where booking_id=?");
			ps2.setInt(1, b.getBookCourtId());
			ps2.setInt(2, b.getBookId());
			
			ps2.executeUpdate();
			
		}catch(Exception e){
				e.printStackTrace();
		}  
		
		
	}

	public void deleteBookingById(int bookingid) {
		
		// TODO:
		// check if courtbooking using the booking key (avoids integrity-constraint violation)
		// if any, delete that first before deleting booking
		
		if(con == null)
			con = ConnectionProvider.getCon();
		Booking booking = new Booking();
		try {
			PreparedStatement ps = con.prepareStatement("select * from courtbooking where booking_id = ?");
			ps.setInt(1, bookingid);

			ResultSet rs = ps.executeQuery();
			
			if(rs.next()){
				PreparedStatement ps1=con.prepareStatement("delete from courtbooking where booking_id = ?");
				ps1.setInt(1, bookingid);
				              
				ps1.executeUpdate(); 
			}
			
			PreparedStatement ps2=con.prepareStatement("delete from booking where booking_id = ?");
			ps2.setInt(1, bookingid);
			              
			ps2.executeUpdate(); 
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
	}

}
