import java.util.Iterator;
import java.util.NoSuchElementException;

public class RandomizedQueue<Item> implements Iterable<Item> {
    private Item[] items;
    private int length;

    public RandomizedQueue() {
        this.items = (Item[]) new Object[2];
        this.length = 0;
    }

    public boolean isEmpty() {
        return size() == 0;
    }

    public int size() {
        return this.length;
    }

    public void enqueue(Item item) {
        if (size() == items.length) resize(2 * items.length);
        this.items[this.length] = item;
        this.length++;
    }

    // delete and return a random item
    public Item dequeue() {
        if (isEmpty()) throw new NoSuchElementException();
        if (size() > 0 && size() == items.length / 4) resize(items.length / 2);

        int index = sampleIndex();
        Item randomItem = this.items[index];
        Item lastItem = this.items[size() - 1];
        this.items[index] = lastItem;
        this.items[size() - 1] = null;
        this.length--;

        return randomItem;
    }

    private void resize(int size) {
        assert size >= size();
        Item[] temp = (Item[]) new Object[size];

        for (int i = 0; i < size(); i++) {
            temp[i] = this.items[i];
        }
        this.items = temp;
    }

    // return (but do not delete) a random item
    public Item sample() {
        if (isEmpty()) throw new NoSuchElementException();
        return this.items[sampleIndex()];
    }

    private int sampleIndex() {
        return StdRandom.uniform(this.length);
    }

    // return an independent iterator over items in random order
    public Iterator<Item> iterator() {
        return new RandomizedQueueIterator();
    }

    // unit testing
    public static void main(String[] args) {

    }

    private class RandomizedQueueIterator implements Iterator<Item> {
        private Item[] iteratee;
        private int iterationIndex;

        public RandomizedQueueIterator() {
            this.iterationIndex = 0;
            this.iteratee = (Item[]) new Object[size()];

            for (int i = 0; i < size(); i++) {
                this.iteratee[i] = items[i];
            }
            StdRandom.shuffle(this.iteratee);
        }

        @Override
        public boolean hasNext() {
            return this.iterationIndex < this.iteratee.length;
        }

        @Override
        public Item next() {
            if (!hasNext()) throw new NoSuchElementException();
            Item nextItem = this.iteratee[this.iterationIndex];
            this.iterationIndex++;
            return nextItem;
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException();
        }
    }
}
