package org.tarena.note.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.tarena.note.dao.NoteDao;
import org.tarena.note.entity.Note;
import org.tarena.note.entity.NoteResult;
import org.tarena.note.service.NoteService;
import org.tarena.note.util.NoteUtil;

@Service
public class NoteServiceImpl implements NoteService {

	@Autowired
	private NoteDao noteDao;
	
	public NoteResult save(String userId, String bookId, String noteTitle) {
		Note note = new Note();
		note.setCn_note_id(NoteUtil.createId());
		note.setCn_notebook_id(bookId);
		note.setCn_user_id(userId);
		note.setCn_note_title(noteTitle);
		note.setCn_note_type_id("1");
		note.setCn_note_status_id("1");
		note.setCn_note_create_time(System.currentTimeMillis());
		note.setCn_note_body("");
		int row = noteDao.save(note);
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setData(note);
		result.setMsg("添加笔记成功");
		return result;
	}

	public NoteResult findById(String noteId) {
		Note note = noteDao.findById(noteId);
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setData(note);
		result.setMsg("查询笔记内容成功");
		return result;
	}

	public NoteResult update(String noteId, String noteTitle, String noteBody) {
		Note note = new Note();
		note.setCn_note_id(noteId);
		note.setCn_note_title(noteTitle);
		note.setCn_note_body(noteBody);
		note.setCn_note_last_modify_time(new Date().getTime());
		noteDao.update(note);
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setData(note);
		result.setMsg("保存笔记内容成功");
		return result;
	}

}
