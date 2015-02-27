public class Subset {
    public static void main(String[] args) {
        int k = Integer.parseInt(args[0]);

        RandomizedQueue<String> queue = new RandomizedQueue<String>();
        for (int i = 0; i < k; i++) {
            String string = StdIn.readString();
            queue.enqueue(string);
        }

        for (int i = 0; i < k; i++) {
            System.out.println(queue.dequeue());
        }
        System.exit(0);
    }
}
