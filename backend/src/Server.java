import java.io.*;
import java.net.*;
import java.util.Scanner;

class Server {
    private static int numOfUsers = 0;
    private static String quotesFileName = "quotes.txt";
    private static String usersFileName = "users.txt";

    private static boolean checkUserExists(String username) {
        try {
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (params[1].compareTo(username) == 0) {
                    in.close();
                    return true;
                }
            }
            in.close();
            return false;
        } catch (IOException e) {
            System.out.println(e);
            return false;
        }
    }

    private static void registerUser(String username, String password) throws Exception {
        try {
            if (checkUserExists(username)) {
                throw new Exception("Username is already given");
            } else {
                numOfUsers++;
                FileWriter fileWriter = new FileWriter(usersFileName, true);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
                bufferedWriter.write(numOfUsers + " " + username + " " + password);
                bufferedWriter.newLine();
                bufferedWriter.close();
                fileWriter.close();
            }

        } catch (IOException e) {
            System.out.println(e);
        }
    }

    private static String getQuotes() {
        String quotes = "";
        try {
            Scanner in = new Scanner(new File(quotesFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                quotes = quotes + line + "\n";
            }
            in.close();

        } catch (IOException e) {
            System.out.println(e);

        }
        return quotes;
    }
    public static void main(String argv[]) throws Exception
    {
        String requestType;
        ServerSocket welcomeSocket = new ServerSocket(8080);

        while (true) {
            Socket connectionSocket = welcomeSocket.accept();
            BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
            DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
            // read type of the request
            requestType = inFromClient.readLine(); // available types are "get_quotes", "upvote_quote" ,
                                                   // "downvote_quote", "signup", "login";
            // client request is read
            if (requestType.compareTo("get_quotes") == 0) {
                // return data to client
                String quotes = Server.getQuotes();
                outToClient.writeBytes(quotes);
            } else if (requestType.compareTo("upvote_quote") == 0) {
                // get more data from client
                // process data
                // return info message
            } else if (requestType.compareTo("downvote_quote") == 0) {
                // get more data from client
                // process data
                // return info message
            }
            else if (requestType.compareTo("sign_up") == 0) {
                // get more data from client
                // process data
                // return info message
            } else if (requestType.compareTo("log_in") == 0) {
                // get more data from client
                // process data
                // return info message
            }
            outToClient.close();

        }
    }
}
