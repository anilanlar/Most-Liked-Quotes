import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Helper {
    private static int numOfUsers = 0;
    private static String quotesFileName = "../database/quotes.txt";
    private static String usersFileName = "../database/users.txt";
    private static String votesFileName = "../database/votes.txt";

    protected static boolean checkUserExists(String username) {
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

    protected static void registerUser(String username, String password) throws Exception {
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

    protected static String login(String username, String password) throws Exception {
        try {
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (params[1].compareTo(username) == 0) {
                    if (params[2].compareTo(password) == 0) {
                        in.close();
                        return params[0];
                    } else {
                        throw new Exception("Invalid Credentials.");
                    }
                }
            }
            in.close();
            return "-1";
        } catch (IOException e) {
            System.out.println(e);
            return "-1";
        }
    }

    protected static String getQuotes() {
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

    protected static boolean checkQuoteExists(String id) {
        try {
            Scanner in = new Scanner(new File(quotesFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (id.compareTo(params[0]) == 0) {
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

    protected static boolean checkUserExistsWithId(String id) {
        try {
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (id.compareTo(params[0]) == 0) {
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

    protected static boolean checkUserVotedTheQuote(String quoteID, String userID) {
        try {
            Scanner in = new Scanner(new File(votesFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.trim().split(" ");
                if (params[0].trim().compareTo(userID) == 0 && params[1].trim().compareTo(quoteID) == 0) {
                    return true;
                }
            }
            in.close();
            return false;
        } catch (IOException e) {
            System.out.println(e);
            return true;
        }

    }

    protected static void downvote_quote(String quoteID, String userID) throws Exception {
        if (checkQuoteExists(quoteID) && checkUserExistsWithId(userID) && !checkUserVotedTheQuote(quoteID, userID)) {
            try {
                Scanner in = new Scanner(new File(quotesFileName));
                ArrayList<String> lines = new ArrayList<>();
                while (in.hasNext()) {
                    String line = in.nextLine();
                    lines.add(line);
                }
                in.close();

                FileWriter writerVotes = new FileWriter(votesFileName, true);
                BufferedWriter bufferedWriterVotes = new BufferedWriter(writerVotes);
                bufferedWriterVotes.write(userID + " " + quoteID + " " + "D");
                bufferedWriterVotes.newLine();
                bufferedWriterVotes.close();
                writerVotes.close();

                FileWriter fileWriter = new FileWriter(quotesFileName);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

                for (String line : lines) {
                    String[] params = line.split("\"");
                    String quote = params[1].trim();
                    String id = params[0].trim();
                    String[] votes = params[2].trim().split(" ");
                    String upvote = votes[0].trim();
                    String downvote = votes[1].trim();
                    if (quoteID.compareTo(id) == 0) {
                        bufferedWriter.write(id + " \"" + quote + "\" " + upvote + " "
                                + String.format("%d", Integer.parseInt(downvote) + 1));
                        bufferedWriter.newLine();
                    } else {
                        bufferedWriter.write(line);
                        bufferedWriter.newLine();
                    }
                }

                bufferedWriter.close();
            } catch (IOException e) {
                System.out.println(e);
            }
        } else {
            throw new Exception("Invalid user id or quote id.");
        }
    }

    protected static void upvote_quote(String quoteID, String userID) throws Exception {
        if (checkQuoteExists(quoteID) && checkUserExistsWithId(userID) && !checkUserVotedTheQuote(quoteID, userID)) {
            try {
                Scanner in = new Scanner(new File(quotesFileName));
                ArrayList<String> lines = new ArrayList<>();
                while (in.hasNext()) {
                    String line = in.nextLine();
                    lines.add(line);
                }
                in.close();

                FileWriter writerVotes = new FileWriter(votesFileName, true);
                BufferedWriter bufferedWriterVotes = new BufferedWriter(writerVotes);
                bufferedWriterVotes.write(userID + " " + quoteID + " " + "U");
                bufferedWriterVotes.newLine();
                bufferedWriterVotes.close();
                writerVotes.close();

                FileWriter fileWriter = new FileWriter(quotesFileName);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
                for (String line : lines) {
                    String[] params = line.split("\"");
                    String quote = params[1].trim();
                    String id = params[0].trim();
                    String[] votes = params[2].trim().split(" ");
                    String upvote = votes[0].trim();
                    String downvote = votes[1].trim();

                    if (quoteID.compareTo(id) == 0) {
                        bufferedWriter.write(
                                id + " \"" + quote + "\" " + String.format("%d", Integer.parseInt(upvote) + 1) + " "
                                        + downvote);
                        bufferedWriter.newLine();
                    } else {
                        bufferedWriter.write(line);
                        bufferedWriter.newLine();
                    }
                }

                bufferedWriter.close();
            } catch (IOException e) {
                System.out.println(e);
            }
        } else {
            throw new Exception("Invalid user id or quote id.");
        }
    }
}