package com.codegnan.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import reactor.core.publisher.Mono;

@Service
public class AiService {

	private final WebClient webClient;

	public AiService(@Value("${openai.api.key}") String apiKey) {
		this.webClient = WebClient.builder().baseUrl("https://api.openai.com/v1")
				.defaultHeader("Authorization", "Bearer " + apiKey).build();
	}

    public Mono<Map> improveText(String text){
    	String prompt = "Improve and summarize the following note and suggest a short title:" + text;
Map<String,Object> body = Map.of(
"model", "gpt-3.5-turbo",
"messages", List.of(Map.of("role","user","content", prompt)),
"max_tokens", 200
);


return webClient.post()
.uri("/chat/completions")
.bodyValue(body)
.retrieve()
.bodyToMono(Map.class);
}
}