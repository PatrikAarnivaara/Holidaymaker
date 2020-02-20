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


    void searchAvailableRooms(int numberOfGuests, int pool, int restaurant, int childrenActivities, int entertainment, String checkOutDate, String checkInDate) {
        //add field for room type?
        if (numberOfGuests == 1) {
            try {
                statement = conn.prepareStatement("SELECT * FROM all_hotel_rooms_booked_and_unbooked WHERE pool = ? AND restaurant = ? " +
                        "AND children_activities = ? AND entertainment = ? AND type = 'single' HAVING check_in IS NULL OR check_out <= ? OR check_in >= ?");
                statement.setInt(1, pool);
                statement.setInt(2, restaurant);
                statement.setInt(3, childrenActivities);
                statement.setInt(4, entertainment);
                statement.setString(5, checkOutDate);
                statement.setString(6, checkInDate);
                resultSet = statement.executeQuery();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (numberOfGuests == 2 || numberOfGuests == 3) {
            try {
                statement = conn.prepareStatement("SELECT * FROM all_hotel_rooms_booked_and_unbooked WHERE pool = ? AND restaurant = ? " +
                        "AND children_activities = ? AND entertainment = ? AND type = 'double' HAVING check_in IS NULL OR check_out <= ? OR check_in >= ?");
                statement.setInt(1, pool);
                statement.setInt(2, restaurant);
                statement.setInt(3, childrenActivities);
                statement.setInt(4, entertainment);
                statement.setString(5, checkOutDate);
                statement.setString(6, checkInDate);
                resultSet = statement.executeQuery();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (numberOfGuests > 3) {
            try {
                statement = conn.prepareStatement("SELECT * FROM all_hotel_rooms_booked_and_unbooked WHERE pool = ? AND restaurant = ? " +
                        "AND children_activities = ? AND entertainment = ? AND type = 'suite' HAVING check_in IS NULL OR check_out <= ? OR check_in >= ?");
                statement.setInt(1, pool);
                statement.setInt(2, restaurant);
                statement.setInt(3, childrenActivities);
                statement.setInt(4, entertainment);
                statement.setString(5, checkOutDate);
                statement.setString(6, checkInDate);
                resultSet = statement.executeQuery();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void bookRoom() {
        //room_id, guest_id, dates, extras
    }

    public void cancelBooking(int bookingId) {

        try {
            statement = conn.prepareStatement("DELETE FROM bookings WHERE booking_id = ?");
            statement.setInt(1, bookingId);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        try {
            statement = conn.prepareStatement("DELETE FROM bookingsXrooms WHERE booking_id = ?");
            statement.setInt(1, bookingId);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    public void printAvailableRooms() {
        try {
            while (resultSet.next()) {
                String row = "Room id: " + resultSet.getString("room_id")
                        + ", Hotel: " + resultSet.getString("hotel_name")
                        + ", City: " + resultSet.getString("hotel_city")
                        + ", Room type: " + resultSet.getString("type")
                        + ", Price: " + resultSet.getDouble("price");
                System.out.println(row);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


}
