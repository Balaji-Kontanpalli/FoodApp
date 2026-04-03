package com.project.model;

public class Restaurant {

    private int id;
    private String name;
    private String category;      // e.g. Desserts, Asian, Grill
    private String location;      // e.g. Marathahalli, Bangalore
    private double rating;        // e.g. 4.4
    private int priceForTwo;      // e.g. 500
    private double distanceKm;    // e.g. 3.6
    private String offer;         // e.g. Flat 35% off on pre-booking
    private String imageUrl;      // path or URL to restaurant image

    // ─── Constructors ───────────────────────────────────────────
    public Restaurant() {}

    public Restaurant(int id, String name, String category, String location,
                      double rating, int priceForTwo, double distanceKm,
                      String offer, String imageUrl) {
        this.id          = id;
        this.name        = name;
        this.category    = category;
        this.location    = location;
        this.rating      = rating;
        this.priceForTwo = priceForTwo;
        this.distanceKm  = distanceKm;
        this.offer       = offer;
        this.imageUrl    = imageUrl;
    }

    // ─── Getters & Setters ───────────────────────────────────────
    public int getId()                     { return id; }
    public void setId(int id)              { this.id = id; }

    public String getName()                { return name; }
    public void setName(String name)       { this.name = name; }

    public String getCategory()            { return category; }
    public void setCategory(String cat)    { this.category = cat; }

    public String getLocation()            { return location; }
    public void setLocation(String loc)    { this.location = loc; }

    public double getRating()              { return rating; }
    public void setRating(double rating)   { this.rating = rating; }

    public int getPriceForTwo()            { return priceForTwo; }
    public void setPriceForTwo(int price)  { this.priceForTwo = price; }

    public double getDistanceKm()          { return distanceKm; }
    public void setDistanceKm(double d)    { this.distanceKm = d; }

    public String getOffer()               { return offer; }
    public void setOffer(String offer)     { this.offer = offer; }

    public String getImageUrl()            { return imageUrl; }
    public void setImageUrl(String url)    { this.imageUrl = url; }

    @Override
    public String toString() {
        return "Restaurant [id=" + id + ", name=" + name + ", category=" + category
                + ", location=" + location + ", rating=" + rating
                + ", priceForTwo=" + priceForTwo + ", distanceKm=" + distanceKm
                + ", offer=" + offer + "]";
    }
}