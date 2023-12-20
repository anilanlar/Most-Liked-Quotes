import java.io.*;
import java.net.*;

public class MyThread extends Thread {

    Socket connectionSocket;

    public MyThread(Socket socket) {
        this.connectionSocket = socket;
    }

    public void run() {
        String requestType;
        try (BufferedReader inFromClient = new BufferedReader(
                new InputStreamReader(connectionSocket.getInputStream()))) {
            DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
            // read type of the request
            requestType = inFromClient.readLine(); // available types are "get_quotes", "upvote_quote" ,
            // "downvote_quote", "sign_up", "log_in";
            // "get_votes_by_quote_id"
            // client request is read
            if (requestType.compareTo("get_quotes") == 0) {
                // return data to client
                String userID = inFromClient.readLine();
                String quotes = Helper.getQuotes(userID);
                try {
                    outToClient.writeBytes(quotes);
                    outToClient.writeBytes("StatusCode: 200");

                } catch (Exception e) {
                    outToClient.writeBytes("StatusCode: 401");
                    outToClient.close();
                }
            } else if (requestType.compareTo("upvote_quote") == 0) {
                // get more data from client
                String quoteID = inFromClient.readLine();
                String userID = inFromClient.readLine();
                try {
                    // process data
                    Helper.upvote_quote(quoteID, userID);
                    outToClient.writeBytes("StatusCode: 200");
                } catch (Exception e) {
                    // return info message
                    outToClient.writeBytes("StatusCode: 404");
                    outToClient.close();
                }

                // return info message
            } else if (requestType.compareTo("downvote_quote") == 0) {
                // get more data from client
                String quoteID = inFromClient.readLine();
                String userID = inFromClient.readLine();
                try {
                    // process data
                    Helper.downvote_quote(quoteID, userID);
                    outToClient.writeBytes("StatusCode: 200");
                } catch (Exception e) {
                    // return info message
                    outToClient.writeBytes("StatusCode: 404");
                    outToClient.close();
                }

            } else if (requestType.compareTo("sign_up") == 0) {
                // get more data from client
                String username = inFromClient.readLine();
                String password = inFromClient.readLine();
                // process data
                try {
                    Helper.registerUser(username, password);
                    outToClient.writeBytes("StatusCode: 201");
                } catch (Exception e) {
                    System.out.print(e);
                    outToClient.writeBytes("StatusCode: 409");
                    outToClient.close();
                }

                // return info message

            } else if (requestType.compareTo("log_in") == 0) {
                // get more data from client
                String username = inFromClient.readLine();
                String password = inFromClient.readLine();
                // process data
                try {
                    String id = Helper.login(username, password);

                    // return info message
                    outToClient.writeBytes(id + "\n");
                    if (id == "-1") {
                        outToClient.writeBytes("StatusCode: 401");
                    } else {
                        outToClient.writeBytes("StatusCode: 200");
                    }

                } catch (Exception e) {
                    System.out.println(e);
                    outToClient.writeBytes("-1" + "\n");
                    outToClient.writeBytes("StatusCode: 401");
                    outToClient.close();
                }
            } else if (requestType.compareTo("get_votes_by_quote_id") == 0) {
                // get more data from client
                String quote_id = inFromClient.readLine();
                // process data
                try {
                    String votes = Helper.getVotesByQuoteId(quote_id);
                    // return info message
                    outToClient.writeBytes(votes);
                    outToClient.writeBytes("StatusCode: 200");
                } catch (Exception e) {
                    outToClient.writeBytes("StatusCode: 401");
                    outToClient.close();
                }
            } else if (requestType.compareTo("add_quote") == 0) {
                // get more data from client
                String quote = inFromClient.readLine();
                String userID = inFromClient.readLine();
                try {
                    // process data
                    Helper.add_quote(quote, userID);
                    outToClient.writeBytes("StatusCode: 200");
                } catch (Exception e) {
                    // return info message
                    outToClient.writeBytes("StatusCode: 404");
                    outToClient.close();
                }

            }

            outToClient.close();
            return;
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return;
        }
    }

}
