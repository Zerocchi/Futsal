package com.futsal.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.futsal.dao.BookingDao;
import com.futsal.helper.CheckInterval;

/**
 * Servlet implementation class CheckServlet
 */
@WebServlet("/Check")
public class CheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String RESULT = "availablenotice.jsp";
	private BookingDao bookingDAO;
	private SimpleDateFormat formatter;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckServlet() {
        super();
        bookingDAO = new BookingDao();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Date datetime = null;
		int court = 0;
		
		try {
			datetime = formatter.parse(request.getParameter("datetime"));
			court = Integer.parseInt(request.getParameter("court"));
			boolean isAvailable = bookingDAO.checkCourtAvailability(datetime, court);
			request.setAttribute("status", isAvailable);
			request.setAttribute("datetime", datetime);
			request.setAttribute("court", court);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher view = request.getRequestDispatcher(RESULT);
        view.forward(request, response);
	}

}
