import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the form data
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/mydatabase";
            String dbUser = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Create the "cart" table if it doesn't exist
            createCartTable(conn);

            // Insert the product into the "cart" table
            String query = "INSERT INTO cart (product_id, user_id, quantity) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, productId);
            stmt.setInt(2, userId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();

            // Close the statement and connection
            stmt.close();
            conn.close();

            // Redirect to the cart page
            response.sendRedirect("/Lux_Attire/View/user/cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Creates the "cart" table if it doesn't exist
    private void createCartTable(Connection conn) throws SQLException {
        String query = "CREATE TABLE IF NOT EXISTS cart (id INT PRIMARY KEY AUTO_INCREMENT, product_id INT, user_id INT, quantity INT)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.executeUpdate();
        stmt.close();
    }
}
