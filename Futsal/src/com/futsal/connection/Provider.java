package com.futsal.connection;

public interface Provider {  
	String DRIVER="oracle.jdbc.driver.OracleDriver";  
	String CONNECTION_URL="jdbc:oracle:thin:@localhost:1521:xe";  
	String USERNAME="futsal";  
	String PASSWORD="futsalpass";  
}  