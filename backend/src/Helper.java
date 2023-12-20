import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Helper {
    private static String quotesFileName = "../database/quotes.txt";
    private static String usersFileName = "../database/users.txt";
    private static String votesFileName = "../database/votes.txt";

    protected static boolean checkUserExists(String username) throws InterruptedException {
        try {
            Server.semaphoreUsersFile.acquire();
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (params[1].compareTo(username) == 0) {
                    in.close();
                    Server.semaphoreUsersFile.release();
                    return true;
                }
            }
            in.close();
            Server.semaphoreUsersFile.release();
            return false;
        } catch (IOException e) {
            Server.semaphoreUsersFile.release();
            System.out.println(e);
            return false;
        }
    }

    protected static void registerUser(String username, String password) throws Exception {
        try {
            if (checkUserExists(username)) {
                throw new Exception("Username is already given");
            } else {
                Server.semaphoreUsersFile.acquire();
                int numOfUsers = 0;
                Scanner in = new Scanner(new File(usersFileName));
                while (in.hasNext()) {
                    in.nextLine();
                    numOfUsers += 1;
                }
                in.close();
                numOfUsers++;
                FileWriter fileWriter = new FileWriter(usersFileName, true);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
                bufferedWriter.write(numOfUsers + " " + username + " " + password);
                bufferedWriter.newLine();
                bufferedWriter.close();
                fileWriter.close();
                Server.semaphoreUsersFile.release();
            }

        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreUsersFile.release();
        }
    }

    protected static String login(String username, String password) throws Exception {
        try {
            Server.semaphoreUsersFile.acquire();
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (params[1].compareTo(username) == 0) {
                    if (params[2].compareTo(password) == 0) {
                        in.close();
                        Server.semaphoreUsersFile.release();
                        return params[0];
                    } else {
                        in.close();
                         Server.semaphoreUsersFile.release();
                        throw new Exception("Invalid Credentials.");
                    }
                }
            }
            in.close();
            Server.semaphoreUsersFile.release();
            return "-1";
        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreUsersFile.release();
            return "-1";
        }
    }

    protected static String getQuotes(String userID) throws InterruptedException {
        String quotes = "";
        try {
            Server.semaphoreQuotesFile.acquire();
            Scanner in = new Scanner(new File(quotesFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split("-----");
                String voted = "N";
                String[] result = checkUserVotedTheQuote(params[0].trim(), userID);
                if (result[0] == "1") {

                    voted = result[1];
                }
                quotes = quotes + line + voted + "\n";
            }
            in.close();
            Server.semaphoreQuotesFile.release();

        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreQuotesFile.release();

        }
        Server.semaphoreQuotesFile.release();
        return quotes;
    }

    protected static boolean checkQuoteExists(String id) throws InterruptedException {
        try {
            Server.semaphoreQuotesFile.acquire();
            Scanner in = new Scanner(new File(quotesFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split("$-$");
                if (id.compareTo(params[0]) == 0) {
                    in.close();
                    Server.semaphoreQuotesFile.release();
                    return true;
                }
            }
            in.close();
            Server.semaphoreQuotesFile.release();
            return false;
        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreQuotesFile.release();
            return false;
        }
    }

    protected static boolean checkUserExistsWithId(String id) throws InterruptedException {
        try {
            Server.semaphoreUsersFile.acquire();
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (id.compareTo(params[0]) == 0) {
                    Server.semaphoreUsersFile.release();
                    return true;
                }
            }
            in.close();
            Server.semaphoreUsersFile.release();
            return false;
        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreUsersFile.release();
            return false;
        }
    }

    protected static String[] checkUserVotedTheQuote(String quoteID, String userID) throws InterruptedException {
        String[] result = new String[2];
        try {
            Server.semaphoreVotesFile.acquire();
            Scanner in = new Scanner(new File(votesFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.trim().split(" ");
                if (params[0].trim().compareTo(userID) == 0 && params[1].trim().compareTo(quoteID) == 0) {
                    in.close();
                    result[0] = "1";
                    result[1] = params[2].trim();
                    Server.semaphoreVotesFile.release();
                    return result;
                }
            }
            Server.semaphoreVotesFile.release();
            in.close();
            result[0] = "0";
            result[1] = "";
            return result;
        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreVotesFile.release();
            result[0] = "0";
            result[1] = "";
            return result;
        }

    }

    protected static void downvote_quote(String quoteID, String userID) throws Exception {
        if (checkQuoteExists(quoteID)) {
            if (checkUserExistsWithId(userID)) {
                if (checkUserVotedTheQuote(quoteID, userID)[0] == "0") {
                    try {
                        Server.semaphoreQuotesFile.acquire();
                        Scanner in = new Scanner(new File(quotesFileName));
                        ArrayList<String> lines = new ArrayList<>();
                        while (in.hasNext()) {
                            String line = in.nextLine();
                            lines.add(line);
                        }
                        in.close();
                        Server.semaphoreQuotesFile.release();
                        Server.semaphoreVotesFile.acquire();
                        FileWriter writerVotes = new FileWriter(votesFileName, true);
                        BufferedWriter bufferedWriterVotes = new BufferedWriter(writerVotes);
                        bufferedWriterVotes.write(userID + " " + quoteID + " " + "D");
                        bufferedWriterVotes.newLine();
                        bufferedWriterVotes.close();
                        writerVotes.close();

                        Server.semaphoreVotesFile.release();

                        Server.semaphoreQuotesFile.acquire();

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
                        Server.semaphoreQuotesFile.release();
                    } catch (IOException e) {
                        System.out.println(e);
                        Server.semaphoreVotesFile.release();
                        Server.semaphoreQuotesFile.release();
                    }
                } else {
                    throw new Exception("User has already voted the quote.");
                }
            } else {
                throw new Exception("Invalid user id.");
            }
        } else {
            throw new Exception("Invalid quote id.");
        }
    }

    protected static void upvote_quote(String quoteID, String userID) throws Exception {
        if (checkQuoteExists(quoteID)) {
            if (checkUserExistsWithId(userID)) {
                if (checkUserVotedTheQuote(quoteID, userID)[0] == "0") {
                    try {
                        Server.semaphoreQuotesFile.acquire();
                        Scanner in = new Scanner(new File(quotesFileName));
                        ArrayList<String> lines = new ArrayList<>();
                        while (in.hasNext()) {
                            String line = in.nextLine();
                            lines.add(line);
                        }
                        in.close();
                        Server.semaphoreQuotesFile.release();

                        Server.semaphoreVotesFile.acquire();

                        FileWriter writerVotes = new FileWriter(votesFileName, true);
                        BufferedWriter bufferedWriterVotes = new BufferedWriter(writerVotes);
                        bufferedWriterVotes.write(userID + " " + quoteID + " " + "U");
                        bufferedWriterVotes.newLine();
                        bufferedWriterVotes.close();
                        writerVotes.close();

                        Server.semaphoreVotesFile.release();

                        Server.semaphoreQuotesFile.acquire();
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
                                        id + " \"" + quote + "\" " + String.format("%d", Integer.parseInt(upvote) + 1)
                                                + " "
                                                + downvote);
                                bufferedWriter.newLine();
                            } else {
                                bufferedWriter.write(line);
                                bufferedWriter.newLine();
                            }
                        }

                        bufferedWriter.close();
                        Server.semaphoreQuotesFile.release();

                    } catch (IOException e) {
                        System.out.println(e);
                        Server.semaphoreVotesFile.release();
                        Server.semaphoreQuotesFile.release();
                    }
                } else {
                    throw new Exception("User has already voted the quote.");
                }
            } else {
                throw new Exception("Invalid user id.");
            }
        } else {
            throw new Exception("Invalid quote id.");
        }
    }

    protected static String getVotesByQuoteId(String quote_id) throws InterruptedException {
        String votes = "";
        try {
            Server.semaphoreVotesFile.acquire();
            Scanner in = new Scanner(new File(votesFileName));
            while (in.hasNext()) {
                String line = in.nextLine().trim();
                String[] params = line.split(" ");
                if (params[1].trim().compareTo(quote_id) == 0) {
                    votes = votes + getUsernameWithId(params[0].trim()) + " " + params[2].trim() + "\n";
                }

            }
            in.close();
        } catch (IOException e) {
            System.out.println(e);
        }
        Server.semaphoreVotesFile.release();
        return votes;
    }

    protected static String getUsernameWithId(String id) throws InterruptedException {
        try {
            Server.semaphoreUsersFile.acquire();
            Scanner in = new Scanner(new File(usersFileName));
            while (in.hasNext()) {
                String line = in.nextLine();
                String[] params = line.split(" ");
                if (id.compareTo(params[0]) == 0) {
                    Server.semaphoreUsersFile.release();
                    return params[1];
                }
            }
            in.close();
            Server.semaphoreUsersFile.release();
            return "";
        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreUsersFile.release();
            return "";
        }
    }

    protected static void add_quote(String quote, String userId) throws Exception {
        try {
            if (!checkUserExistsWithId(userId)) {
                throw new Exception("User not found");
            } else {
                Server.semaphoreQuotesFile.acquire();
                int numOfQuotes = 0;
                Scanner in = new Scanner(new File(usersFileName));
                while (in.hasNext()) {
                    in.nextLine();
                    numOfQuotes += 1;
                }
                in.close();
                numOfQuotes++;
                String username = getUsernameWithId(userId);
                FileWriter fileWriter = new FileWriter(quotesFileName, true);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
                bufferedWriter
                        .write(numOfQuotes + "-----" + username + "-----" + quote + "-----" + "0" + "-----" + "0");
                bufferedWriter.newLine();
                bufferedWriter.close();
                fileWriter.close();
                Server.semaphoreUsersFile.release();
            }

        } catch (IOException e) {
            System.out.println(e);
            Server.semaphoreUsersFile.release();
        }
    }
}
