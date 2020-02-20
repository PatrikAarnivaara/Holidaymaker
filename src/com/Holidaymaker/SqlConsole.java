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


    void searchAvailableRooms(int pool, int restaurant, int childrenActivities, int entertainment, int distanceToBeach, int distanceToCentre, String checkOutDate, String checkInDate) {

        try {
            statement = conn.prepareStatement("SELECT * FROM all_hotel_rooms_booked_and_unbooked WHERE pool = ? AND restaurant = ? " +
                    "AND children_activities = ? AND entertainment = ? AND distance_to_beach < ? " +
                    "AND distance_to_centre < ?  HAVING check_in IS NULL OR check_out <= ? OR check_in >= ?");
            statement.setInt(1, pool);
            statement.setInt(2, restaurant);
            statement.setInt(3, childrenActivities);
            statement.setInt(4, entertainment);
            statement.setInt(5, distanceToBeach);
            statement.setInt(6, distanceToCentre);
            statement.setString(7, checkOutDate);
            statement.setString(8, checkInDate);
            resultSet = statement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void bookRoom(String checkInDate, String checkOutDate, int numberOfGuests, int roomId, int guestId, String meal, int extraBed) {

        try {
            statement = conn.prepareStatement("INSERT INTO bookings SET check_in = ?, check_out = ?, number_of_guests = ?, guest_id = ?");
            statement.setString(1, checkInDate);
            statement.setString(2, checkOutDate);
            statement.setInt(3, numberOfGuests);
            statement.setInt(4, guestId);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        try {
            statement = conn.prepareStatement("INSERT INTO bookingsXrooms SET room_id = ?, meal = ?, extra_bed = ?");
            statement.setInt(1, roomId);
            statement.setString(2, meal);
            statement.setInt(3, extraBed);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }


    }

    public void updateCheckInDate(String newCheckInDate, int bookingId) {

        try {
            statement = conn.prepareStatement("UPDATE bookings SET check_in = ? WHERE booking_id = ?");
            statement.setString(1, newCheckInDate);
            statement.setInt(2, bookingId);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void updateCheckOutDate(String newCheckOutDate, int bookingId) {

        try {
            statement = conn.prepareStatement("UPDATE bookings SET check_out = ? WHERE booking_id = ?");
            statement.setString(1, newCheckOutDate);
            statement.setInt(2, bookingId);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void updateNumberOfGuests(int newNumberOfGuests, int bookingId) {

        try {
            statement = conn.prepareStatement("UPDATE bookings SET number_of_guests = ? WHERE booking_id = ?");
            statement.setInt(1, newNumberOfGuests);
            statement.setInt(2, bookingId);
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    public void cancelBooking(int bookingId) {

        try {
            statement = conn.prepareStatement("DELETE FROM bookings WHERE booking_id = ?");
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
