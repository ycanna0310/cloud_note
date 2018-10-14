package org.tarena.note.entity;

import java.io.Serializable;

public class UserFriend implements Serializable {
  private String cn_my_id;
  private String cn_friend_id;
  private String cn_friend_name;
public String getCn_my_id() {
	return cn_my_id;
}
public void setCn_my_id(String cn_my_id) {
	this.cn_my_id = cn_my_id;
}
public String getCn_friend_id() {
	return cn_friend_id;
}
public void setCn_friend_id(String cn_friend_id) {
	this.cn_friend_id = cn_friend_id;
}
public String getCn_friend_name() {
	return cn_friend_name;
}
public void setCn_friend_name(String cn_friend_name) {
	this.cn_friend_name = cn_friend_name;
}
  
}
