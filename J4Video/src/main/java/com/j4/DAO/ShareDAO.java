package com.j4.DAO;

import java.util.ArrayList;
import java.util.List;


import com.j4.entity.Share;
import com.j4.util.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class ShareDAO {
//	static EntityManager entityManager = XJPA.getEntityManager();
//	public static int insert(Share share) {
//		try {
//			entityManager.getTransaction().begin();
//			entityManager.persist(share);
//			entityManager.getTransaction().commit();
//			return 1;
//		} catch (Exception e) { 
//			entityManager.getTransaction().rollback();
//			return 0;
//		}
//	}
//	
//	
//	public static int updadte(Share share) {
//		try {
//			entityManager.getTransaction().begin();
//			entityManager.merge(share);
//			entityManager.getTransaction().commit();
//			return 1;
//		} catch (Exception e) { 
//			entityManager.getTransaction().rollback();
//			return 0;
//		}
//	}
//	
//	public static int delete(Integer id) {
//		try {
//			Share share = entityManager.find(Share.class, id);
//			entityManager.getTransaction().begin();
//			entityManager.remove(share);
//			entityManager.getTransaction().commit();
//			return 1;
//		} catch (Exception e) { 
//			entityManager.getTransaction().rollback();
//			return 0;
//		}
//	}
//	
//	public static List<Share> findAll() {
//		List<Share> rs = new ArrayList<Share>();
//		try {
//			String jpql = "select s from Share s";
//			TypedQuery<Share> query = entityManager.createQuery(jpql, Share.class);
//			rs = query.getResultList();
//		} catch (Exception e) { 
//			e.printStackTrace();
//		}
//		return rs;
//	}
//	
//	public static Share findById(Integer id) {
//		return entityManager.find(Share.class, id);
//		
//	}
	
	
	public static boolean insert(Share share) {
        EntityManager em = XJPA.getEntityManager(); // Tạo mới
        try {
            em.getTransaction().begin();
            em.persist(share);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra để dễ debug
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close(); // Đóng ngay
        }
    }

    public static boolean update(Share share) { // Sửa lỗi chính tả updadte -> update
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(share);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public static boolean delete(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            Share share = em.find(Share.class, id);
            if (share != null) {
                em.remove(share);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public static List<Share> findAll() {
        EntityManager em = XJPA.getEntityManager();
        List<Share> rs = new ArrayList<>();
        try {
            String jpql = "SELECT s FROM Share s";
            TypedQuery<Share> query = em.createQuery(jpql, Share.class);
            rs = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return rs;
    }

    public static Share findById(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Share.class, id);
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
	
}
