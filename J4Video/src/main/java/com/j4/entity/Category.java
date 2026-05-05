package com.j4.entity;

import java.util.List;
import jakarta.persistence.*;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "categories")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;
    
    String name;
    String code; 
    
    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
    List<Video> videos;
}