package com.j4.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.*;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "content", columnDefinition = "nvarchar(500)")
    private String content;

    @Column(name = "comment_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date commentDate = new Date(); 

   
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

   
    @ManyToOne
    @JoinColumn(name = "video_id")
    private Video video;
}