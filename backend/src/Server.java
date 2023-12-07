import java.io.*;
import java.net.*;
import java.util.Scanner;

class Server {
    public static void main(String argv[]) throws Exception
    {
        String fileName = "database.txt";
        InputStream in = new FileInputStream(fileName); // file handling system will be decided
        // Scanner in = new Scanner(new File(fileName));

        String requestType;
        String capitalizedSentence;
        ServerSocket welcomeSocket = new ServerSocket(8080);


        while (true) {
            Socket connectionSocket = welcomeSocket.accept();
            BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
            DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
            // read type of the request
            requestType = inFromClient.readLine(); // available types are "get_quotes", "upvote_quote" ,
                                                   // "downvote_quote";
            // client request is read
            if (requestType.compareTo("get_quotes") == 0) {
                // return data to client
            } else if (requestType.compareTo("upvote_quote") == 0) {
                // get more data from client
                // process data
                // return info message
            } else if (requestType.compareTo("downvote_quote") == 0) {
                // get more data from client
                // process data
                // return info message
            }

            capitalizedSentence = "info message to client";
            outToClient.writeBytes(capitalizedSentence);
        }
    }
}
