import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBHelper {

    private String _DBurl = "jdbc:postgresql://localhost:5432/Hasta Yonetim Sistemi" ;
    private  String _DBUser = "postgres" ;
    private String _DBPassword = "Tzua7611?" ;

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(_DBurl,_DBUser,_DBPassword);
    }
    public void showErrorMessage(SQLException exception)
    {
        System.out.println("Error : " + exception.getMessage() );
        System.out.println("Error Code :" + exception.getErrorCode());
    }
}
