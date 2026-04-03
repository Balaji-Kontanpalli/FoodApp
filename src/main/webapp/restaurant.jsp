	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	    
	    <%@ page import ="com.project.daoimpl.RestaurantDaoImpl,
	    com.project.model.Restaurant,
	    java.util.List" %>
	    <%@ page import="com.project.model.User" %>
	    <%@ page import="com.project.model.Cart" %>
	    
	    
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<link rel="icon" type="image/x-icon" href="favicon.ico" />
		<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png" />
		<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png" />
		<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png" />
	<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	  <title>FoodApp – Discover. Order. Enjoy.</title>
	   <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%23FF5200'/><text x='50' y='72' font-size='65' font-family='Arial Black' font-weight='900' fill='white' text-anchor='middle'>GB</text></svg>"/>  
	  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet"/>
	  <style>
:root {
	--orange: #FF5200;
	--orange-lt: #FF7A3D;
	--dark: #0D0D0D;
	--dark2: #1A1A1A;
	--dark3: #252525;
	--card-bg: #1E1E1E;
	--text: #F5F5F5;
	--muted: #999;
	--green: #48C774;
	--yellow: #F5C518;
	--white: #FFFFFF;
	--radius: 16px;
	--font-head: 'Syne', sans-serif;
	--font-body: 'DM Sans', sans-serif;
}

*, *::before, *::after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html {
	scroll-behavior: smooth;
}

body {
	background: var(--dark);
	color: var(--text);
	font-family: var(--font-body);
	font-size: 15px;
	line-height: 1.6;
	overflow-x: hidden;
}

a {
	text-decoration: none;
	color: inherit;
}

ul {
	list-style: none;
}

::-webkit-scrollbar {
	width: 6px;
}

::-webkit-scrollbar-track {
	background: var(--dark2);
}

::-webkit-scrollbar-thumb {
	background: var(--orange);
	border-radius: 3px;
}

/* ── NAV ─────────────────────────────────────────────────── */
nav {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 100;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 5%;
	height: 64px;
	background: rgba(13, 13, 13, 0.92);
	backdrop-filter: blur(14px);
	border-bottom: 1px solid rgba(255, 82, 0, 0.12);
}

.nav-logo {
	font-family: var(--font-head);
	font-size: 1.5rem;
	font-weight: 800;
	color: var(--orange);
	letter-spacing: -0.5px;
	flex-shrink: 0;
}

.nav-logo span {
	color: var(--white);
}

.nav-center {
	display: flex;
	align-items: center;
	background: var(--dark2);
	border: 1.5px solid rgba(255, 255, 255, 0.07);
	border-radius: 10px;
	overflow: hidden;
	width: 360px;
	transition: border-color 0.25s;
}

.nav-center:focus-within {
	border-color: var(--orange);
}

.nav-center input {
	flex: 1;
	background: transparent;
	border: none;
	outline: none;
	padding: 10px 16px;
	font-family: var(--font-body);
	font-size: 0.875rem;
	color: var(--text);
}

.nav-center input::placeholder {
	color: #555;
}

.nav-center button {
	background: var(--orange);
	border: none;
	cursor: pointer;
	padding: 0 18px;
	height: 44px;
	color: #fff;
	font-weight: 600;
	font-size: 0.82rem;
	transition: background 0.2s;
}

.nav-center button:hover {
	background: var(--orange-lt);
}

.nav-right-group {
	display: flex;
	align-items: center;
	gap: 24px;
}

.nav-links {
	display: flex;
	gap: 24px;
}

.nav-links a {
	font-size: 0.875rem;
	font-weight: 500;
	color: var(--muted);
	transition: color 0.2s;
}

.nav-links a:hover {
	color: var(--white);
}

.nav-right {
	display: flex;
	gap: 10px;
}

.btn-outline {
	border: 1.5px solid rgba(255, 255, 255, 0.15);
	color: var(--text);
	padding: 8px 20px;
	border-radius: 8px;
	font-family: var(--font-body);
	font-weight: 500;
	font-size: 0.875rem;
	cursor: pointer;
	background: transparent;
	transition: all 0.25s;
}

