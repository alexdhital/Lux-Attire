<%@ page import="java.sql.*" %>
<%@ include file="verify.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>Order List</title>
  <style> 

    body {

      font-family: Arial, sans-serif;
      display: flex;
      background: linear-gradient(90deg,#0b0b0b , #505050);
      background-color: #f5f5f5;
    }
    .nav {
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
            padding:10px;
        }
        nav ul li a:hover {
            background-color: #fff;
            color: #333;
            border-radius: 5px;
        }

.user-panel {
    
  max-width: 900px;
  margin: auto;
  padding: 40px;
}

#user{
    text-align: center;
}
h1{
    color: #fff;
    padding-left: 150px;
}

table {

  border-collapse: collapse;
  width: 180%;
}


th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}
td{
    color: #fff;
}

th {
  background-color: #f2f2f2;
}


.view-btn{
  padding: 6px 12px;
  margin-right: 7px;
  background-color: #007bff;
  color: #fff;
  border: none;
  cursor: pointer;
}

.view-btn:hover{
  background-color: #0056b3;
}

</style>
</head>
<body>
    <div class="navbar">
    <nav>
		<ul>
            <li><a href="userprofile.jsp">Edit Profile</a></li>
			<li><a href="userorder.jsp">My Orders</a></li>
			<li><a href="/Lux_Attire/View/home.jsp">Home</a></li>
			<li><a href="/Lux_Attire/clearSessionServlet">logout</a></li>
		</ul>
	</nav>
</div>
<section id="user"> 
  <div class="user-panel">
    <h1>Orders List</h1>




<%

 
    PreparedStatement statement = null;
    ResultSet resultset = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");
        String sql = "SELECT o.id, p.name, o.quantity FROM orders o JOIN products p ON o.product_id = p.id WHERE o.user_id = ?";
        statement = conn.prepareStatement(sql);
        statement.setInt(1, userId);
        resultset = statement.executeQuery();

%>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>
<%
        while (resultset.next()) {
            int orderId = resultset.getInt("id");
            String productName = resultset.getString("name");
            int quantity = resultset.getInt("quantity");
%>
            <tr>
                <td><%= orderId %></td>
                <td><%= productName %></td>
                <td><%= quantity %></td>
                <td><a  class="view-btn" href="viewOrderDetails.jsp?orderId=<%= orderId %>">View</a></td>
            </tr>
<%
        }
%>
        </table>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.print(e.getMessage());

    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</div>
</section>
</body>
</html>