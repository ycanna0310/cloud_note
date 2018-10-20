package org.tarena.note.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tarena.note.entity.NoteResult;
import org.tarena.note.service.NoteService;

@Controller
@RequestMapping("/note")
public class NoteController {
	@Autowired
	private NoteService noteService;
	
	@RequestMapping("/add.do")
	@ResponseBody
	public  NoteResult save(String userId, String bookId, String noteTitle){
		return noteService.save(userId,bookId,noteTitle);
	}
	
	@RequestMapping(value="/load.do",method=RequestMethod.GET)
	@ResponseBody
	public  NoteResult save(String noteId){
		return noteService.findById(noteId);
	}
	
	@RequestMapping("/update.do")
	@ResponseBody
	public  NoteResult update(String noteId, String noteTitle, String noteBody){
		return noteService.update(noteId,noteTitle,noteBody);
	}

	
}
