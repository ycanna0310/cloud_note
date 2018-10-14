package org.tarena.note.dao;

import java.util.List;

import org.tarena.note.entity.Share;

public interface ShareDao {
	public int deleteByNoteId(String noteId);
	public Share findByNoteId(String noteId);
	public int save(Share share);
	List<Share> searchByTitle(String title);
	Share searchByShareId(String noteId);
}
