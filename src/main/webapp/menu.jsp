<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.project.model.Restaurant, com.project.model.MenuItem, java.util.List"%>

<%
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><%=restaurant.getName()%> – Menu | FoodApp</title>
<link rel="icon"
	href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%23FF5200'/><text x='50' y='72' font-size='65' font-family='Arial Black' font-weight='900' fill='white' text-anchor='middle'>F</text></svg>" />
<link
	href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap"
	rel="stylesheet" />
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
	--radius: 14px;
	--font-head: 'Syne', sans-serif;
	--font-body: 'DM Sans', sans-serif;
}

*, *::before, *::after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	background: var(--dark);
	color: var(--text);
	font-family: var(--font-body);
}

a {
	text-decoration: none;
	color: inherit;
}

/* NAV */
nav {
	position: sticky;
	top: 0;
	z-index: 100;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 5%;
	height: 64px;
	background: rgba(13, 13, 13, 0.95);
	backdrop-filter: blur(14px);
	border-bottom: 1px solid rgba(255, 82, 0, 0.12);
}

.nav-logo {
	font-family: var(--font-head);
	font-size: 1.4rem;
	font-weight: 800;
	color: var(--orange);
}

.nav-logo span {
	color: var(--white);
}

.back-btn {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 0.875rem;
	font-weight: 600;
	color: var(--muted);
	border: 1.5px solid rgba(255, 255, 255, 0.1);
	padding: 7px 16px;
	border-radius: 8px;
	transition: all 0.2s;
	cursor: pointer;
}

.back-btn:hover {
	border-color: var(--orange);
	color: var(--orange);
}

/* RESTAURANT HEADER */
.rest-header {
	background: var(--dark2);
	padding: 40px 5%;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	display: flex;
	gap: 28px;
	align-items: center;
}

.rest-header-img {
	width: 110px;
	height: 110px;
	border-radius: 16px;
	overflow: hidden;
	flex-shrink: 0;
	background: var(--dark3);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 3rem;
	border: 1px solid rgba(255, 255, 255, 0.07);
}

.rest-header-img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.rest-header-info h1 {
	font-family: var(--font-head);
	font-size: clamp(1.5rem, 3vw, 2.2rem);
	font-weight: 800;
	letter-spacing: -0.5px;
	margin-bottom: 8px;
}

.rest-header-meta {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
	margin-bottom: 12px;
}

.meta-pill {
	display: flex;
	align-items: center;
	gap: 6px;
	background: var(--dark3);
	border: 1px solid rgba(255, 255, 255, 0.07);
	padding: 5px 12px;
	border-radius: 100px;
	font-size: 0.8rem;
	font-weight: 500;
	color: var(--muted);
}

.meta-pill.rating {
	color: var(--yellow);
	border-color: rgba(245, 197, 24, 0.2);
	background: rgba(245, 197, 24, 0.06);
}

.rest-offer-bar {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	background: rgba(255, 82, 0, 0.08);
	border: 1px dashed rgba(255, 82, 0, 0.3);
	color: var(--orange-lt);
	font-size: 0.82rem;
	font-weight: 600;
	padding: 8px 16px;
	border-radius: 10px;
}

/* CATEGORY TABS */
.category-tabs {
	padding: 20px 5% 0;
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	background: var(--dark);
	position: sticky;
	top: 64px;
	z-index: 50;
}

.tab {
	padding: 10px 20px;
	border-radius: 8px 8px 0 0;
	font-size: 0.85rem;
	font-weight: 600;
	cursor: pointer;
	border: 1px solid rgba(255, 255, 255, 0.07);
	border-bottom: none;
	background: var(--dark2);
	color: var(--muted);
	transition: all 0.2s;
}

.tab.active, .tab:hover {
	background: var(--orange);
	color: #fff;
	border-color: var(--orange);
}

/* MENU SECTION */
.menu-section {
	padding: 40px 5% 64px;
}

.category-section {
	margin-bottom: 48px;
}

.category-title {
	font-family: var(--font-head);
	font-size: 1.2rem;
	font-weight: 800;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 12px;
}

.category-title::after {
	content: '';
	flex: 1;
	height: 1px;
	background: rgba(255, 255, 255, 0.07);
}

/* MENU ITEMS GRID */
.menu-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
	gap: 16px;
}

.menu-item {
	background: var(--card-bg);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: var(--radius);
	padding: 18px;
	display: flex;
	gap: 16px;
	align-items: flex-start;
	transition: border-color 0.25s, transform 0.2s;
	cursor: pointer;
}

.menu-item:hover {
	border-color: rgba(255, 82, 0, 0.25);
	transform: translateY(-2px);
}

.item-info {
	flex: 1;
}

.item-top {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 6px;
}

.veg-dot {
	width: 14px;
	height: 14px;
	border-radius: 2px;
	flex-shrink: 0;
	border: 1.5px solid;
	display: flex;
	align-items: center;
	justify-content: center;
}

.veg-dot.veg {
	border-color: var(--green);
}

