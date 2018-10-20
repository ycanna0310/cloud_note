package org.tarena.note.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.tarena.note.dao.NoteBookDao;
import org.tarena.note.dao.NoteDao;
import org.tarena.note.entity.Note;
import org.tarena.note.entity.NoteBook;
import org.tarena.note.entity.NoteResult;
import org.tarena.note.service.NoteBookService;
import org.tarena.note.util.NoteUtil;

@Service
public class NoteBookServiceImpl implements NoteBookService {
	@Autowired
	private NoteBookDao noteBookDao;
	@Autowired
	private NoteDao noteDao;
	
	public NoteResult findByUserId(String userId){
		NoteResult result = new NoteResult();
		List<NoteBook> data = noteBookDao.findByUserId(userId);
		result.setData(data);
		result.setStatus(0);
		return result;
	}

	public NoteResult save(String userId,String bookName) {
		NoteBook book = new NoteBook();
		book.setCn_user_id(userId);
		book.setCn_notebook_name(bookName);
		book.setCn_notebook_createtime(new Timestamp(new Date().getTime()));
		book.setCn_notebook_id(NoteUtil.createId());
		book.setCn_notebook_type_id("5");
		
		NoteResult result = new NoteResult();
		int row = noteBookDao.save(book);
		if(row > 0) {
			result.setStatus(0);
			result.setMsg("笔记本添加成功");
			
		}else {
			System.out.println("笔记本添加失败");
			throw new RuntimeException("笔记本添加失败"); 
		}
		return result;
	}

	public NoteResult findByBookId(String bookId) {
		List<Note> books = noteDao.findByBookId(bookId);
		NoteResult result = new NoteResult();
		result.setData(books);
		result.setStatus(0);
		result.setMsg("查询笔记成功");
		return result;
	}
}
