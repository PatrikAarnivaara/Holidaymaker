package com.Holidaymaker;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class Client {

    Scanner input = new Scanner(System.in);
    private SqlConsole sqlConsole = new SqlConsole();

    public Client() {
        adminMenu();
    }

    public void adminMenu() {

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
                    searchAvailableRooms();
                    break;
                case "3":
                    //changeBooking();
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

    private void searchAvailableRooms() {
        System.out.println("Summer season 01 June to 31 of July");
        String checkIn = controlCheckInDate();
        String checkOut = controlCheckOutDate();

        int numberOfGuests = controlNumberOfGuestsNotZero();
        System.out.println("Pool: 1/0 ");
        int pool = Integer.parseInt(input.nextLine());
        System.out.println("Restaurant: 1/0 ");
        int restaurant = Integer.parseInt(input.nextLine());
        System.out.println("Children activities: 1/0 ");
        int childrenActivities = Integer.parseInt(input.nextLine());
        System.out.println("Entertainment: 1/0 ");
        int entertainment = Integer.parseInt(input.nextLine());

        sqlConsole.searchAvailableRooms(numberOfGuests, pool, restaurant, childrenActivities, entertainment, checkOut, checkIn);
        sqlConsole.printAvailableRooms();
        System.out.println("Book room on these dates and number of guests?");
        //sqlConsole.bookRoom(checkIn, checkOut, numberOfGuests, guest_id);
        System.out.println(" ");
    }

    private int controlNumberOfGuestsNotZero() {
        while (true) {
            System.out.println("Number of guests: ");
            int numberOfGuestsCheck = Integer.parseInt(input.nextLine());
            if (numberOfGuestsCheck < 1) {
                System.out.println("Try again, guests can't be 0");
            } else {
                return numberOfGuestsCheck;
            }
        }
    }


    private String controlCheckInDate() {

        while (true) {
            System.out.println("Check in date: YYYY-MM-DD");
            String checkIn = input.nextLine();
            LocalDate checkInDate = LocalDate.from(DateTimeFormatter.ISO_LOCAL_DATE.parse(checkIn));
            LocalDate startOfSeason = LocalDate.of(2020, 6, 1);
            if (checkInDate.isBefore(startOfSeason)) {
                System.out.println("Try again, check in date too early");
            } else {
                return checkIn;
            }
        }


    }

    private String controlCheckOutDate() {

        while (true) {
            System.out.println("Check out date: YYYY-MM-DD");
            String checkOut = input.nextLine();
            LocalDate checkOutDate = LocalDate.from(DateTimeFormatter.ISO_LOCAL_DATE.parse(checkOut));
            LocalDate endOfSeason = LocalDate.of(2020, 7, 31);
            if (checkOutDate.isAfter(endOfSeason)) {
                System.out.println("Try again, check out date too late");
            } else {
                return checkOut;
            }
        }

    }

    private int deleteBooking() {
            System.out.println("Cancel booking with id: ");
            return Integer.parseInt(input.nextLine());
    }

}
