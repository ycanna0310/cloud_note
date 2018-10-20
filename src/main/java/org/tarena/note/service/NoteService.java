package org.tarena.note.service;

import org.tarena.note.entity.NoteResult;

public interface NoteService {
	NoteResult save(String userId,String bookId,String noteTitle);
	NoteResult findById(String noteId);
	NoteResult update(String noteId,String noteTitle,String noteBody);
}
