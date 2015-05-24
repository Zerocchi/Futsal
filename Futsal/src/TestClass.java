import java.util.List;

import com.futsal.bean.Booking;
import com.futsal.dao.BookingDao;

public class TestClass {
	
	public static void main(String[] args){
		
		BookingDao book = new BookingDao();
		List<Booking> books = ((BookingDao)book).getAllBooking();
		System.out.println(books.get(0).getBookName());
	}
	
}
