package com.j4.DAO;


import java.util.ArrayList;
import java.util.List;

import com.j4.entity.User;
import com.j4.entity.Video;
import com.j4.util.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserDAO {
	static EntityManager entityManager = XJPA.getEntityManager();
	public static int insert(User user) {
		try {
			entityManager.getTransaction().begin();
			entityManager.persist(user);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) { 
			entityManager.getTransaction().rollback();
			return 0;
		}
	}
	
	public static int updadte(User user) {
		try {
			entityManager.getTransaction().begin();
			entityManager.merge(user);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) { 
			entityManager.getTransaction().rollback();
			return 0;
		}
	}
	
	public static int delete(Integer id) {
		try {
			User user = entityManager.find(User.class, id);
			entityManager.getTransaction().begin();
			entityManager.remove(user);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) { 
			entityManager.getTransaction().rollback();
			return 0;
		}
	}
	
	public static User findById(Integer id) {
		return entityManager.find(User.class, id);
		
	}
	
	public static User findByEmail(String email) {
		User user = null;
		try {
			String jpql = "select u from User u where u.email = :email";
			TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
			query.setParameter("email", email);
			user = query.getSingleResult();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return user;
	}
	
	public static List<User> findAll() {
		try {
			String jpql = "select u from User u";
			TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
			 return query.getResultList();
		} catch (Exception e) { 
			return null;
		}
		
	}
	
	public static List<User> findByKeyword(String keyword) {
	    EntityManager em = XJPA.getEntityManager();
	    try {
	        String jpql = "SELECT u FROM User u WHERE u.fullName LIKE :key OR u.email LIKE :key";
	        TypedQuery<User> query = em.createQuery(jpql, User.class);
	        query.setParameter("key", "%" + keyword + "%");
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}
	
	public static long count() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery("SELECT count(u) FROM User u", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
	
	
	
}
