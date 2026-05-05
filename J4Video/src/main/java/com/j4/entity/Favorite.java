package com.j4.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "favorites", uniqueConstraints = {
	    @UniqueConstraint(columnNames = {"user_id", "video_id"})
	})
public class Favorite {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
	@ManyToOne @JoinColumn(name = "user_id")
	User user;
	@ManyToOne @JoinColumn(name = "video_id")
	Video video;
	@Column(name = "like_date")
	@Temporal(TemporalType.DATE) // phai khai bao dong nay de convert sang sql der sql co the hieu
	Date likeDate;
	
}
