package com.futsal.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.futsal.dao.SessionDao;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
        
        String n=request.getParameter("username");  
        String p=request.getParameter("password"); 
        
        if(SessionDao.validate(n, p)){  
        	HttpSession session = request.getSession(false);
            if(session!=null)
            	session.setAttribute("user", n); // set session attribute of user name
    		response.sendRedirect("dashboard.jsp");
        } else {  
        	response.sendRedirect("loginerror.jsp"); 
        }  

	}

}
