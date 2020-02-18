package com.Holidaymaker;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SqlConsole {

    private Connection conn = null;
    private PreparedStatement statement;
    private ResultSet resultSet;

    public SqlConsole() {
        connect();
    }

    private void connect() {

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost/holidaymaker?user=root&password=mysql&serverTimezone=UTC");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    void registerGuestAccount(String firstName, String lastName, String eMail) {
        try {
            statement = conn.prepareStatement("INSERT INTO guest SET guest_firstname = ?, guest_lastname = ?, guest_email = ?");
            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, eMail);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    void searchGuestByFirstName(String firstName) {
        try {
            statement = conn.prepareStatement("SELECT * FROM travelers WHERE first_name LIKE ?");
            statement.setString(1, firstName);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void printSearchResult() {
        try {
            while (resultSet.next()) {
                String row = "traveller_id: " + resultSet.getString("traveller_id")
                        + ", First name: " + resultSet.getString("first_name")
                        + ", Last name: " + resultSet.getString("last_name");
                System.out.println(row);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
