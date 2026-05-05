package com.j4.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJPA {
	static EntityManagerFactory factory = Persistence.createEntityManagerFactory("J4Video");
	public static EntityManager getEntityManager() {
		return factory.createEntityManager();
		
	}
	
}