.btn-outline:hover {
	border-color: var(--orange);
	color: var(--orange);
}

.btn-solid {
	background: var(--orange);
	color: #fff;
	padding: 8px 22px;
	border-radius: 8px;
	font-family: var(--font-body);
	font-weight: 600;
	font-size: 0.875rem;
	cursor: pointer;
	border: none;
	transition: background 0.2s, transform 0.15s;
}

.btn-solid:hover {
	background: var(--orange-lt);
	transform: translateY(-1px);
}

/* ── HERO STRIP ──────────────────────────────────────────── */
.hero-strip {
	margin-top: 64px;
	background: var(--dark2);
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	padding: 28px 5%;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 24px;
	flex-wrap: wrap;
}

.hero-strip-left h1 {
	font-family: var(--font-head);
	font-size: clamp(1.4rem, 2.5vw, 2rem);
	font-weight: 800;
	letter-spacing: -0.5px;
	line-height: 1.2;
}

.hero-strip-left h1 em {
	font-style: normal;
	color: var(--orange);
}

.hero-strip-left p {
	font-size: 0.85rem;
	color: var(--muted);
	margin-top: 4px;
}

.hero-strip-right {
	display: flex;
	gap: 32px;
}

.strip-stat .num {
	font-family: var(--font-head);
	font-size: 1.4rem;
	font-weight: 800;
}

.strip-stat .num span {
	color: var(--orange);
}

.strip-stat .lbl {
	font-size: 0.72rem;
	color: var(--muted);
}

/* ── FILTER BAR ──────────────────────────────────────────── */
.filter-bar {
	padding: 16px 5%;
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: wrap;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	background: var(--dark);
	position: sticky;
	top: 64px;
	z-index: 50;
}

.filter-label {
	font-size: 0.78rem;
	font-weight: 600;
	color: var(--muted);
	margin-right: 4px;
}

.filter-chip {
	background: var(--dark2);
	border: 1.5px solid rgba(255, 255, 255, 0.07);
	color: var(--muted);
	padding: 6px 16px;
	border-radius: 100px;
	font-size: 0.8rem;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap;
}

.filter-chip:hover, .filter-chip.active {
	border-color: var(--orange);
	color: var(--orange);
	background: rgba(255, 82, 0, 0.08);
}

.filter-chip.active {
	font-weight: 700;
}

/* ── RESTAURANT SECTION ──────────────────────────────────── */
.restaurant-section {
	padding: 40px 5% 64px;
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	margin-bottom: 28px;
}

.section-label {
	font-size: 0.72rem;
	font-weight: 700;
	color: var(--orange);
	text-transform: uppercase;
	letter-spacing: 2.5px;
	margin-bottom: 6px;
}

.section-title {
	font-family: var(--font-head);
	font-size: clamp(1.5rem, 2.5vw, 2rem);
	font-weight: 800;
	letter-spacing: -0.5px;
}

.section-count {
	font-size: 0.82rem;
	color: var(--muted);
	font-weight: 400;
}

.section-link {
	font-size: 0.875rem;
	font-weight: 600;
	color: var(--orange);
	display: flex;
	align-items: center;
	gap: 6px;
	transition: gap 0.2s;
	white-space: nowrap;
}

.section-link:hover {
	gap: 10px;
}

.cards-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px;
}

.rest-card {
	background: var(--card-bg);
	border-radius: var(--radius);
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.05);
	cursor: pointer;
	transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
	animation: fadeUp 0.5s ease both;
}

.rest-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 20px 48px rgba(0, 0, 0, 0.55);
	border-color: rgba(255, 82, 0, 0.2);
}

