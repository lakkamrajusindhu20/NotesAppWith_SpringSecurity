
package com.codegnan.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codegnan.dto.LoginDTO;
import com.codegnan.dto.SignupDTO;
import com.codegnan.model.User;
import com.codegnan.security.JwtUtil;
import com.codegnan.service.AuthService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {


private final AuthService authService;
private final AuthenticationManager authenticationManager;
private final JwtUtil jwtUtil;


public AuthController(AuthService authService, AuthenticationManager authenticationManager, JwtUtil jwtUtil){
this.authService = authService; this.authenticationManager = authenticationManager; this.jwtUtil = jwtUtil;
}


@PostMapping("/signup")
public ResponseEntity<?> signup(@Valid @RequestBody SignupDTO dto){
User u = authService.register(dto);
return ResponseEntity.ok(Map.of("username", u.getUsername()));
}


@PostMapping("/login")
public ResponseEntity<?> login(@Valid @RequestBody LoginDTO dto){
authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(dto.getUsername(), dto.getPassword()));
String token = jwtUtil.generateToken(dto.getUsername());
return ResponseEntity.ok(Map.of("token", token));
}
}
