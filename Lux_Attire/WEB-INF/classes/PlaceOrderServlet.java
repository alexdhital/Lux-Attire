import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId"); // fetch user_id from session

        String jdbcUrl = "jdbc:mysql://localhost:3306/mydatabase";
        String username = "root";
        String password = "root";
        String driver = "com.mysql.jdbc.Driver";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(jdbcUrl, username, password);
            conn.setAutoCommit(false);

            // create orders table if it doesn't exist
            String sql = "CREATE TABLE IF NOT EXISTS orders ("
                    + "id INT(11) NOT NULL AUTO_INCREMENT,"
                    + "user_id INT(11) NOT NULL,"
                    + "product_id INT(11) NOT NULL,"
                    + "quantity INT(11) NOT NULL,"
                    + "PRIMARY KEY (id),"
                    + "FOREIGN KEY (user_id) REFERENCES users(id),"
                    + "FOREIGN KEY (product_id) REFERENCES products(id)"
                    + ")";
            stmt = conn.prepareStatement(sql);
            stmt.executeUpdate();

            // fetch product_id and quantity from carts table and products table
            sql = "SELECT c.product_id, p.quantity FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");

                
                // insert data into orders table
                sql = "INSERT INTO orders (user_id, product_id, quantity) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.setInt(2, productId);
                stmt.setInt(3, quantity);
                stmt.executeUpdate();
                
                
                String cartSqlQuery = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
                stmt = conn.prepareStatement(cartSqlQuery);
                stmt.setInt(1, userId);
                stmt.setInt(2, productId);
                stmt.executeUpdate();
                
            }

            conn.commit();
            
        } catch (SQLException | ClassNotFoundException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
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
        response.sendRedirect("/Lux_Attire/View/user/userorder.jsp"); // redirect to orders page
    }

}
