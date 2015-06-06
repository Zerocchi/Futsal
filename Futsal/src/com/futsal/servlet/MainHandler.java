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
import com.futsal.dao.EventDao;
import com.futsal.helper.CourtAvailability;
import com.futsal.bean.Booking;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet("/Main")
public class MainHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookingDao bookingDAO;
	private EventDao eventDAO;
	private CourtDao courtDAO;
	private CourtAvailability availability;
	private SimpleDateFormat formatter;
    private static String LIST = "/listContent.jsp";
	
    public MainHandler() {
        super();
        bookingDAO = new BookingDao();
        eventDAO = new EventDao();
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
			Date datetime = new Date();
			request.setAttribute("currentbooking", courtDAO.listBookingOnSelectedDate(datetime));
			request.setAttribute("currentevent", courtDAO.listEventOnSelectedDate(datetime));
			request.setAttribute("bookinglist", bookingDAO.getAllBookingFromDate(datetime));
			request.setAttribute("eventlist", eventDAO.getAllEventFromDate(datetime));
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("currentdate", formatter.format(new Date()));
			request.setAttribute("court1", availability.courtAvailable(1));
			request.setAttribute("court2", availability.courtAvailable(2));
			request.setAttribute("datetime", datetime);
		} 		
		
		// forward all attributes to desired page.
		RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
