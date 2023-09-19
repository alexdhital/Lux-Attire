import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteProductServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get the ID of the product to be deleted from the GET request parameter
        int id = Integer.parseInt(request.getParameter("id"));

        // Connect to the database
        Connection conn = null;
        String dbUrl = "jdbc:mysql://localhost:3306/mydatabase";
        String dbUser = "root";
        String dbPassword = "root";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Delete the product from the "products" table based on its ID
           


            String query = "DELETE FROM orders WHERE product_id=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            stmt.executeUpdate();
           // Integer.parseInt(query);
            query = "DELETE FROM cart WHERE product_id=?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            stmt.executeUpdate();

            query = "DELETE FROM products WHERE id=?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            stmt.executeUpdate();

            // Redirect the user back to the product list page
            response.sendRedirect("/Lux_Attire/View/admin/productlist.jsp");

            // Close the statement and connection
            stmt.close();
            conn.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().print(e.getMessage());
            
            throw new ServletException("Error deleting product", e);
        }
    }
}
