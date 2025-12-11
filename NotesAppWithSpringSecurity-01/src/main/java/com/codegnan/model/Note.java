package com.codegnan.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class Note {
@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
private String title;
@Column(length = 2000)
private String content;
private LocalDateTime createdAt = LocalDateTime.now();
@ManyToOne(fetch = FetchType.LAZY)
private User user;

}