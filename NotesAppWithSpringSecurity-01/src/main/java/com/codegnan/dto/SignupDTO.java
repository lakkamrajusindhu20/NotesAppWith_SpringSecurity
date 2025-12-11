package com.codegnan.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SignupDTO {
	
	@NotBlank
	private String username;
	@NotBlank
	@Size(min = 4)
	private String password;

}