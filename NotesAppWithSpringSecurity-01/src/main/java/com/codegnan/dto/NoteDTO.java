package com.codegnan.dto;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class NoteDTO {
	
	private Long id;
	@NotBlank
	@Size(min = 1, max = 200)
	private String title;


	@NotBlank
	@Size(min = 1, max = 2000)
	private String content;


	private LocalDateTime createdAt;

}