.veg-dot.veg::after {
	content: '';
	width: 6px;
	height: 6px;
	background: var(--green);
	border-radius: 50%;
}

.veg-dot.nonveg {
	border-color: #e53e3e;
}

.veg-dot.nonveg::after {
	content: '';
	width: 6px;
	height: 6px;
	background: #e53e3e;
	border-radius: 50%;
}

.item-name {
	font-family: var(--font-head);
	font-size: 0.95rem;
	font-weight: 700;
}

.item-desc {
	font-size: 0.8rem;
	color: var(--muted);
	line-height: 1.6;
	margin-bottom: 12px;
}

.item-bottom {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.item-price {
	font-family: var(--font-head);
	font-size: 1.05rem;
	font-weight: 800;
	color: var(--white);
}

.add-btn {
	background: transparent;
	border: 1.5px solid var(--orange);
	color: var(--orange);
	font-weight: 700;
	font-size: 0.85rem;
	padding: 6px 20px;
	border-radius: 8px;
	cursor: pointer;
	transition: all 0.2s;
	font-family: var(--font-body);
}

.add-btn:hover {
	background: var(--orange);
	color: #fff;
}
</style>
</head>
<body>

	<!-- NAV -->
	<nav>
		<div class="nav-logo">
			<a href="callingRestaurant">Food</a><span>App</span>
		</div>
		<a href="callingRestaurant" class="back-btn">← Back to Restaurants</a>
	</nav>

	<!-- RESTAURANT HEADER -->
	<div class="rest-header">
		<div class="rest-header-img">
			<%
			if (restaurant.getImageUrl() != null && !restaurant.getImageUrl().isEmpty()) {
			%>
			<img src="<%=restaurant.getImageUrl()%>"
				alt="<%=restaurant.getName()%>" />
			<%
			} else {
			%>
			🍽
			<%
			}
			%>
		</div>
		<div class="rest-header-info">
			<h1><%=restaurant.getName()%></h1>
			<div class="rest-header-meta">
				<div class="meta-pill rating">
					★
					<%=restaurant.getRating()%></div>
				<div class="meta-pill">
					🍽
					<%=restaurant.getCategory()%></div>
				<div class="meta-pill">
					📍
					<%=restaurant.getLocation()%></div>
				<div class="meta-pill">
					₹<%=restaurant.getPriceForTwo()%>
					for two
				</div>
				<div class="meta-pill">
					📍
					<%=restaurant.getDistanceKm()%>
					km away
				</div>
			</div>
			<div class="rest-offer-bar">
				🏷
				<%=restaurant.getOffer()%></div>
		</div>
	</div>

	<!-- CATEGORY TABS -->
	<div class="category-tabs">
		<div class="tab active" onclick="scrollTo('Starter')">Starters</div>
		<div class="tab" onclick="scrollTo('Main')">Main Course</div>
		<div class="tab" onclick="scrollTo('Dessert')">Desserts</div>
		<div class="tab" onclick="scrollTo('Drinks')">Drinks</div>
	</div>

	<!-- MENU ITEMS -->
	<section class="menu-section">

		<%
		String[] categories = {"Starter", "Main", "Dessert", "Drinks"};
		String[] catLabels = {"Starters", "Main Course", "Desserts", "Drinks"};
		String[] catEmojis = {"🥗", "🍽", "🍰", "🥤"};

		for (int c = 0; c < categories.length; c++) {
			String cat = categories[c];
			boolean hasItems = false;
			for (MenuItem item : menuItems) {
				if (item.getCategory().equals(cat)) {
			hasItems = true;
			break;
				}
			}
			if (!hasItems)
				continue;
		%>

		<div class="category-section" id="<%=cat%>">
			<div class="category-title"><%=catEmojis[c]%>
				&nbsp;<%=catLabels[c]%></div>
			<div class="menu-grid">

				<%
				for (MenuItem item : menuItems) {
					if (!item.getCategory().equals(cat))
						continue;
				%>
				<div class="menu-item">
					<div class="item-info">
						<div class="item-top">
							<div class="veg-dot <%=item.isVeg() ? "veg" : "nonveg"%>"></div>
							<div class="item-name"><%=item.getItemName()%></div>
							
						</div>
						<div class="item-desc"><%=item.getDescription()%></div>
						<div class="item-bottom">
							<div class="item-price">₹<%=(int) item.getPrice()%></div>
						</div>
					</div>
					 <form action="cart">
					 <input type="hidden" name ="menuId" value="<%=item.getId()%>">
					 <input type="hidden" name ="quantity" value="1">
					 <input type="hidden" name ="restaurantId" value="<%=item.getRestaurantId()%>">
					 <input type="hidden" name ="action" value="add">
				     <button class="add-btn" type="submit">+ ADD</button>
					 
					 </form>	
					
				</div>
				<%
				}
				%>

			</div>
		</div>

		<%
		}
		%>

	</section>

	<script>
  function scrollTo(id) {
    document.getElementById(id).scrollIntoView({ behavior: 'smooth', block: 'start' });
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    event.target.classList.add('active');
  }
</script>

</body>
</html>

