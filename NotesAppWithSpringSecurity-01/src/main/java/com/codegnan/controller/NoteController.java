package com.codegnan.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codegnan.dto.NoteDTO;
import com.codegnan.service.NoteService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/notes")
public class NoteController {


private final NoteService noteService;


public NoteController(NoteService noteService){this.noteService = noteService;}


@GetMapping
public ResponseEntity<List<NoteDTO>> list(@AuthenticationPrincipal UserDetails ud){
return ResponseEntity.ok(noteService.list(ud.getUsername()));
}


@PostMapping
public ResponseEntity<NoteDTO> create(@Valid @RequestBody NoteDTO dto, @AuthenticationPrincipal UserDetails ud){
return ResponseEntity.ok(noteService.create(dto, ud.getUsername()));
}


@PutMapping("/{id}")
public ResponseEntity<NoteDTO> update(@PathVariable Long id, @Valid @RequestBody NoteDTO dto, @AuthenticationPrincipal UserDetails ud){
return ResponseEntity.ok(noteService.update(id, dto, ud.getUsername()));
}


@DeleteMapping("/{id}")
public ResponseEntity<?> delete(@PathVariable Long id, @AuthenticationPrincipal UserDetails ud){
noteService.delete(id, ud.getUsername());
return ResponseEntity.noContent().build();
}
}