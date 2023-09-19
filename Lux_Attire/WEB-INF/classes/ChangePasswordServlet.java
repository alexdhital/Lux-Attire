import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/update-password")
public class ChangePasswordServlet extends HttpServlet {

  private final String dbUrl = "jdbc:mysql://localhost:3306/mydatabase";
  private final String dbUsername = "root";
  private final String dbPassword = "root";

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    // get the form data
    String id = request.getParameter("id");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    // validate the form data
    if (id == null || id.isEmpty() || currentPassword == null || currentPassword.isEmpty()
        || newPassword == null || newPassword.isEmpty() || confirmPassword == null
        || confirmPassword.isEmpty()) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid form data");
      return;
    }

    if (!newPassword.equals(confirmPassword)) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "New passwords do not match");
      return;
    }

    // encode the new password in base64
    String encodedNewPassword = Base64.getEncoder().encodeToString(newPassword.getBytes());

    try (Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword)) {

      // check the current password for the user
      String checkSql = "SELECT password FROM users WHERE id = ?";
      PreparedStatement checkStatement = conn.prepareStatement(checkSql);
      checkStatement.setString(1, id);
      ResultSet resultSet = checkStatement.executeQuery();

      if (resultSet.next()) {
        String storedPassword = resultSet.getString("password");
        byte[] decodedStoredPassword = Base64.getDecoder().decode(storedPassword);

        if (!currentPassword.equals(new String(decodedStoredPassword))) {
          response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Incorrect current password");
          return;
        }
      } else {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        return;
      }

      // update the password for the user
      String updateSql = "UPDATE users SET password = ? WHERE id = ?";
      PreparedStatement updateStatement = conn.prepareStatement(updateSql);
      updateStatement.setString(1, encodedNewPassword);
      updateStatement.setString(2, id);
      int rowsUpdated = updateStatement.executeUpdate();

      if (rowsUpdated == 0) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
      } else {
        response.sendRedirect("/Lux_Attire/View/user/userprofile.jsp");
      }

    } catch (SQLException ex) {
      ex.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
    }

  }

}
