package com.futsal.bean;

import java.io.Serializable;
import java.util.Date;

public class Event implements Serializable {

	private static final long serialVersionUID = 1L;
	private int eventId;
	private String eventName;
	private String eventType;
	private Date eventStart;
	private Date eventEnd;
	private int eventCourtId;
	
	public int getEventCourtId() {
		return eventCourtId;
	}

	public void setEventCourtId(int eventCourtId) {
		this.eventCourtId = eventCourtId;
	}

	public int getEventId() {
		return eventId;
	}
	
	public void setEventId(int eventId) {
		this.eventId = eventId;
	}
	
	public String getEventName() {
		return eventName;
	}
	
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	
	public String getEventType() {
		return eventType;
	}
	
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public Date getEventStart() {
		return eventStart;
	}

	public void setEventStart(Date eventStart) {
		this.eventStart = eventStart;
	}

	public Date getEventEnd() {
		return eventEnd;
	}

	public void setEventEnd(Date eventEnd) {
		this.eventEnd = eventEnd;
	}
	
}
