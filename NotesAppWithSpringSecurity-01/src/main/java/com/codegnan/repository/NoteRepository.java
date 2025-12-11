package com.codegnan.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.codegnan.model.Note;
import com.codegnan.model.User;



public interface NoteRepository extends JpaRepository<Note, Long> {
List<Note> findByUser(User user);
}