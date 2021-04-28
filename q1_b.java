import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class q1_b {
    final static String query = "CALL `myProcedure`(param)";
    final static String Driver = "com.mysql.cj.jdbc.Driver";
    final static String path_DB = "jdbc:mysql://localhost/northwind?serverTimezone=UTC";
    final static String userName = "root";
    final static String passUser = "123456789";
    static String ColNames = "OrderID\t\t|\t\tProfit/Loss\t\t|\t\tAmount\n_____________________________________________________________";
    Connection con = null;
    static Statement stmt = null;
    static int numOfColumns;


    /**
     * fixString - Fixing the string to the float variable
     * @param: val - A value that represents the difference between the price paid and the average
     * @return: str - A string that corrects the missing spaces for printing
     * */
    private static String fixString(float val) {
        String str = "" + val;
        if(str.length() < 9){
            for (int i = 0; i < (9-str.length()); i++) {
                str += " ";
            }
        }
        return str;
    }
    /**
     * addValueToQuery - Add a variable into the query
     * @param: val - A string representing the value of userID
     * @return: str - A string representing the query
     * */
    private static String addValueToQuery(String val){
        return "CALL `myProcedure`('" +val+ "');";
    }

    /**
     * getQuery - Receiving the query and receiving input from the user
     * @return: str - A string representing the query including the thread of the values
     * */
    private static String getQuery(){
        System.out.println("Enter a CustomerID:");
        Scanner sc = new Scanner(System.in);
        return addValueToQuery(sc.nextLine());
    }

    /**
     * connectAndRunQueryInDB - The function connects to a database and then calls a query,
     * and prints the returned results from the database
     * */
    private static void connectAndRunQueryInDB() {
        try {
            Class.forName(Driver);
            try (Connection con = DriverManager.getConnection(path_DB, userName, passUser)) {
                stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(getQuery());
                System.out.println("\n" + ColNames);
                while (rs.next()) {
                    System.out.println(rs.getInt(1) + "\t\t|\t\t" + rs.getString(2) + "\t\t\t|\t\t" + fixString(rs.getFloat(3)) + "\t\t|\t\t");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
            connectAndRunQueryInDB();
    }
}
