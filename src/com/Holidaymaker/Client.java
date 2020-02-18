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

            System.out.println("Options: ");
            System.out.println("  1.  Register guest account");
            System.out.println("  2.  Registrera en bil");
            System.out.println("  3.  Beställ en körning");
            System.out.println("  4.  Hitta en användare");
            System.out.println("  5.  Avregistrera bil");
            System.out.println("  6.  Uppdatera användarnamn");
            System.out.println("  7.  Avsluta");
            System.out.println("------------------------------");

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
