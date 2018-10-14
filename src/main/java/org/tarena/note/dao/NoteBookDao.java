package org.tarena.note.dao;

import java.util.List;

import org.tarena.note.entity.NoteBook;

public interface NoteBookDao {
	public int updateName(NoteBook book);
	public int save(NoteBook book);
	public List<NoteBook> findByUserId(String userId);
}
