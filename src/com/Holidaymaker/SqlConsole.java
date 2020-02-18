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
            statement = conn.prepareStatement("INSERT INTO guests SET guest_first_name = ?, guest_last_name = ?, guest_email = ?");
            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, eMail);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //String checkInDate, String checkOutDate
    //WHERE check_in > ? AND check_out < ?

    void searchAvailableRooms(String checkInDate, String checkOutDate) {
        try {
            statement = conn.prepareStatement("SELECT * FROM hotels");
            statement.setString(1, checkInDate);
            statement.setString(2, checkOutDate);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void printAvailableRooms() {
        try {
            while (resultSet.next()) {
                String row = "Hotel: " + resultSet.getString("hotel_name")
                        + ", City: " + resultSet.getString("hotel_city");
                        //+ ", Available rooms: " + resultSet.getString("room_id");
                System.out.println(row);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
