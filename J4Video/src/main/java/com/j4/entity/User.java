package com.j4.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
	@Column(unique = true)
	String email;
	String password;
	@Column(name = "full_name")
	String fullName;
	boolean admin;
	boolean active;
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	List<Favorite> favorites;
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	List<Share> shares;
}
