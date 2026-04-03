package com.project.model;

import java.util.HashMap;

public class Cart {

	// key = menuItemId, value = CartItem
	private HashMap<Integer, CartItem> items = new HashMap<>();
	private int restaurantId;

	public Cart(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	// ── Getters ───────────────────────────────────────────────
	public int getRestaurantId() {
		return restaurantId;
	}

	public HashMap<Integer, CartItem> getItems() {
		return items;
	}

	public boolean isEmpty() {
		return items.isEmpty();
	}

	public int getTotalCount() {
		int count = 0;
		for (CartItem item : items.values())
			count += item.getQuantity();
		return count;
	}

	public double getTotalPrice() {
		double total = 0;
		for (CartItem item : items.values())
			total += item.getPrice() * item.getQuantity();
		return total;
	}
}