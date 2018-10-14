package org.tarena.note.dao;

import java.util.List;

import org.tarena.note.entity.User;

public interface UserDao {
	public User findByName(String name);
	public int save(User user);
	User findPassword(String userId);
	int updatapassword(User user);
	List<User> findUsers();
}
