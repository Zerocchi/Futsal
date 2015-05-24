package com.futsal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.futsal.connection.ConnectionProvider;

public class SessionDao {

	public static boolean validate(String name, String pass) {
		boolean status = false;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = ConnectionProvider.getCon();

            pst = conn
                    .prepareStatement("select * from admins where admin_name=? and admin_pass=?"); // change later
            pst.setString(1, name);
            pst.setString(2, pass);

            rs = pst.executeQuery();
            status = rs.next();

        } catch (Exception e) {
            System.out.println(e);
        } 
        return status;
	}
	

}
