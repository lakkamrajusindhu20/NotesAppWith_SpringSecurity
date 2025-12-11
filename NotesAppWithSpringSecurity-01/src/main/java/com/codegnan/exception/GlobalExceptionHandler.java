package com.codegnan.exception;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {


@ExceptionHandler(MethodArgumentNotValidException.class)
public ResponseEntity<?> handleValidation(MethodArgumentNotValidException ex){
Map<String,String> errors = new HashMap<>();
ex.getBindingResult().getFieldErrors().forEach(err -> errors.put(err.getField(), err.getDefaultMessage()));
return ResponseEntity.badRequest().body(errors);
}


@ExceptionHandler(IllegalArgumentException.class)
public ResponseEntity<?> handleBad(IllegalArgumentException ex){
return ResponseEntity.badRequest().body(Map.of("error", ex.getMessage()));
}


@ExceptionHandler(Exception.class)
public ResponseEntity<?> handleAll(Exception ex){
return ResponseEntity.status(500).body(Map.of("error","Internal error"));
}
}