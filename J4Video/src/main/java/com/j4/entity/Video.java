package com.j4.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table (name = "videos")
public class Video {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
	String title;
	String youtube_id;
	String description;
	String poster;
	int view_count;
	boolean active;
	@Column(name = "schedule")
	private String schedule;
	
    @ManyToOne 
    @JoinColumn(name = "category_id")
    Category category;
    // ---------------------
	
	@OneToMany(mappedBy = "video") 
	List<Favorite> favorites;
	@OneToMany(mappedBy = "video", fetch = FetchType.LAZY)
	List<Share> shares;
}
