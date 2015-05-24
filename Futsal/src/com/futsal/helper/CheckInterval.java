package com.futsal.helper;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 
 * @author zerocchi
 *
 * This helper class will check if Date object is within the interval of two Date period.
 * Taken and modified from http://stackoverflow.com/a/3299578/2783365
 * 
 */

public class CheckInterval {
	
	public static boolean check(Date start, Date end, Date test){
	    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
	    boolean isSplit = false, isWithin = false;

	    Date dt1 = null, dt2 = null,  dt3 = null;

	    try {
			dt1 = sdf.parse(sdf.format(start));
			dt2 = sdf.parse(sdf.format(end));
		    dt3 = sdf.parse(sdf.format(test));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    

	    isSplit = (dt2.compareTo(dt1) < 0);

	    // "or equals" will make it unavailable exactly on the time a court is booked (e.g. 9.00 ~ 11.00 inclusive)
	    // Remove "or equals" if want to make it less strict on timing (e.g. 9.00 and 11.00 excluded)
	    if (isSplit)
	    {
	        isWithin = ((dt3.after(dt1) || dt3.equals(dt1)) || (dt3.before(dt2) || dt3.equals(dt2)));
	    }
	    else
	    {
	        isWithin = ((dt3.after(dt1) || dt3.equals(dt1)) && (dt3.before(dt2) || dt3.equals(dt2)));
	    }

	    return isWithin;
	}
}