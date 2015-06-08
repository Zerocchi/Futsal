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
import com.futsal.bean.Event;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/Event")
public class EventHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EventDao eventDAO;
	private CourtDao courtDAO;
	private CourtAvailability availability;
	private SimpleDateFormat formatter;
	private static String INSERT_OR_EDIT = "/eventpanel.jsp";
    private static String LIST = "/listEvent.jsp";
    private static String AVAILABILITY = "/available.jsp";
	
    public EventHandler() {
        super();
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
			request.setAttribute("eventlist", eventDAO.getAllEvent());
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("currentdate", formatter.format(new Date()));
		} else if(action.equalsIgnoreCase("add")) { // add event
			forward = INSERT_OR_EDIT;
			request.setAttribute("courtlist", courtDAO.getCourtList());
		} else if(action.equalsIgnoreCase("delete")) { // delete event
			int eventid = Integer.parseInt(request.getParameter("eventid"));
			eventDAO.deleteBookingById(eventid);
			forward = LIST;
			request.setAttribute("eventlist", eventDAO.getAllEvent());
			request.setAttribute("courtlist", courtDAO.getCourtList());
		} else if(action.equalsIgnoreCase("update")){ // update event
			forward = INSERT_OR_EDIT;
			int eventid = Integer.parseInt(request.getParameter("eventid"));
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("eventinfo", eventDAO.getEventById(eventid));
		} else if(action.equalsIgnoreCase("check")){
			forward = LIST;
			request.setAttribute("courtlist", courtDAO.getCourtList());
			request.setAttribute("eventlist", eventDAO.getAllEvent());
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
		} else if(action.equalsIgnoreCase("checkboth")){
			formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			Date start = null;
			Date end = null;
			int court = 0;
			
			try {
				forward = AVAILABILITY;
				start = formatter.parse(request.getParameter("start"));
				end = formatter.parse(request.getParameter("end"));
				request.setAttribute("booking", courtDAO.listBookingOnDate(start, end));
				request.setAttribute("event", courtDAO.listEventOnDate(start, end));
				request.setAttribute("start", start);
				request.setAttribute("end", end);
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
		Event event = new Event();
		
		try {
			event.setEventName(request.getParameter("name"));
			event.setEventStart(formatter.parse(request.getParameter("start")));
			event.setEventEnd(formatter.parse(request.getParameter("end")));
		} catch (ParseException e){
			e.printStackTrace();
		}
		
		String eventid = request.getParameter("eventid");
		if(eventid == null || eventid.isEmpty())
			eventDAO.newEvent(event);
		else{
			event.setEventId(Integer.parseInt(eventid));
			eventDAO.updateEvent(event);
		}
		
		// redirect to list page.
		response.sendRedirect(request.getContextPath() + "/event.jsp");
	}

}
