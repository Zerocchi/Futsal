package com.futsal.bean;

import java.io.Serializable;

public class Court implements Serializable {

	private static final long serialVersionUID = 1L;
	private int courtId;
	private int courtNum;
	
	public Court() {}

	public int getCourtId() {
		return courtId;
	}

	public void setCourtId(int courtId) {
		this.courtId = courtId;
	}

	public int getCourtNum() {
		return courtNum;
	}

	public void setCourtNum(int courtNum) {
		this.courtNum = courtNum;
	}
	
}
