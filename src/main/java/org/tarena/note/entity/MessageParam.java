package org.tarena.note.entity;

import java.io.Serializable;

public class MessageParam implements Serializable {
  private String myUserId;
  private String tofriendId;
  private String friendId;
  private String friendToMeId;
public String getMyUserId() {
	return myUserId;
}
public void setMyUserId(String myUserId) {
	this.myUserId = myUserId;
}
public String getTofriendId() {
	return tofriendId;
}
public void setTofriendId(String tofriendId) {
	this.tofriendId = tofriendId;
}
public String getFriendId() {
	return friendId;
}
public void setFriendId(String friendId) {
	this.friendId = friendId;
}
public String getFriendToMeId() {
	return friendToMeId;
}
public void setFriendToMeId(String friendToMeId) {
	this.friendToMeId = friendToMeId;
}
  
}
