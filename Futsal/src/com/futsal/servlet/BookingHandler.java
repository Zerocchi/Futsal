package com.futsal.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.futsal.dao.BookingDao;
import com.futsal.dao.CourtDao;
import com.futsal.helper.CourtAvailability;
import com.futsal.bean.Booking;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/Booking")
public class BookingHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookingDao bookingDAO;
	private CourtDao courtDAO;
	private CourtAvailability availability;
	private SimpleDateFormat formatter;
	private static String INSERT_OR_EDIT = "/bookpanel.jsp";
    private static String LIST = "/listBooking.jsp";
    private static String AVAILABILITY = "/checkavailability.jsp";
	
    public BookingHandler() {
        super();
        bookingDAO = new BookingDao();
        courtDAO = new CourtDao();
        availability = new CourtAvailability();
        formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String forward = "";
		String action = request.getParameter("action"); // get action parameter from previous page (?action="")
		
		// if there is no session available, link user back to login page.
		HttpSession session = request.getSession();
		if (session == null)
		{
		    String address = "login.jsp";
		    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
		    dispatcher.forward(request,response);
		} 
		
		// list of actions
		if(action.equalsIgnoreCase("list")) { // booking list
			forward = LIST; // this will act as a view page for booking list
			request.setAttribute("bookinglist", bookingDAO.getAllBooking());
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("currentdate", formatter.format(new Date()));
		} else if(action.equalsIgnoreCase("add")) { // add booking
			forward = INSERT_OR_EDIT;
			request.setAttribute("courtlist", courtDAO.getCourtList());
		} else if(action.equalsIgnoreCase("delete")) { // delete booking
			int bookingid = Integer.parseInt(request.getParameter("bookingid"));
			bookingDAO.deleteBookingById(bookingid);
			forward = LIST;
			request.setAttribute("bookinglist", bookingDAO.getAllBooking());
			request.setAttribute("courtlist", courtDAO.getCourtList());
		} else if(action.equalsIgnoreCase("update")){ // update booking
			forward = INSERT_OR_EDIT;
			int bookingid = Integer.parseInt(request.getParameter("bookingid"));
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("bookinfo", bookingDAO.getBookingById(bookingid));
		} else if(action.equalsIgnoreCase("check")){
			forward = LIST;
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("bookinglist", bookingDAO.getAllBooking());
			request.setAttribute("currentdate", formatter.format(new Date()));
			
			// get court availability
			formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			Date datetime = null;
			int court = 0;
			
			try {
				datetime = formatter.parse(request.getParameter("datetime"));
				court = Integer.parseInt(request.getParameter("court"));
				boolean isAvailable = availability.courtAvailable(court, datetime);
				request.setAttribute("status", isAvailable);
				request.setAttribute("datetime", datetime);
				request.setAttribute("court", court);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
			
		// forward all attributes to desired page.
		RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Booking booking = new Booking();
		
		try {
			booking.setBookName(request.getParameter("name"));
			booking.setBookStart(formatter.parse(request.getParameter("start")));
			booking.setBookEnd(formatter.parse(request.getParameter("end")));
			booking.setBookCourtId(Integer.parseInt(request.getParameter("court")));
		} catch (ParseException e){
			e.printStackTrace();
		}
		
		String bookid = request.getParameter("bookid");
		if(bookid == null || bookid.isEmpty())
			bookingDAO.newBooking(booking);
		else{
			booking.setBookId(Integer.parseInt(bookid));
			bookingDAO.updateBooking(booking);
		}
		
		// redirect to list page.
		response.sendRedirect(request.getContextPath() + "/booking.jsp");
	}

}
