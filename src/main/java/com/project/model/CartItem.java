package com.project.model;

public class CartItem {

    private int    id;
    private int    restaurantId;
    private String itemName;
    private double price;
    private int    quantity;

    public CartItem() {}

    public CartItem(int id, int restaurantId,
                    String itemName, double price, int quantity) {
        this.id           = id;
        this.restaurantId = restaurantId;
        this.itemName     = itemName;
        this.price        = price;
        this.quantity     = quantity;
    }

    public int    getId()                      { return id; }
    public void   setId(int id)                { this.id = id; }

    public int    getRestaurantId()            { return restaurantId; }
    public void   setRestaurantId(int rid)     { this.restaurantId = rid; }

    public String getItemName()                { return itemName; }
    public void   setItemName(String name)     { this.itemName = name; }

    public double getPrice()                   { return price; }
    public void   setPrice(double price)       { this.price = price; }

    public int    getQuantity()                { return quantity; }
    public void   setQuantity(int qty)         { this.quantity = qty; }

    public double getSubtotal()                { return price * quantity; }
}