package com.codegnan.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.codegnan.model.Note;
import com.codegnan.repository.NoteRepository;

@Controller
public class PageController {
	
	public PageController(NoteRepository noteRepository) {
		super();
		this.noteRepository = noteRepository;
	}

	private final NoteRepository noteRepository;
    @GetMapping("/login")
    public String loginPage() {
        return "login";  // maps to /WEB-INF/view/login.jsp
    }

    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }
    
    @GetMapping("/")
    public String home() {
        return "index";   // loads /WEB-INF/views/index.jsp
    }
    
    @GetMapping("/notes")
    public String notesPage() {
        return "notes"; // if you have notes.jsp
    }
    
    @GetMapping("/notes/add-note")
    public String addNotePage() {
        return "add-note"; // resolves to /WEB-INF/view/add-note.jsp
    }
    
    @GetMapping("/notes/edit/{id}")
    public String editNotePage(@PathVariable Long id, Model model) {

        Note note = noteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Note not found"));

        model.addAttribute("note", note);
        return "edit-note"; 
    }


    @GetMapping("/notes/delete/{id}")
    public String deleteNote(@PathVariable Long id) {
        noteRepository.deleteById(id);
        return "redirect:/notes";
    }

    @GetMapping("/notes/ai/{id}")
    public String aiImprovePage(@PathVariable Long id, Model model) {
        model.addAttribute("noteId", id);
        return "ai-improve"; // page for AI improvement
    }
   
}
