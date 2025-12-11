package com.codegnan.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codegnan.service.AiService;

import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/api/ai")
public class AiController {
private final AiService aiService;
public AiController(AiService aiService){this.aiService = aiService;}


@PostMapping("/improve")
public Mono<ResponseEntity<?>> improve(@RequestBody Map<String,String> body){
String text = body.getOrDefault("text", "");
return aiService.improveText(text).map(r -> ResponseEntity.ok(r));
}
}