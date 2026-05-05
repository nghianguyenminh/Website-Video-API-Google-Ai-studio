package com.j4.DAO;

import java.util.List;
import com.j4.entity.Category;
import com.j4.util.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class CategoryDAO {
    
    public static int insert(Category category) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(category);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        } finally { em.close(); }
    }

    public static int update(Category category) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(category);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        } finally { em.close(); }
    }

    public static int delete(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            Category category = em.find(Category.class, id);
            if(category != null) {
                em.remove(category);
                em.getTransaction().commit();
                return 1;
            }
            return 0;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        } finally { em.close(); }
    }

    public static List<Category> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            // Thêm "LEFT JOIN FETCH c.videos" để ép Hibernate lấy luôn video trong 1 lần kết nối
            // Thêm "DISTINCT" để tránh bị trùng lặp dòng do phép nhân bản ghi khi Join
            String jpql = "SELECT DISTINCT c FROM Category c LEFT JOIN FETCH c.videos";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static Category findById(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally { em.close(); }
    }
    
    public static List<Category> findByKeyword(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
        	String jpql = "SELECT DISTINCT c FROM Category c LEFT JOIN FETCH c.videos WHERE c.name LIKE :key OR c.code LIKE :key";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("key", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
 // Hàm này trả về List các mảng Object. Ví dụ: ["Tiên Hiệp", 10], ["Kiếm Hiệp", 5]
 public static List<Object[]> getCategoryStats() {
     EntityManager em = XJPA.getEntityManager();
     try {
         // Kỹ thuật Join và Group By trong JPQL
         String jpql = "SELECT c.name, COUNT(v) FROM Category c " +
                       "LEFT JOIN c.videos v " +
                       "GROUP BY c.id, c.name";
         jakarta.persistence.Query query = em.createQuery(jpql);
         return query.getResultList();
     } finally {
         em.close();
     }
 }
    
}