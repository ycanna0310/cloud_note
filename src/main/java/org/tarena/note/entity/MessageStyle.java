package org.tarena.note.entity;

import java.io.Serializable;

public class MessageStyle implements Serializable {
	  private String cn_sender_id;
	  private String cn_accepter_id;
	  private String cn_sender_message;
	  private String cn_sender_name;
	  private String cn_accepter_name;
	  private String  cn_sender_time;
	  private String cn_message_status;
	public String getCn_sender_id() {
		return cn_sender_id;
	}
	public void setCn_sender_id(String cn_sender_id) {
		this.cn_sender_id = cn_sender_id;
	}
	public String getCn_accepter_id() {
		return cn_accepter_id;
	}
	public void setCn_accepter_id(String cn_accepter_id) {
		this.cn_accepter_id = cn_accepter_id;
	}
	public String getCn_sender_message() {
		return cn_sender_message;
	}
	public void setCn_sender_message(String cn_sender_message) {
		this.cn_sender_message = cn_sender_message;
	}
	public String getCn_sender_name() {
		return cn_sender_name;
	}
	public void setCn_sender_name(String cn_sender_name) {
		this.cn_sender_name = cn_sender_name;
	}
	public String getCn_accepter_name() {
		return cn_accepter_name;
	}
	public void setCn_accepter_name(String cn_accepter_name) {
		this.cn_accepter_name = cn_accepter_name;
	}
	public String getCn_sender_time() {
		return cn_sender_time;
	}
	public void setCn_sender_time(String cn_sender_time) {
		this.cn_sender_time = cn_sender_time;
	}
	public String getCn_message_status() {
		return cn_message_status;
	}
	public void setCn_message_status(String cn_message_status) {
		this.cn_message_status = cn_message_status;
	}
	  
}
