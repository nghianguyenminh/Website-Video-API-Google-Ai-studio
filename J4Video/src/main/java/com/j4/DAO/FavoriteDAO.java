package com.j4.DAO;

import java.util.ArrayList;
import java.util.List;

import com.j4.entity.Favorite;
import com.j4.util.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class FavoriteDAO {
	static EntityManager entityManager = XJPA.getEntityManager();
	public static int insert(Favorite favorite) {
		try {
			entityManager.getTransaction().begin();
			entityManager.persist(favorite);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) { 
			entityManager.getTransaction().rollback();
			return 0;
		}
	}
	
	public static List<Favorite> findByUser(Integer userId) {
		List<Favorite> rs = new ArrayList<Favorite>();
		try {
			String jqpl = "select f from Favorite f where f.user.id = :userId";
			TypedQuery<Favorite> query = entityManager.createQuery(jqpl, Favorite.class);
			query.setParameter("userId", userId);
			rs = query.getResultList();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return rs;
	}
	
	public static Favorite findByUserAndVideo(Integer userId, Integer videoId) {
	    try {
	        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId AND f.video.id = :videoId";
	        TypedQuery<Favorite> query = entityManager.createQuery(jpql, Favorite.class);
	        query.setParameter("userId", userId);
	        query.setParameter("videoId", videoId);
	        
	        return query.getSingleResult(); // Trả về đối tượng nếu tìm thấy
	    } catch (Exception e) {
	        return null; // Trả về null nếu không tìm thấy (chưa like)
	    }
	}
	
	public static int updadte(Favorite favorite) {
		try {
			entityManager.getTransaction().begin();
			entityManager.merge(favorite);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) { 
			entityManager.getTransaction().rollback();
			return 0;
		}
	}
	
	public static int delete(Integer id) {
		try {
			Favorite favorite = entityManager.find(Favorite.class, id);
			entityManager.getTransaction().begin();
			entityManager.remove(favorite);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) { 
			entityManager.getTransaction().rollback();
			return 0;
		}
	}
	
	
	// Thêm vào file: src/main/java/com/j4/DAO/FavoriteDAO.java
	public static long countLikesByVideoId(Integer videoId) {
	    EntityManager em = XJPA.getEntityManager();
	    try {
	        String jpql = "SELECT COUNT(f) FROM Favorite f WHERE f.video.id = :vid";
	        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
	        query.setParameter("vid", videoId);
	        return query.getSingleResult();
	    } catch (Exception e) {
	        return 0;
	    } finally {
	        em.close();
	    }
	}
	
}
