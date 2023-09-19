<!DOCTYPE html>
<html>
<head>
	<title>Cart - Lux Attire</title>
	<style>
		body {
			background-color: black;
		}

		h1 {
			color: white;
			text-align: center;
			padding-top: 50px;
		}

		table {
			margin: 50px auto;
			border-collapse: collapse;
			width: 80%;
		}

		th, td {
			padding: 10px;
			text-align: left;
			border-bottom: 1px solid white;
			color: white;
		}

		th {
			background-color: #555;
		}

		tbody tr:hover {
			background-color: #444;
		}

		tfoot td {
			text-align: right;
		}

		#cart-total {
			font-weight: bold;
		}

		#buy-button {
			margin: 20px auto;
			display: block;
			padding: 10px 20px;
			background-color: #555;
			color: white;
			border: none;
			border-radius: 5px;
			cursor: pointer;
		}

		#cart-image {
			position: absolute;
			top: 20px;
			right: 20px;
			width: 50px;
			height: 50px;
			background-image: url("./cart-image.jpg");
			background-size: cover;
		}

	</style>
</head>
<body>
	<h1>Cart</h1>

<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, java.util.*" %>

<%
// Get the user ID from the session
int userId = (int)session.getAttribute("userId");


try {
    // Get the database connection
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");
    
    // Prepare the SQL statement to fetch the cart items
    String sql = "SELECT c.quantity, p.name, p.price FROM cart c "
            + "INNER JOIN products p ON c.product_id = p.id "
            + "WHERE c.user_id = ?";
    PreparedStatement statement = connection.prepareStatement(sql);
    statement.setInt(1, userId);

    // Execute the query and fetch the results
    ResultSet rs = statement.executeQuery();

    // Display the cart items
    double totalAmount = 0;

    out.println("<table>");
    out.println("<thead>");
    out.println("<tr><th>Product Name</th><th>Price</th><th>Quantity</th></tr>");
    out.println("</thead>");
    out.println("<tbody  id='cart-items'>");
    
    while (rs.next()) {
    String productName = rs.getString("name");
    double price = rs.getDouble("price");
    int quantity = rs.getInt("quantity");
    double subtotal = price * quantity;
    totalAmount += subtotal;

    out.println("<tr><td>" + productName + "</td><td>" + price + "</td><td>" + quantity + "</td></tr>");
    }
    out.println("</tbody>");

    
    // Display the total amount
    out.println("<tfoot>");

    out.println("<tr><td></td><td>Total:</td><td>" + totalAmount + "</td></tr>");
    out.println("</tfoot>");
    out.println("</table>");

    // Clean up
    rs.close();
    statement.close();
    connection.close();
}catch(Exception e){
    out.print(e.getMessage());
    e.printStackTrace();
}
%>
<form method="POST" action="/Lux_Attire/placeOrderServlet" >
	<input id="buy-button" type="submit" value="Buy Now">
</form>
<script src="cart.js"></script>
</body>
</html>