<%@ page import="java.sql.*" %>
<%@ include file="verify.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title>Products</title>

	<style> 
	
   body {
            background-color: #171616;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        h1 {
            font-family: "Times New Roman", serif;
            margin: 0;
            font-size: 36px;
            animation: fadeIn 2s ease-in-out forwards;
        }

        @keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
nav {
            background-color: #333;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
        }
        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        nav ul li {
            margin: 0 10px;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
            padding: 5px;
        }
        nav ul li a:hover {
            background-color: #fff;
            color: #333;
            border-radius: 5px;
        }

/* Welcome section */
        #welcome {
            background-image: url(Images/img2.jpeg);
            background-size: cover;
            text-align: center;
            padding: 50px;
        }

        #welcome h1 {
            font-size: 38px;
            margin-bottom: 30px;
            animation: fadeIn 2s ease-in-out forwards;
        }

        #welcome p {
            color:#171616;
            font-size: 19px;
            margin-bottom: 30px;
            animation: fadeIn 3s ease-in-out forwards;
        }

/* Products section */
        
		.product_container {
			margin-top: 20px;
			padding-left: 35px;
			padding-right: 35px;
			display: flex;
			flex-wrap: wrap;
			justify-content: space-between;
    }
    	.product {
			flex-basis: 23%;
			margin-bottom: 2rem;
			text-align: center;
    }
    	.product img {
			max-width: 100%;
			height: 240px;
			width: 240px;
			object-fit: cover;
    }
    	.product img:hover {
            transform: scale(1.05);
            transition: all 0.3s ease-in-out;
        }
		.product span {
			color: #fff;
			display: block;
			margin-top: 10px;
			font-weight: bold;
			animation: fadeIn 4s ease-in-out forwards;
    }
    	.product .btn {
			margin-top: 10px;
			display: inline-block;
			padding: 12px 15px;
			color: #333;
			background-color: rgb(243, 243, 236);
			text-decoration: none;
			font-size: 16px;
			border-radius: 10px;
			transition: background-color 0.3s ease-in-out;
    }

		.product .btn:hover {
			background-color: #eae2e2;
			transform: scale(1.05);
			transition: all 0.3s ease-in-out;
}

        p {
            color: #fff;
            font-size: 18px;
            margin: 10px 0;
            animation: fadeIn 4s ease-in-out forwards
        }
        
        footer{
            color: #fff;
            text-align: center;
			margin-top: 15px;
            animation: fadeIn 5s ease-in-out forwards;
}

    </style>

</style>
	
</head>
<body>
	<header>
		<h1>Lux Attire</h1>
	</header>
	<nav>
		<ul>
			<li><a href="home.jsp">Home</a></li>
			<li><a href="product.jsp">Products</a></li>
			<li><a href="about.jsp">About Us</a></li>
            <%
            if(userId != 0){
              %>
              <li><a href="<%= dashboardUrl %>">Dashboard</a></li>
                    <li><a href="/Lux_Attire/clearSessionServlet">logout</a></li>
    
              <%
            }else{
              %>
              <li><a href="login.html">Login</a></li>
              <%
            }
            %>
		</ul>
	
	</nav>
	<section id="welcome">
		<h1>Welcome to Lux Attire</h1>
		<p> <i> Experience the Luxury Fabrics. </i> </p>

	  </section>
	  <section id="products">

        <%
        // Establish database connection
        String url = "jdbc:mysql://localhost:3306/mydatabase";
        String username = "root";
        String password = "root";
        Connection connection = DriverManager.getConnection(url, username, password);

        // Execute SQL query to fetch products
        String query = "SELECT * FROM products";
        PreparedStatement statement = connection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();

        // Loop through the result set and display products
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            double price = resultSet.getDouble("price");
            int quantity = resultSet.getInt("quantity");
            String image = resultSet.getString("image");
    %>



	<div class="product_container">
		<form method="POST" action="/Lux_Attire/addToCartServlet">
			<input type="hidden" name="user_id" value="<%= userId %>">
			<input type="hidden" name="product_id" value="<%= id %>">
			<input type="hidden" name="quantity" value="1">
			<div class="product">
				<img src="/Lux_Attire/View/Images/Uploads/<%= image %>" alt="<%= name %>">
				<span><%= name %></span>
                <% 
                if(userId != 0){
                    %>
                    <input type="submit" class="btn" value="Add to Cart">
                    <%
                }else{
                    %>
                    <input type="submit" class="btn" disabled value="Login to access cart">
                    <%
                }
                %>
			</div>
		</form>
				  


        <%
            }
    
            // Close database connection
            connection.close();
            statement.close();
            resultSet.close();
        %>
	</div>
</section>
	<footer>
		<p>&copy; 2023 Lux Attire. All rights reserved.</p>
	  </footer>
</body>
</html>