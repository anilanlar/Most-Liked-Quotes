import java.net.*;
import java.util.ArrayList;
import java.util.concurrent.Semaphore;

class Server {
    static Semaphore semaphoreUsersFile = new Semaphore(1);
    static Semaphore semaphoreVotesFile = new Semaphore(1);
    static Semaphore semaphoreQuotesFile = new Semaphore(1);

    public static void main(String argv[]) throws Exception
    {
        ArrayList<MyThread> threads = new ArrayList<>();
        ServerSocket welcomeSocket = new ServerSocket(8080);
        System.out.println("Server RUN");

        while (true) {
            Socket connectionSocket = welcomeSocket.accept();
            MyThread thread = new MyThread(connectionSocket);
            thread.start();
            threads.add(thread);
        }
    }
}