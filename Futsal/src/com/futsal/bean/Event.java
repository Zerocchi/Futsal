package com.futsal.bean;

import java.io.Serializable;

public class Event implements Serializable {

	private static final long serialVersionUID = 1L;
	private int eventId;
	private String eventName;
	private String eventType;
	
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
	
}
