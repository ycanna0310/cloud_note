package org.tarena.note.service.impl;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.tarena.note.dao.UserDao;

import org.tarena.note.entity.NoteResult;
import org.tarena.note.entity.User;
import org.tarena.note.entity.UserFriend;
import org.tarena.note.service.UserService;
import org.tarena.note.util.NoteUtil;




@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;

	public NoteResult checkLogin(
		String name, String password, HttpSession session) {
		
		NoteResult result = new NoteResult();
		User user = userDao.findByName(name);
		if(user == null){
			result.setStatus(1);
			result.setMsg("用户名不存在");
			return result;
		}
		//将用户输入明文加密
		String md5_pwd = NoteUtil.md5(password);
		//比对加密后的密码
		if(user.getCn_user_password().equals(md5_pwd)){
			result.setStatus(0);
			result.setMsg("用户名和密码正确");
			//result.setData(user);//将user对象传出
			session.setAttribute("user", user);
			return result;
		}
		result.setStatus(2);
		result.setMsg("密码不正确");
		return result;
	}

	public NoteResult registUser(
		String name, String password, String nickname) {
		NoteResult result = new NoteResult();
		//用户名是否被占用检测
		User has_user = userDao.findByName(name);
		if(has_user != null){
			result.setStatus(1);
			result.setMsg("用户名已存在");
			return result;
		}
		//添加处理
		User user = new User();
		user.setCn_user_name(name);
		user.setCn_user_desc(nickname);
		String md5_pwd = NoteUtil.md5(password);
		user.setCn_user_password(md5_pwd);
		user.setCn_user_token(null);
		//生成ID主键
		String userId = NoteUtil.createId();
		user.setCn_user_id(userId);
		userDao.save(user);
		
		result.setStatus(0);
		result.setMsg("注册成功");
		return result;
	}

	public NoteResult checkPassword(String userId,String password) {
		NoteResult result=new NoteResult();
		User user = userDao.findPassword(userId);
		//将用户输入明文加密
				String md5_pwd = NoteUtil.md5(password);
				//比对加密后的密码
				if(user.getCn_user_password().equals(md5_pwd)){
					result.setStatus(0);
					result.setMsg("密码正确");
					result.setData(user);//将user对象传出
					return result;
				}
				result.setStatus(1);
				result.setMsg("密码不正确");
				return result;
	}

	public NoteResult updatapassword(String userId, String newpassword) {
		User user=userDao.findPassword(userId);
		//User user=userDao.findPassword(userId);
		user.setCn_user_id(userId);
		String md5_pwd = NoteUtil.md5(newpassword);
		user.setCn_user_password(md5_pwd);
		userDao.updatapassword(user);
		NoteResult result=new NoteResult();
		result.setStatus(0);
		result.setMsg("更改密码成功");
		return result;
	}



}
