package org.tarena.note.service;

import org.tarena.note.entity.NoteBook;
import org.tarena.note.entity.NoteResult;

public interface NoteBookService {
	public NoteResult findByUserId(String userId);
	public NoteResult save(String userId,String bookName);
	public NoteResult findByBookId(String bookId);
}
