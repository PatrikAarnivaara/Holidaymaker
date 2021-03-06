package com.Holidaymaker;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class InputControll {

    Scanner input = new Scanner(System.in);

    public int controlNumberOfGuestsNotZero() {
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


    public String controlCheckInDate() {

        while (true) {
            System.out.println("Check out date: YYYY-MM-DD");
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

    public String controlCheckOutDate() {

        while (true) {
            System.out.println("Check in date: YYYY-MM-DD");
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

}
