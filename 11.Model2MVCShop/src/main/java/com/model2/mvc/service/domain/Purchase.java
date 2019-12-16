package com.model2.mvc.service.domain;

import java.sql.Date;

public class Purchase {
	
	private String receiverName;
	private String receiverPhone;
	private String dlvyDate;
	private Date orderDate;
	private int tranNo;  //PrimaryKey
	private Product purchaseProd;
	private User buyer;
	private String paymentOption;
	private String addr;
	private String tranCode;
	private String dlvyRequest;

	public Purchase() {
		// TODO Auto-generated constructor stub
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}

	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}

	public String getDlvyDate() {
		return dlvyDate;
	}

	public void setDlvyDate(String dlvyDate) {
		this.dlvyDate = dlvyDate;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getTranNo() {
		return tranNo;
	}

	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public Product getPurchaseProd() {
		return purchaseProd;
	}

	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}

	public User getBuyer() {
		return buyer;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public String getPaymentOption() {
		return paymentOption;
	}

	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getTranCode() {
		return tranCode;
	}

	public void setTranCode(String tranCode) {
		this.tranCode = tranCode;
	}

	public String getDlvyRequest() {
		return dlvyRequest;
	}

	public void setDlvyRequest(String dlvyRequest) {
		this.dlvyRequest = dlvyRequest;
	}

	@Override
	public String toString() {
		return "Purchase [receiverName=" + receiverName + ", receiverPhone=" + receiverPhone + ", dlvyDate=" + dlvyDate
				+ ", orderDate=" + orderDate + ", tranNo=" + tranNo + ", purchaseProd=" + purchaseProd + ", buyer="
				+ buyer + ", paymentOption=" + paymentOption + ", addr=" + addr + ", tranCode=" + tranCode
				+ ", dlvyRequest=" + dlvyRequest + "]";
	}

	
}
