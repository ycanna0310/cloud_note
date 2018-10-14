package org.tarena.note.entity;

import java.io.Serializable;

public class MobilShare implements Serializable {
  private String cn_user_id;
  private String cn_note_id;
  private String cn_note_body;
  private String cn_note_title;
  private String showNowTime;
  private String nickName;
public String getNickName() {
	return nickName;
}
public void setNickName(String nickName) {
	this.nickName = nickName;
}
public String getCn_user_id() {
	return cn_user_id;
}
public void setCn_user_id(String cn_user_id) {
	this.cn_user_id = cn_user_id;
}
public String getCn_note_id() {
	return cn_note_id;
}
public void setCn_note_id(String cn_note_id) {
	this.cn_note_id = cn_note_id;
}
public String getCn_note_body() {
	return cn_note_body;
}
public void setCn_note_body(String cn_note_body) {
	this.cn_note_body = cn_note_body;
}
public String getCn_note_title() {
	return cn_note_title;
}
public void setCn_note_title(String cn_note_title) {
	this.cn_note_title = cn_note_title;
}
public String getShowNowTime() {
	return showNowTime;
}
public void setShowNowTime(String showNowTime) {
	this.showNowTime = showNowTime;
}
@Override
public String toString() {
	return "MobilShare [cn_user_id=" + cn_user_id + ", cn_note_id="
			+ cn_note_id + ", cn_note_body=" + cn_note_body
			+ ", cn_note_title=" + cn_note_title + ", showNowTime="
			+ showNowTime + ", nickName=" + nickName + "]";
}


  
}
