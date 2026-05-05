package com.j4.DAO;

import com.j4.entity.Comment;
import com.j4.util.XJPA;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class CommentDAO {

    public static void insert(Comment comment) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(comment);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public static List<Comment> findByVideoId(Integer videoId) {
        EntityManager em = XJPA.getEntityManager();
        try {
           
            String jpql = "SELECT c FROM Comment c JOIN FETCH c.user WHERE c.video.id = :vid ORDER BY c.commentDate DESC";
            
            TypedQuery<Comment> query = em.createQuery(jpql, Comment.class);
            query.setParameter("vid", videoId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}