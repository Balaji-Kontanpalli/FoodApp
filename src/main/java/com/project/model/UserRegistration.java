package com.project.model;

public class UserRegistration {
	private String name;	
	private String email;
	private int age;
	private String address;
	private String password;
	
	public UserRegistration() {}

	public UserRegistration(String name, String email, int age, String address, String password) {
		super();
		this.name = name;
		this.email = email;
		this.age = age;
		this.address = address;
		this.password = password;
	}
	
	
	public UserRegistration(String name, String password) {
		super();
		this.name = name;
		this.password = password;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	
	
}
