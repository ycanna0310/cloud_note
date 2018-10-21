package org.tarena.note.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tarena.note.entity.NoteResult;
import org.tarena.note.service.UserService;
import org.tarena.note.util.ImageUtil;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/toRegister.do")
	public String toRegister(String todo) {
		return todo;
	}
	
	@RequestMapping("/login.do")
	@ResponseBody
	public NoteResult execute(String name,String password,HttpSession session){
		
		NoteResult u=userService.checkLogin(name, password, session);
		
		return u;
	}
	
	@RequestMapping("/regist.do")
	@ResponseBody
	public NoteResult registexecute(String name,String password,String nickname){
		NoteResult result = 
			userService.registUser(
			name, password, nickname);
		return result;
	}
	
	@RequestMapping("/checkPassword.do")
	  @ResponseBody
	  public NoteResult checkexecute(String userId,String password){
		  //System.out.println(userId+"-----"+password);
		  NoteResult result=userService.checkPassword(userId,password);
		  return result;
	  }
	
	@RequestMapping("/updatepassword.do")
	 @ResponseBody
	 public NoteResult updateexecute(String userId,String newpassword){
		 NoteResult result=userService.updatapassword(userId, newpassword);
		 return result;
	 }
	
	@RequestMapping("/captcha.do")
	   @ResponseBody
	   public NoteResult execute(HttpServletRequest request,HttpServletResponse response) throws IOException{
		   NoteResult result=new NoteResult();
		   Object[] obj=ImageUtil.createImage();
		   BufferedImage ob=(BufferedImage) obj[1];
		   //System.out.println(ob.getClass());
		   System.out.println(obj[0]);
		 //设置页面不缓存
		   response.setHeader("Pragma", "No-cache");  
	       response.setHeader("Cache-Control", "no-cache");  
	       response.setDateHeader("Expires", 0);  
	     //设置图片格式
	       response.setContentType("image/jpeg");


	       //将结果存入session中
	       HttpSession session=request.getSession();
	       session.setAttribute("result", obj[0]);
	       
	       result.setStatus(0);
	       
	     //获得输出流
	       ServletOutputStream out=response.getOutputStream();
	       ImageIO.write(ob,"JPEG",out);
	       
	       return result;
	       
	   }
	
	@RequestMapping("/checkCaptch.do")
	  @ResponseBody
	  public NoteResult execute(HttpServletRequest request,String captcha){
		  String checkResult=(String) request.getSession().getAttribute("result");
		  System.out.println("用户输入的是："+captcha);
		  System.out.println("正确结果是："+checkResult);
		  captcha=captcha.toUpperCase();
		  NoteResult result=new NoteResult();
		  if(captcha.equals(checkResult)){
			  result.setStatus(0);
			  result.setMsg("验证通过");
			  return result;
		  }else{
			  //1表示验证错误
			  result.setStatus(1);
			  result.setMsg("验证错误");
			  return result;
		  }
		  
	  }
	

}
