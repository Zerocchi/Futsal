import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class TestConnection {
public static void main(String[] argv) {
	System.out.println("-------- Oracle JDBC Connection Testing ------");
	String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // xe stand for Oracle XE db name
	String USERNAME = "futsal";
	String PASSWORD = "futsalpass";
	// this is the password you set when you installed XE.
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (ClassNotFoundException e) {
		System.out.println("Where is your Oracle JDBC Driver?");
		e.printStackTrace();
		return;
	}
	System.out.println("Oracle JDBC Driver Registered!");
	Connection connection = null;try {
		//connection = DriverManager.getConnection(
		//"jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM",
		//"1234");
		connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	} catch (SQLException e) {
		System.out.println("Connection Failed! Check output console");
		e.printStackTrace();
		return;
	}
	if (connection != null) {
		System.out.println("You made it, take control your database now!");
	try {
		PreparedStatement pst = connection.prepareStatement("select * from booking");
		ResultSet rs = pst.executeQuery();
		while(rs.next()) {
			System.out.println(rs.getInt("booking_id"));
			System.out.println(rs.getString("booking_name"));
			System.out.println(rs.getDate("booking_date"));
		}
	} catch (Exception e) {
	    System.out.println(e);
	} finally {
	    if (connection != null) {
	        try {
	        	connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        	}
	    	}
		}
	}
  }
}