package com.Holidaymaker;

import java.sql.SQLException;
import java.util.Scanner;

public class Client {

    Scanner input = new Scanner(System.in);
    private SqlConsole sqlConsole = new SqlConsole();
    private InputControll inputControll = new InputControll();

    public Client() throws SQLException {
        adminMenu();
    }

    public void adminMenu() throws SQLException {

        boolean booking = true;

        while (booking) {

            System.out.println("*- Côte d'Azur Travel Agency -*");
            System.out.println("  1.  Register guest account");
            System.out.println("  2.  Search and book available rooms");
            System.out.println("  3.  Change booking");
            System.out.println("  4.  Cancel booking");
            System.out.println("  5.  Logout");
            System.out.println("*-----------------------------*");

            String option = input.nextLine();

            switch (option) {
                case "1":
                    registerGuest();
                    break;
                case "2":
                    searchAndBookAvailableRooms();
                    break;
                case "3":
                    System.out.println("Enter booking id");
                    int bookingId = Integer.parseInt(input.nextLine());
                    changeBooking(bookingId);
                    break;
                case "4":
                    sqlConsole.cancelBooking(deleteBooking());
                    break;
                case "5":
                    booking = false;
                    break;
                default:
                    System.out.println("No option found");
                    break;
            }
        }
    }


    private void registerGuest() {
        System.out.println("First name: ");
        String firstName = input.nextLine();
        System.out.println("Last name: ");
        String lastName = input.nextLine();
        System.out.println("E-mail: ");
        String eMail = input.nextLine();
        sqlConsole.registerGuestAccount(firstName, lastName, eMail);
    }

    private void searchAndBookAvailableRooms() throws SQLException {

        boolean searching = true;
        boolean addingRooms = true;
        boolean addOrNot = true;

        while (searching) {
            //Dates
            System.out.println("Summer season 01 June to 31 of July");
            String checkOut = inputControll.controlCheckOutDate();
            String checkIn = inputControll.controlCheckInDate();

            //Facilities
            int numberOfGuests = inputControll.controlNumberOfGuestsNotZero();
            System.out.println("Pool: 1/0 ");
            int pool = Integer.parseInt(input.nextLine());
            System.out.println("Restaurant: 1/0 ");
            int restaurant = Integer.parseInt(input.nextLine());
            System.out.println("Children activities: 1/0 ");
            int childrenActivities = Integer.parseInt(input.nextLine());
            System.out.println("Entertainment: 1/0 ");
            int entertainment = Integer.parseInt(input.nextLine());
            System.out.println("Max distance to beach (in meters): ");
            int distanceToBeach = Integer.parseInt(input.nextLine());
            System.out.println("Max distance to centre (in meters): ");
            int distanceToCentre = Integer.parseInt(input.nextLine());

            sqlConsole.searchAvailableRooms(numberOfGuests, pool, restaurant, childrenActivities, entertainment, distanceToBeach, distanceToCentre, checkOut, checkIn);
            sqlConsole.printAvailableRooms();
            sqlConsole.showAllUnbookedHotelRooms(numberOfGuests, pool, restaurant, childrenActivities, entertainment, distanceToBeach, distanceToCentre);
            sqlConsole.printAvailableRooms();

            System.out.println("Book room or do a new search? y/n");
            String answer = input.nextLine();

            if (answer.equals("y")) {
                //Book - room
                System.out.println("Guest id: ");
                int guestId = Integer.parseInt(input.nextLine());
                sqlConsole.booking(checkOut, checkIn, numberOfGuests, guestId);

                while (addingRooms) {
                    //Book - extras
                    System.out.println("Choose room id to make a booking for chosen dates.");
                    System.out.println("Room id: ");
                    int roomId = Integer.parseInt(input.nextLine());
                    System.out.println("Meals: none/half_board/full_board");
                    String meal = input.nextLine();
                    System.out.println("Extra bed: 1/0 ");
                    int extraBed = Integer.parseInt(input.nextLine());
                    sqlConsole.addBookingToBookingsXRooms(roomId, meal, extraBed);
                    System.out.println("Would you like to add an additional room y/n? ");
                    String option = input.nextLine();
                    while (addOrNot) {
                        if (option.equals("y")) {
                            System.out.println(" ");
                            addOrNot = false;
                        } else {
                            addOrNot = false;
                            addingRooms = false;
                        }

                    }
                }
            } else {
                searching = false;
            }

        }

    }

    private void changeBooking(int bookingId) throws SQLException {

        sqlConsole.getBooking(bookingId);
        sqlConsole.printAvailableRooms();
        System.out.println(" ");

        boolean updating = true;

        while (updating) {

            System.out.println("Choose option to update:");
            System.out.println("  1.  Check-in date:");
            System.out.println("  2.  Check-out date:");
            System.out.println("  3.  Number of guests: ");
            System.out.println("  4.  Close menu ");
            System.out.println("*-----------------------------*");

            String option = input.nextLine();

            switch (option) {
                case "1":
                    System.out.println("Check in date: YYYY-MM-DD");
                    String checkIn = input.nextLine();
                    sqlConsole.updateCheckInDate(checkIn, bookingId);
                    break;
                case "2":
                    System.out.println("Check out date: YYYY-MM-DD");
                    String checkOut = input.nextLine();
                    sqlConsole.updateCheckOutDate(checkOut, bookingId);
                    break;
                case "3":
                    System.out.println("Number of guests: ");
                    int numberOfGuests = Integer.parseInt(input.nextLine());
                    sqlConsole.updateNumberOfGuests(numberOfGuests, bookingId);
                    break;
                case "4":
                    updating = false;
                    break;
                default:
                    System.out.println("No option found");
                    break;
            }
        }
    }

    private int deleteBooking() {
        System.out.println("Cancel booking with id: ");
        return Integer.parseInt(input.nextLine());
    }

}
