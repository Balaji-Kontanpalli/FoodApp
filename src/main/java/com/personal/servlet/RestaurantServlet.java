package com.personal.servlet;

import java.io.IOException;
import java.util.List;

import com.project.daoimpl.RestaurantDaoImpl;
import com.project.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/callingRestaurant")
public class RestaurantServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RestaurantDaoImpl restaurantDaoImpl = new RestaurantDaoImpl();

		List<Restaurant> allRestaurants = restaurantDaoImpl.getAllRestaurants();

		req.setAttribute("allRestaurants", allRestaurants);
		
		RequestDispatcher rd = req.getRequestDispatcher("restaurant.jsp");
		
		rd.forward(req, resp);
		
	}
}
