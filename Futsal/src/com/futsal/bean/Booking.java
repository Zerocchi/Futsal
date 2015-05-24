package com.futsal.bean;

import java.io.Serializable;
import java.util.Date;

public class Booking implements Serializable {

	private static final long serialVersionUID = 1L;
	private int bookId;
	private String bookName;
	private Date bookStart;
	private Date bookEnd;
	private String bookCourt;
	
	public Booking() {}
	
	public int getBookId() {
		return bookId;
	}
	
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	
	public String getBookName() {
		return bookName;
	}
	
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public Date getBookStart() {
		return bookStart;
	}

	public void setBookStart(Date bookStart) {
		this.bookStart = bookStart;
	}

	public Date getBookEnd() {
		return bookEnd;
	}

	public void setBookEnd(Date bookEnd) {
		this.bookEnd = bookEnd;
	}

	public String getBookCourt() {
		return bookCourt;	
	}
	
	public void setBookCourt(String court) {
		this.bookCourt = court;
		
	}
	
	
}
