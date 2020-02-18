package com.Holidaymaker;


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
            System.out.println("  2.  Search available rooms");
            System.out.println("  3.  Book room");
            System.out.println("  4.  Change booking");
            System.out.println("  5.  Cancel booking");
            System.out.println("  6.  Update guest information");
            System.out.println("  7.  Logout");
            System.out.println("*-----------------------------*");

            String option = input.nextLine();

            switch (option) {
                case "1":
                    registerGuest();
                    break;
                case "2":
                    //registreraBil();
                    break;
                case "3":
                    //bestallKorning();
                    //sqlConsole.printBestallning();
                    break;
                case "4":
                    //sqlConsole.visaStartDatum();
                    //hittaAnvandare();
                    break;
                case "5":
                    //avregistreraBil();
                    break;
                case "6":
                    //uppdateraNamn();
                    break;
                case "7":
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

}
