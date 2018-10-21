package org.tarena.note.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tarena.note.entity.NoteBook;
import org.tarena.note.entity.NoteResult;
import org.tarena.note.entity.User;
import org.tarena.note.service.NoteBookService;

@Controller
@RequestMapping("/notebook")
public class NoteBookController {
	@Autowired
	private NoteBookService noteBookService;
	
	@RequestMapping("/loadbooks.do")
	@ResponseBody
	public  NoteResult findByUserId(HttpSession session){
		User user = (User)session.getAttribute("user");
		return noteBookService.findByUserId(user.getCn_user_id());
	}
	
	@RequestMapping("/add.do")
	@ResponseBody
	public NoteResult save(String bookName,HttpSession session) {
		User user = (User)session.getAttribute("user");
		String userId = user.getCn_user_id();
		return noteBookService.save(userId,bookName);
	}
	
	@RequestMapping(value="/loadnotes.do",method=RequestMethod.GET)
	@ResponseBody
	public NoteResult findByBookId(String bookId) {
		return noteBookService.findByBookId(bookId);
	}
	
}
