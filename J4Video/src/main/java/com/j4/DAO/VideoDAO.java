package com.j4.DAO;

import java.util.ArrayList;
import java.util.List;

import com.j4.entity.Video;
import com.j4.util.XJPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class VideoDAO {
// 	static EntityManager entityManager = XJPA.getEntityManager();
//	public static int insert(Video video) {
//		try {
//			entityManager.getTransaction().begin();
//			entityManager.persist(video);
//			entityManager.getTransaction().commit();
//			return 1;
//		} catch (Exception e) { 
//			entityManager.getTransaction().rollback();
//			return 0;
//		}
//	}
//	
//	public static int updadte(Video video) {
//		try {
//			entityManager.getTransaction().begin();
//			entityManager.merge(video);
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
//			Video video = entityManager.find(Video.class, id);
//			entityManager.getTransaction().begin();
//			entityManager.remove(video);
//			entityManager.getTransaction().commit();
//			return 1;
//		} catch (Exception e) { 
//			entityManager.getTransaction().rollback();
//			return 0;
//		}
//	}
//	
//	public static List<Video> findAll() {
//		List<Video> rs = new ArrayList<Video>();
//		try {
//			String jpql = "select v from Video v";
//			TypedQuery<Video> query = entityManager.createQuery(jpql, Video.class);
//			rs = query.getResultList();
//		} catch (Exception e) { 
//			e.printStackTrace();
//		}
//		return rs;
//	}
//	
//	public static Video findById(Integer id) {
//		try {
//			return entityManager.find(Video.class, id);
//
//		} catch (Exception e) { 
//			return null;
//			
//		}
//	}
//	
//	public static List<Video> findByActive(boolean active) {
//		List<Video> rs = new ArrayList<Video>();
//		try {
//			String jpql = "select v from Video v where v.active = :active";
//			TypedQuery<Video> query = entityManager.createQuery(jpql, Video.class);
//			query.setParameter("active", active);
//			rs = query.getResultList();
//		} catch (Exception e) { 
//			e.printStackTrace();
//		}
//		return rs;
//	}
//	
//	// Thêm vào trong class VideoDAO
//	public static List<Video> findByKeyword(String keyword) {
//	    List<Video> rs = new ArrayList<>();
//	    try {
//	        // Tìm video có tiêu đề chứa từ khóa (LIKE) và đang Active
//	        String jpql = "SELECT v FROM Video v WHERE v.title LIKE :keyword AND v.active = true";
//	        TypedQuery<Video> query = entityManager.createQuery(jpql, Video.class);
//	        query.setParameter("keyword", "%" + keyword + "%");
//	        rs = query.getResultList();
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return rs;
//	}
//	
//	// Thêm vào cuối class VideoDAO
//	public static List<Video> findByCategoryCode(String code) {
//	    List<Video> rs = new ArrayList<>();
//	    EntityManager em = XJPA.getEntityManager();
//	    try {
//	        // Truy vấn video thuộc category có mã code tương ứng và đang Active
//	        String jpql = "SELECT v FROM Video v WHERE v.category.code = :code AND v.active = true";
//	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
//	        query.setParameter("code", code);
//	        rs = query.getResultList();
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    } finally {
//	        em.close();
//	    }
//	    return rs;
//	}
//	
//	// 1. Hàm tăng view (Gọi khi người dùng bấm vào xem)
//	public static void incrementViewCount(Integer id) {
//	    EntityManager em = XJPA.getEntityManager();
//	    try {
//	        em.getTransaction().begin();
//	        // Dùng câu lệnh UPDATE trực tiếp để tăng view trong DB
//	        String jpql = "UPDATE Video v SET v.view_count = v.view_count + 1 WHERE v.id = :id";
//	        jakarta.persistence.Query query = em.createQuery(jpql);
//	        query.setParameter("id", id);
//	        query.executeUpdate();
//	        
//	        em.getTransaction().commit();
//	    } catch (Exception e) {
//	        em.getTransaction().rollback();
//	        e.printStackTrace();
//	    } finally {
//	        em.close();
//	    }
//	}
//
//	// 2. Hàm lấy video ngẫu nhiên cho sidebar (Đề xuất phim)
//	public static List<Video> findRandom(int limit) {
//	    EntityManager em = XJPA.getEntityManager();
//	    try {
//	        // MySQL hỗ trợ ORDER BY RAND()
//	        String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY rand()";
//	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
//	        query.setMaxResults(limit); // Chỉ lấy số lượng nhất định
//	        return query.getResultList();
//	    } finally {
//	        em.close();
//	    }
//	}
//	
//	public static List<Video> findTopViews(int limit) {
//	    EntityManager em = XJPA.getEntityManager();
//	    try {
//	        // Sắp xếp giảm dần theo lượt xem
//	        String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.view_count DESC";
//	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
//	        query.setMaxResults(limit); // Giới hạn số lượng (7)
//	        return query.getResultList();
//	    } finally {
//	        em.close();
//	    }
//	}

	public static int insert(Video video) {
        EntityManager em = XJPA.getEntityManager(); // Tạo mới
        try {
            em.getTransaction().begin();
            em.persist(video);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        } finally {
            em.close(); 
        }
    }

    public static int updadte(Video video) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(video);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        } finally {
            em.close();
        }
    }

    public static int delete(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            Video video = em.find(Video.class, id);
            if (video != null) {
                em.remove(video);
                em.getTransaction().commit();
                return 1;
            }
            return 0;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        } finally {
            em.close();
        }
    }


    public static Video findById(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Video.class, id);
        } catch (Exception e) {
            return null;
        } finally {
            em.close(); // Đóng kết nối để xóa cache
        }
    }

    public static List<Video> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Video> findByActive(boolean active) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.active = :active";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("active", active);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Video> findByKeyword(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.title LIKE :keyword AND v.active = true";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("keyword", "%" + keyword + "%");
            // lay 5 phim dau tien gui cho ai
            query.setMaxResults(5); 
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    public static List<Video> findTop10BestViews() {
        return findTopViews(10);
    }

    public static List<Video> findByCategoryCode(String code) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.category.code = :code AND v.active = true";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("code", code);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

   
    public static void incrementViewCount(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
           
            String jpql = "UPDATE Video v SET v.view_count = v.view_count + 1 WHERE v.id = :id";
            jakarta.persistence.Query query = em.createQuery(jpql);
            query.setParameter("id", id);
            query.executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public static List<Video> findRandom(int limit) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY rand()";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Video> findTopViews(int limit) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.view_count DESC";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    

    public static long getTotalViews() {
        EntityManager em = XJPA.getEntityManager();
        try {
        
            String jpql = "SELECT SUM(v.view_count) FROM Video v";
            jakarta.persistence.Query query = em.createQuery(jpql);
            Long total = (Long) query.getSingleResult();
            return total != null ? total : 0;
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }
    
    // dem phim active
    public static long count() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery("SELECT count(v) FROM Video v WHERE v.active = true", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    

   
    public static List<Video> findTop10MostLiked() {
        EntityManager em = XJPA.getEntityManager();
        try {
            // Đếm số lượng xuất hiện của video trong bảng Favorite
            String jpql = "SELECT f.video FROM Favorite f WHERE f.video.active = true " +
                          "GROUP BY f.video ORDER BY COUNT(f) DESC";
            
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setMaxResults(10);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>(); // Trả về list rỗng nếu lỗi
        } finally {
            em.close();
        }
    }

    public static List<String> getAllMovieTitles() {
        EntityManager em = XJPA.getEntityManager();
        try {
            // Chỉ lấy cột Title của các phim đang Active
            return em.createQuery("SELECT v.title FROM Video v WHERE v.active = true", String.class).getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
	
}
