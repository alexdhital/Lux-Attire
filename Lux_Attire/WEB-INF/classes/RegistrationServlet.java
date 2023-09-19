import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Base64;

import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import java.nio.file.Paths;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
@WebServlet("/registrationServlet")
public class RegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String user_type_raw = request.getParameter("user_type");
        String password = request.getParameter("password");
        

        // encrypt the password in Base64
        String encryptedPassword = Base64.getEncoder().encodeToString(password.getBytes());

        Part imagePart = request.getPart("image");
        InputStream image = imagePart.getInputStream();

        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString(); // Get the filename

        Files.copy(image, Paths.get("../../View/Images/Uploads/" + fileName)); // Save the file to the specified path

        // response.getWriter().println(preparedStatement.toString());
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            int user_type = Integer.parseInt(user_type_raw);
            // connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "root");

            // create the "users" table if it doesn't exist
            Statement statement = connection.createStatement();
            String createTableSql = "CREATE TABLE IF NOT EXISTS users (id INT(11) AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50), address VARCHAR(100), phone VARCHAR(20), password VARCHAR(100), image VARCHAR(255), user_type INT(11))";
            statement.executeUpdate(createTableSql);

            // prepare the SQL statement to insert data into the table
            String sql = "INSERT INTO users (name, address, phone, password, image, user_type) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, address);
            preparedStatement.setString(3, phone);
            preparedStatement.setString(4, encryptedPassword);
            preparedStatement.setString(5, fileName);
            preparedStatement.setInt(6, user_type);

            // execute the SQL statement
            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("/Lux_Attire/View/login.html");
            } else {
                response.sendRedirect("/Lux_Attire/view/home.jsp");
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
