package org.tarena.note.dao;

import java.util.List;

import org.tarena.note.entity.Note;

public interface NoteDao {
	public int recycle(String noteId);
	public int update(Note note);
	public int save(Note note);
	public Note findById(String noteId);
	public List<Note> findByBookId(String bookId);
	List<Note> recycle_list(String userId);
	int delete_note(String noteId);
	int replay_note(String noteId);
	
}
