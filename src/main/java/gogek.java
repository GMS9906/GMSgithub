import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Sales_Name
 */
@WebServlet("/gogek")
public class gogek extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public gogek() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
       response.setContentType("text/html; charset=utf-8");
       Connection conn = null;
       Statement stmt = null;
       ResultSet rs = null;

         String strReturn = "";
         String url = "jdbc:oracle:thin:@localhost:1521:orcl"; // DB접속정보
         String userid = "ora_user";
         String passcode = "human123";
         String sql = "select mobile, sum(total) as total1 from cafe_sales group by mobile order by sum(total) desc";
         try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, userid, passcode); // null if connection failed.
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
               if (!strReturn.equals(""))
                  strReturn += ";";
               strReturn += rs.getInt("mobile") + "," + rs.getString("total1");
            }

         } catch (Exception e) {
            e.printStackTrace();
         } finally {
            try {
               if (stmt != null)
                  stmt.close();
               if (conn != null)
                  conn.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
         }
         System.out.println(strReturn);
         response.getWriter().print(strReturn);
   }

   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   }

}
