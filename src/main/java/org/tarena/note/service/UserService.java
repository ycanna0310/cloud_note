package org.tarena.note.service;

import javax.servlet.http.HttpSession;

import org.tarena.note.entity.NoteResult;

public interface UserService {
	
	/**
	 * 检查是否存在
	 * @param name
	 * @param password
	 * @return
	 */
	public NoteResult checkLogin(String name,String password,HttpSession session);
	/**
	 * 注册用户
	 * @param name
	 * @param password
	 * @param nickname
	 * @return
	 */
	public NoteResult registUser(String name,String password,String nickname);
	/**
	 * 检查密码
	 * @param userId
	 * @param password
	 * @return
	 */
	NoteResult checkPassword(String userId,String password);
	/**
	 * 更改密码
	 * @param userId
	 * @param newpassword
	 * @return
	 */
	NoteResult updatapassword(String userId,String newpassword);
	
}
