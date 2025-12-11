package com.codegnan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.codegnan.dto.NoteDTO;
import com.codegnan.repository.NoteRepository;
import com.codegnan.repository.UserRepository;
import com.codegnan.model.Note;
import com.codegnan.model.User;

@Service
public class NoteService {
private final NoteRepository noteRepository;
private final UserRepository userRepository;


public NoteService(NoteRepository nr, UserRepository ur){this.noteRepository = nr; this.userRepository = ur;}


private NoteDTO toDto(Note n){
NoteDTO d = new NoteDTO();
d.setId(n.getId()); d.setTitle(n.getTitle()); d.setContent(n.getContent()); d.setCreatedAt(n.getCreatedAt());
return d;
}


public NoteDTO create(NoteDTO dto, String username){
User u = userRepository.findByUsername(username).orElseThrow();
Note n = new Note(); n.setTitle(dto.getTitle()); n.setContent(dto.getContent()); n.setUser(u);
return toDto(noteRepository.save(n));
}


public List<NoteDTO> list(String username){
User u = userRepository.findByUsername(username).orElseThrow();
List<Note> list = noteRepository.findByUser(u);
List<NoteDTO> out = new ArrayList<>(); for(Note n: list) out.add(toDto(n));
return out;
}


public NoteDTO update(Long id, NoteDTO dto, String username){
User u = userRepository.findByUsername(username).orElseThrow();
Note n = noteRepository.findById(id).orElseThrow();
if(!n.getUser().getId().equals(u.getId())) throw new SecurityException("Not allowed");
n.setTitle(dto.getTitle()); n.setContent(dto.getContent());
return toDto(noteRepository.save(n));
}


public void delete(Long id, String username){
User u = userRepository.findByUsername(username).orElseThrow();
Note n = noteRepository.findById(id).orElseThrow();
if(!n.getUser().getId().equals(u.getId())) throw new SecurityException("Not allowed");
noteRepository.delete(n);
}
}