import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class Main {

    public static void main(String[] args) throws SQLException {
        System.out.println("**************Copyright © Tüm Hakları Saklıdır*******");
        System.out.println("***************Database Management App***************");

        Menü();
    }

    public static void Menü() throws SQLException {
        Scanner data = new Scanner(System.in);
        int Chose;
        System.out.println(
                        "Chose 0 :" + "Çıkış" + "\n" +
                        "Chose 1 :" + "İnsert" + "\n" +
                        "Chose 2 :" + "Update" + "\n" +
                        "Chose 3 :" + "Delete" + "\n" +
                        "Chose 4 :" + "Search" + "\n"
        );
        System.out.println("Lütfen Seçim Yapın");
        Chose = data.nextInt();
        switch (Chose) {
            case 0: {
                System.out.println("Uygulama Kapatılıyor...");
                System.out.println("OZ YAZILIM A.Ş. Yi Tercih Ettiğiniz İçin Teşekkürler...");
                break;
            }
            case 1: {
                System.out.println("***************İnsert Menagemenet ***************");
                insertData();
                System.out.println("Menüye Dönülüyor...");
                Menü();
            }
            case 2: {
                System.out.println("***************Update Menagemenet ***************");
                updateData();
                System.out.println("Menüye Dönülüyor...");
                Menü();
            }
            case 3: {
                System.out.println("***************Delete Menagemenet ***************");
                deleteData();
                System.out.println("Menüye Dönülüyor...");
                Menü();
            }
            case 4: {
                System.out.println("***************Select Menagemenet ***************");
                Search();
                System.out.println("Menüye Dönülüyor...");
                Menü();
            }
            default:
                System.out.println("Yanlış Seçim Yaptınız!");
                System.out.println("Uygulama Kapatılıyor...");
                return;
        }
    }
    public static void Search() throws SQLException {
        Connection connection = null;
        DBHelper helper = new DBHelper();
        PreparedStatement statement ;
        ResultSet resultSet;
        try {
            connection = helper.getConnection();
            String sql = "SELECT *  FROM \"Tedavi Şema\".\"Randevu\" WHERE \"Randevu ID\" = ? ";
            statement = connection.prepareStatement(sql) ;
            statement.setInt(1,5) ;
            resultSet = statement.executeQuery() ;
            while(resultSet.next())
            {
                resultSet.getInt("Randevu ID") ;
                resultSet.getInt("Doktor ID");
                resultSet.getInt("Hasta ID");
                resultSet.getString("Başlangıç Zamanı");
                resultSet.getString("Bitiş Zamanı");
                resultSet.getString("Randevu Tarihi");
                resultSet.getString("Geldimi");
                System.out.println(
                        "Randevu ID\tDoktor ID\tHasta ID\tBaşlangıç Zamanı\tBitiş Zamanı\tRandevu Tarihi\tGeldimi"
                                + "\n" + resultSet.getInt("Randevu ID") + "\t"+"\t"+"\t"
                                + resultSet.getInt("Doktor ID") + "\t"+"\t"+"\t"
                                + resultSet.getInt("Hasta ID") + "\t"+"\t"+"\t"
                                + resultSet.getString("Başlangıç Zamanı") + "\t"+"\t"+"\t"
                                + resultSet.getString("Bitiş Zamanı") + "\t"+"\t"
                                + resultSet.getString("Randevu Tarihi") + "\t"+"\t"
                                + resultSet.getString("Geldimi")
                );
            }
        } catch (SQLException exception) {
            helper.showErrorMessage(exception);
        } finally {
            connection.close();
        }
    }

    public static void insertData() throws SQLException {
        Connection connection = null;
        DBHelper helper = new DBHelper();
        PreparedStatement statement = null;
        ResultSet resultSet;
        try {
            connection = helper.getConnection();
            String sql = "INSERT INTO \"Tedavi Şema\".\"Randevu\" \n" +
                    "( \"Doktor ID\", \"Hasta ID\", \"Başlangıç Zamanı\", \"Bitiş Zamanı\", \"Randevu Tarihi\", \"Geldimi\") \n" +
                    "VALUES (?,?,?,?,?,?) " ;
            statement = connection.prepareStatement(sql);
            statement.setInt(1, 5);
            statement.setInt(2, 4);
            statement.setString(3, "09:15 AM");
            statement.setString(4, "09:45 AM");
            statement.setString(5, "2020-07-30");
            statement.setString(6, "Hayır");
            int result = statement.executeUpdate();
            System.out.println( result + "\tkayıt eklendi");
        } catch (SQLException exception) {
            helper.showErrorMessage(exception);
        } finally {
            statement.close();
            connection.close();
        }
    }

    public static void updateData() throws SQLException {
        Connection connection = null;
        DBHelper helper = new DBHelper();
        PreparedStatement statement = null;
        ResultSet resultSet;
        try {
            connection = helper.getConnection();
            String sql = "UPDATE \"Tedavi Şema\".\"Randevu\" SET\n" +
                    "\t       \"Doktor ID\" =  1,\n" +
                    "\t        \"Hasta ID\" =  1,\n" +
                    "\t\"Başlangıç Zamanı\" =  '09:15 AM',\n" +
                    "\t    \"Bitiş Zamanı\" =  '09:45 AM' ,\n" +
                    "\t  \"Randevu Tarihi\" =  '2020-07-30',\n" +
                    "\t         \"Geldimi\" =  'Evet'\n" +
                    "\t         WHERE \"Randevu ID\" = ? ";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, 11);
            int result = statement.executeUpdate();
            System.out.println(result + "\tKayıt güncellendi");
        } catch (SQLException exception) {
            helper.showErrorMessage(exception);
        } finally {
            statement.close();
            connection.close();
        }
    }

    public static void deleteData() throws SQLException {
        Connection connection = null;
        DBHelper helper = new DBHelper();
        PreparedStatement statement = null;
        ResultSet resultSet;
        try {
            connection = helper.getConnection();
            String sql = "delete from \"Tedavi Şema\".\"Randevu\" where \"Randevu ID\" = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, 10);
            int result = statement.executeUpdate();
            System.out.println(result +"\tKayıt silindi");
        } catch (SQLException exception) {
            helper.showErrorMessage(exception);
        } finally {
            statement.close();
            connection.close();
        }
    }
}
