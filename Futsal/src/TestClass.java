import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestClass {
	
	public static void main(String[] args){
		String d1 = "21/05/2015 21:00";
	    String d2 = "22/05/2015 01:00";
	    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
	    String dToTest = "22/05/2015 01:00";
	    boolean isSplit = false, isWithin = false;

	    Date dt1 = null, dt2 = null,  dt3 = null;

	    try {
			dt1 = sdf.parse(d1);
			dt2 = sdf.parse(d2);
		    dt3 = sdf.parse(dToTest);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    

	    isSplit = (dt2.compareTo(dt1) < 0);

	    if (isSplit)
	    {
	        isWithin = ((dt3.after(dt1) || dt3.equals(dt1)) || (dt3.before(dt2) || dt3.equals(dt2)));
	    }
	    else
	    {
	        isWithin = ((dt3.after(dt1) || dt3.equals(dt1)) && (dt3.before(dt2) || dt3.equals(dt2)));
	    }

	    System.out.println("Is time within interval? " +isWithin);
	}
}