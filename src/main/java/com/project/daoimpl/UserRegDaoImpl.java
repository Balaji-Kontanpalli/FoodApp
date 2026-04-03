package com.project.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.project.dao.UserRegistrationDao;
import com.project.model.UserRegistration;

public class UserRegDaoImpl implements UserRegistrationDao {

	private static final String URL = "jdbc:mysql://localhost:3306/jee_register";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "Balaji@2003";
	private static final String SELECT = "SELECT name,password from register WHERE NAME = ? AND PASSWORD = ?;";

	@Override
	public int getUser(UserRegistration user) {
		ResultSet res ;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

			PreparedStatement pstmt = conn.prepareStatement(SELECT);
			
			pstmt.setString(1,user.getName());
			pstmt.setString(2, user.getPassword());

			res = pstmt.executeQuery();
			if(res.next()) {
				return 1;
			}else {
				return 0;
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
	}
}
