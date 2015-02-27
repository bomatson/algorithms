import java.util.Iterator;
import java.util.NoSuchElementException;

public class Deque<Item> implements Iterable<Item> {
    private Node head;
    private Node tail;
    private int length;

    private class Node {
        private Node prev = null;
        private Node next = null;
        private Item item;
    }

    public Deque() {
        this.head = null;
        this.tail = null;
        this.length = 0;
    }

    // is the deque empty?
    public boolean isEmpty() {
        return size() == 0;
    }

    public int size() {
        return this.length;
    }

    public void addFirst(Item item) {
        if (item == null) { throw new NullPointerException(); };
        Node node = new Node();
        node.item = item;

        if (this.head != null) {
            node.next = this.head;
            this.head.prev = node;
        }
        if (this.tail == null) { this.tail = node; }

        this.length++;
        this.head = node;
    }

    public void addLast(Item item) {
        if (item == null) { throw new NullPointerException(); };
        Node node = new Node();
        node.item = item;
        if (this.tail != null) {
            node.prev = this.tail;
            this.tail.next = node;
        }
        if (this.head == null) { this.head = node; }
        this.length++;
        this.tail = node;
    }

    public Item removeFirst() {
        if (this.isEmpty()) { throw new NoSuchElementException(); }
        Node removedHead = this.head;

        if (this.head.next == null) {
            this.head = null;
            this.tail = null;
        }
        else {
            this.head = this.head.next;
            if (this.tail.prev == removedHead) { this.tail.prev = null; }
            this.head.prev = null;
            removedHead.next = null;
        }

        this.length--;
        return removedHead.item;
    }

    public Item removeLast() {
        if (this.isEmpty()) { throw new NoSuchElementException(); }
        Node removedTail = this.tail;

        if (this.tail.prev == null) {
            this.head = null;
            this.tail = null;
        }
        else {
            this.tail = this.tail.prev;
            if (this.head.next == removedTail) { this.head.next = null; }
            this.tail.next = null;
            removedTail.prev = null;
        }

        this.length--;
        return removedTail.item;
    }

    public Iterator<Item> iterator() {
        return new DequeIterator(this.head);
    }

    public static void main(String[] args) {

    }

    private class DequeIterator implements Iterator<Item> {
        private Node currentNode;

        public DequeIterator(Node head) {
            this.currentNode = head;
        }

        @Override
        public boolean hasNext() {
            return currentNode != null;
        }

        @Override
        public Item next() {
            if (!hasNext()) { throw new NoSuchElementException(); }
            Node next = this.currentNode;
            this.currentNode = currentNode.next;
            return next.item;
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException();
        }
    };
}