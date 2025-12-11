package com.codegnan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class NotesAppWithSpringSecurityApplication {

	public static void main(String[] args) {
		SpringApplication.run(NotesAppWithSpringSecurityApplication.class, args);
		System.out.println("Started");
	}

}
