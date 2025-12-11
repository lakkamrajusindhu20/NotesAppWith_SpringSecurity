package com.codegnan.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.codegnan.dto.SignupDTO;
import com.codegnan.repository.UserRepository;
import com.codegnan.model.User;

@Service
public class AuthService {
private final UserRepository userRepository;
private final PasswordEncoder passwordEncoder;


public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder){
this.userRepository = userRepository;
this.passwordEncoder = passwordEncoder;
}


public User register(SignupDTO dto){
if(userRepository.findByUsername(dto.getUsername()).isPresent()){
throw new IllegalArgumentException("Username taken");
}
User u = new User();
u.setUsername(dto.getUsername());
u.setPassword(passwordEncoder.encode(dto.getPassword()));
return userRepository.save(u);
}
}