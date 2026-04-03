package com.project.dao;

import com.project.model.User;

public interface UserDao {

    // Login — returns User if found, null if not
    User login(String username, String password);
    
    
    User getUserByUsername(String username);


    // Signup — returns 1 if inserted, 0 if failed
    int signup(User user);

    // Check if username already exists
    boolean usernameExists(String username);

    // Check if email already exists
    boolean emailExists(String email);

    // Update last login date
    void updateLastLogin(int userID);
}