@
keyframes fadeUp {from { opacity:0;
	transform: translateY(18px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.rest-card:nth-child(1) {
	animation-delay: .05s
}

.rest-card:nth-child(2) {
	animation-delay: .10s
}

.rest-card:nth-child(3) {
	animation-delay: .15s
}

.rest-card:nth-child(4) {
	animation-delay: .20s
}

.rest-card:nth-child(5) {
	animation-delay: .25s
}

.rest-card:nth-child(6) {
	animation-delay: .30s
}

.rest-card:nth-child(7) {
	animation-delay: .35s
}

.rest-card:nth-child(8) {
	animation-delay: .40s
}

.rest-card:nth-child(9) {
	animation-delay: .45s
}

.rest-card:nth-child(10) {
	animation-delay: .50s
}

.rest-img {
  position: relative;
  width: 100%;
  height: 190px;
  background: var(--dark3);
  overflow: hidden;
  display: block;       /* remove flex — image handles itself */
}

.rest-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  display: block;
  transition: transform 0.4s ease;
}

.rest-card:hover .rest-img img {
  transform: scale(1.06);
}

.rest-img .overlay {
  position: absolute; inset: 0;
  background: linear-gradient(to top, rgba(0,0,0,0.75) 0%, transparent 50%);
}

.rest-img .rest-badge {
  position: absolute; top: 12px; left: 12px;
  background: var(--orange); color: #fff;
  font-size: 0.65rem; font-weight: 800;
  padding: 3px 10px; border-radius: 6px;
  text-transform: uppercase; letter-spacing: 0.8px;
  z-index: 2;
}

.rest-img .rest-time {
  position: absolute; top: 12px; right: 12px;
  background: rgba(0,0,0,0.72);
  border: 1px solid rgba(255,255,255,0.08);
  color: var(--white); font-size: 0.72rem; font-weight: 600;
  padding: 3px 9px; border-radius: 6px;
  z-index: 2;
}

.rest-img .rest-rating {
  position: absolute; bottom: 12px; right: 12px;
  background: rgba(0,0,0,0.82);
  border: 1px solid rgba(255,255,255,0.1);
  color: var(--white); font-size: 0.8rem; font-weight: 700;
  padding: 4px 10px; border-radius: 8px;
  display: flex; align-items: center; gap: 4px;
  z-index: 2;
}

.rest-img::before {
	content: '';
	position: absolute;
	inset: 0;
	background: radial-gradient(ellipse at center, rgba(255, 82, 0, 0.09) 0%,
		transparent 70%);
}

.rest-img .overlay {
	position: absolute;
	inset: 0;
	background: linear-gradient(to top, rgba(0, 0, 0, 0.75) 0%, transparent
		50%);
}

.rest-badge {
	position: absolute;
	top: 12px;
	left: 12px;
	background: var(--orange);
	color: #fff;
	font-size: 0.65rem;
	font-weight: 800;
	padding: 3px 10px;
	border-radius: 6px;
	text-transform: uppercase;
	letter-spacing: 0.8px;
}

.rest-time {
	position: absolute;
	top: 12px;
	right: 12px;
	background: rgba(0, 0, 0, 0.72);
	border: 1px solid rgba(255, 255, 255, 0.08);
	color: var(--white);
	font-size: 0.72rem;
	font-weight: 600;
	padding: 3px 9px;
	border-radius: 6px;
}

.rest-rating {
	position: absolute;
	bottom: 12px;
	right: 12px;
	background: rgba(0, 0, 0, 0.82);
	border: 1px solid rgba(255, 255, 255, 0.1);
	color: var(--white);
	font-size: 0.8rem;
	font-weight: 700;
	padding: 4px 10px;
	border-radius: 8px;
	display: flex;
	align-items: center;
	gap: 4px;
}

.rest-rating .star {
	color: var(--yellow);
}

.rest-body {
	padding: 16px;
}

.rest-name {
	font-family: var(--font-head);
	font-size: 1rem;
	font-weight: 700;
	margin-bottom: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.rest-sub {
	font-size: 0.78rem;
	color: var(--muted);
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	gap: 6px;
	flex-wrap: wrap;
}

.rest-sub .dot {
	width: 3px;
	height: 3px;
	background: var(--muted);
	border-radius: 50%;
	flex-shrink: 0;
}

.rest-meta-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 12px;
}

.rest-meta-row .price {
	font-size: 0.8rem;
	color: var(--muted);
}

.rest-meta-row .dist {
	font-size: 0.78rem;
	color: var(--muted);
}

.rest-divider {
	height: 1px;
	background: rgba(255, 255, 255, 0.06);
	margin-bottom: 12px;
}

.rest-offer {
	background: rgba(255, 82, 0, 0.08);
	border: 1px dashed rgba(255, 82, 0, 0.3);
	color: var(--orange-lt);
	font-size: 0.77rem;
	font-weight: 600;
	padding: 8px 12px;
	border-radius: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

/* ── FOOTER ──────────────────────────────────────────────── */
footer {
	background: var(--dark2);
	border-top: 1px solid rgba(255, 255, 255, 0.06);
	padding: 56px 5% 28px;
}

.footer-top {
	display: grid;
	grid-template-columns: 1.6fr repeat(3, 1fr);
	gap: 48px;
	margin-bottom: 48px;
}

.footer-brand .logo {
	font-family: var(--font-head);
	font-size: 1.4rem;
	font-weight: 800;
	color: var(--orange);
	margin-bottom: 14px;
}

.footer-brand .logo span {
	color: var(--white);
}

.footer-brand p {
	font-size: 0.85rem;
	color: var(--muted);
	line-height: 1.85;
	max-width: 230px;
	margin-bottom: 18px;
}

.location-pill {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	background: rgba(255, 82, 0, 0.1);
	border: 1px solid rgba(255, 82, 0, 0.2);
	color: var(--orange-lt);
	font-size: 0.78rem;
	font-weight: 600;
	padding: 5px 12px;
	border-radius: 100px;
}

.socials {
	display: flex;
	gap: 10px;
	margin-top: 20px;
}

.social-icon {
	width: 36px;
	height: 36px;
	background: var(--dark3);
	border: 1px solid rgba(255, 255, 255, 0.07);
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.95rem;
	cursor: pointer;
	transition: all 0.2s;
}

.social-icon:hover {
	border-color: var(--orange);
	background: rgba(255, 82, 0, 0.1);
}

.footer-col h4 {
	font-family: var(--font-head);
	font-size: 0.875rem;
	font-weight: 700;
	margin-bottom: 18px;
	color: var(--white);
}

.footer-col ul {
	display: flex;
	flex-direction: column;
	gap: 11px;
}

.footer-col ul li a {
	font-size: 0.83rem;
	color: var(--muted);
	transition: color 0.2s;
	display: flex;
	align-items: center;
	gap: 8px;
}

.footer-col ul li a::before {
	content: '';
	width: 4px;
	height: 4px;
	background: var(--dark3);
	border-radius: 50%;
	flex-shrink: 0;
	transition: background 0.2s;
}

.footer-col ul li a:hover {
	color: var(--orange);
}

.footer-col ul li a:hover::before {
	background: var(--orange);
}

.footer-divider {
	height: 1px;
	background: rgba(255, 255, 255, 0.06);
	margin-bottom: 28px;
}

.footer-bottom {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 12px;
}

.footer-bottom p {
	font-size: 0.8rem;
	color: #444;
}

.footer-cities {
	display: flex;
	align-items: center;
	gap: 6px;
	flex-wrap: wrap;
}

.footer-cities strong {
	font-size: 0.78rem;
	color: #666;
}

.city-chip {
	background: var(--dark3);
	border: 1px solid rgba(255, 255, 255, 0.05);
	color: #555;
	font-size: 0.72rem;
	padding: 2px 9px;
	border-radius: 5px;
}

/* ── Responsive ──────────────────────────────────────────── */
@media ( max-width :960px) {
	.nav-center {
		width: 240px;
	}
	.footer-top {
		grid-template-columns: 1fr 1fr;
	}
}



/* ── CART BADGE ───────────────────────────────────────────── */
.nav-right a button {
  cursor: pointer;
}
.nav-right a:hover button {
  border-color: var(--orange);
  color: var(--orange);
}

/* ── HAMBURGER ───────────────── */
.menu-toggle {
  display: none;
  font-size: 1.6rem;
  cursor: pointer;
}

/* ── MOBILE NAV ───────────────── */
@media (max-width: 768px) {

  .menu-toggle {
    display: block;
    color: var(--white);
  }

  .nav-center {
    display: none;
  }

  .nav-right-group {
    position: absolute;
    top: 64px;
    right: 0;
    width: 100%;
    background: var(--dark2);
    flex-direction: column;
    align-items: flex-start;
    padding: 20px;
    gap: 16px;

    display: none; /* hidden by default */
  }

  .nav-right-group.active {
    display: flex;
  }

  .nav-links {
    flex-direction: column;
    gap: 12px;
    width: 100%;
  }

  .nav-right {
    flex-direction: column;
    width: 100%;
  }

  .nav-right a {
    width: 100%;
  }

  .btn-outline,
  .btn-solid {
    width: 100%;
    text-align: center;
  }
}
</style>
	</head>
	<body>
	
	<!-- ══ NAVBAR ════════════════════════════════════════════════ -->
	
	<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    Cart cart = (Cart) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalCount() : 0;
	%>
	<nav>
	  <div class="nav-logo">
	    <a href="callingRestaurant" style="color:inherit;">Food</a><span>App</span>
	  </div>
	  
	   <div class="menu-toggle" onclick="toggleMenu()">
   			 ☰
 	   </div>
	
	  <div class="nav-center">
	    <input type="text" placeholder="🔍  Search restaurants, cuisines..."/>
	    <button>Search</button>
	  </div>
	
	  <div class="nav-right-group" id="navMenu">
	    <ul class="nav-links">
	      <li><a href="callingRestaurant">Restaurants</a></li>
	      <li><a href="#">Offers</a></li>
	      <li><a href="#">Help</a></li>
	    </ul>
	
	    <div class="nav-right">
	
	      <%-- 🛒 Cart Button with live count badge --%>
	      <a href="cart" style="text-decoration:none;">
	        <button class="btn-outline" style="
	            display:flex; align-items:center; gap:8px;
	            position:relative; border-color:rgba(255,255,255,0.15);">
	          🛒 Cart
	          <% if (cartCount > 0) { %>
	            <span style="
	              background: var(--orange); color: #fff;
	              font-size: 0.68rem; font-weight: 800;
	              padding: 1px 7px; border-radius: 100px;
	              min-width: 20px; text-align: center;
	              line-height: 1.6;">
	              <%= cartCount %>
	            </span>
	          <% } %>
	        </button>
	      </a>
	
	      <%-- User info / login buttons --%>
	      <% if (loggedUser != null) { %>
	        <span style="
	          color: var(--muted); font-size: 0.85rem;
	          display:flex; align-items:center; gap:6px;">
	          👋 <%= loggedUser.getUsername() %>
	          <% if ("Admin".equals(loggedUser.getRole())) { %>
	            <span style="
	              background:rgba(255,82,0,0.15);
	              border:1px solid rgba(255,82,0,0.3);
	              color:var(--orange); font-size:0.68rem;
	              font-weight:700; padding:1px 8px;
	              border-radius:100px;">
	              ADMIN
	            </span>
	          <% } %>
	        </span>
	        <a href="logout" class="btn-outline">Logout</a>
	
	      <% } else { %>
	        <a href="login"
	           class="btn-outline"
	           style="border:1.5px solid rgba(255,255,255,0.15);">
	           Sign In
	        </a>
	        <a href="signup" class="btn-solid">Sign Up</a>
	      <% } %>
	
	    </div>
	  </div>
</nav>
	<!-- ══ HERO STRIP ════════════════════════════════════════════ -->
	<div class="hero-strip">
	  <div class="hero-strip-left">
	    <h1>Discover best restaurants in <em>Bangalore</em></h1>
	    <p>📍 Bengaluru, Karnataka &nbsp;·&nbsp; Delivering to your area</p>
	  </div>
	  <div class="hero-strip-right">
	    <div class="strip-stat">
	      <div class="num">500<span>+</span></div>
	      <div class="lbl">Restaurants</div>
	    </div>
	    <div class="strip-stat">
	      <div class="num">30<span>min</span></div>
	      <div class="lbl">Avg. Delivery</div>
	    </div>
	    <div class="strip-stat">
	      <div class="num">4.8<span>★</span></div>
	      <div class="lbl">Avg. Rating</div>
	    </div>
	  </div>
	</div>
		
	<!-- ══ RESTAURANTS ════════════════════════════════════════════ -->
	<section class="restaurant-section" id="restaurants">
	  <div class="section-header">
	    <div>
	      <div class="section-label">Top Picks</div>
	      <h2 class="section-title">Best restaurants near you &nbsp;<span class="section-count">(10)</span></h2>
	    </div>
	    <a href="#" class="section-link">View all →</a>
	  </div>
	
	  <div class="cards-grid">

<%
  List<Restaurant> list = (List<Restaurant>) request.getAttribute("allRestaurants");
  if (list != null && !list.isEmpty()) {
    for (Restaurant r : list) {
%>
	<a href="menu?restaurantId=<%=r.getId()%>" style="text-decoration:none; color:inherit; display:block;">
  <div class="rest-card">

    <div class="rest-img">
      <img src="<%= r.getImageUrl() %>" alt="<%= r.getName() %>"/>
      <div class="overlay"></div>
      <div class="rest-badge">Special</div>
      <div class="rest-time">⏱ 25 min</div>
      <div class="rest-rating"><span class="star">★</span> <%= r.getRating() %></div>
    </div>

    <div class="rest-body">
      <div class="rest-name"><%= r.getName() %></div>
      <div class="rest-sub">
        <span><%= r.getCategory() %></span>
        <span class="dot"></span>
        <span><%= r.getLocation() %></span>
      </div>
      <div class="rest-meta-row">
        <span class="price">₹<%= r.getPriceForTwo() %> for two</span>
        <span class="dist">📍 <%= r.getDistanceKm() %> km</span>
      </div>
      <div class="rest-divider"></div>
      <div class="rest-offer">🏷 <%= r.getOffer() %></div>
    </div>

  </div>  <%-- END rest-card --%>

<%
    }
  }
%>

</div>  <%-- END cards-grid --%>
	</section>
	
	<!-- ══ FOOTER ════════════════════════════════════════════════ -->
	<footer>
	  <div class="footer-top">
	    <div class="footer-brand">
	      <div class="logo">Food<span>App</span></div>
	      <p>Discover top-rated restaurants around you and get fresh food delivered to your doorstep.</p>
	      <div class="location-pill">📍 Delivering in Bangalore</div>
	      <div class="socials">
	        <div class="social-icon">𝕏</div>
	        <div class="social-icon">in</div>
	        <div class="social-icon">f</div>
	        <div class="social-icon">📷</div>
	      </div>
	    </div>
	    <div class="footer-col">
	      <h4>Company</h4>
	      <ul>
	        <li><a href="#">About Us</a></li>
	        <li><a href="#">Careers</a></li>
	        <li><a href="#">Our Team</a></li>
	        <li><a href="#">Blog</a></li>
	        <li><a href="#">Press</a></li>
	      </ul>
	    </div>
	    <div class="footer-col">
	      <h4>For Restaurants</h4>
	      <ul>
	        <li><a href="#">Partner With Us</a></li>
	        <li><a href="#">Restaurant Login</a></li>
	        <li><a href="#">List Your Restaurant</a></li>
	        <li><a href="#">Advertise</a></li>
	        <li><a href="#">Merchant Support</a></li>
	      </ul>
	    </div>
	    <div class="footer-col">
	      <h4>Support</h4>
	      <ul>
	        <li><a href="#">Help Centre</a></li>
	        <li><a href="#">Terms &amp; Conditions</a></li>
	        <li><a href="#">Privacy Policy</a></li>
	        <li><a href="#">Cookie Policy</a></li>
	        <li><a href="#">Contact Us</a></li>
	      </ul>
	    </div>
	  </div>
	  <div class="footer-divider"></div>
	  <div class="footer-bottom">
	    <p>© 2025 FoodApp Pvt. Ltd. All rights reserved.</p>
	    <div class="footer-cities">
	      <strong>Cities:</strong>
	      <span class="city-chip">Bangalore</span>
	      <span class="city-chip">Hyderabad</span>
	      <span class="city-chip">Mumbai</span>
	      <span class="city-chip">Delhi</span>
	      <span class="city-chip">Pune</span>
	      <span class="city-chip">Chennai</span>
	    </div>
	  </div>
	</footer>

	<script>
		function toggleMenu() {
			document.getElementById("navMenu").classList.toggle("active");
		}
	</script>

</body>
	</html>
