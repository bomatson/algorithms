public class Solver {
  private class Node implements Comparable<Node> {
    private Board board;
    private Node previous;
    private int moveCount;

    public Node(Board board, Node previous) {
      this.board = board;
      this.previous = previous;
      if (previous == null) moveCount = 0;
      else moveCount = 1 + previous.moveCount;
    }

    @Override
    public int compareTo(Node other) {
      int priority = board.manhattan() + moveCount;
      int otherPriority = other.board.manhattan() + other.moveCount;
      if (priority < otherPriority) return -1;
      if (priority > otherPriority) return 1;
      return 0;
    }
  }

  private MinPQ<Node> pq;
  private MinPQ<Node> altPQ;
  private Node finalNode = null;
  private boolean solved = false;
  private boolean altSolved = false;

  public Solver(Board initial) {

    // build two queues, so at least one can be solved
    pq = new MinPQ<Node>();
    altPQ = new MinPQ<Node>();

    pq.insert(new Node(initial, null));
    altPQ.insert(new Node(initial.twin(), null));

    while (!solved && !altSolved) {
      solved = runSimulation(pq);
      altSolved = runSimulation(altPQ);
    }
  }

  private boolean runSimulation(MinPQ<Node> queue) {
    // don't snatch from an empty queue
    if (pq.isEmpty()) return false;

    // snatch the current node
    Node currentNode = queue.delMin();

    // I win the game!
    if (currentNode.board.isGoal()) {
      finalNode = currentNode;
      return true;
    }

    // since we didn't win, add the neighboring nodes with current as previous
    for (Board neighbor : currentNode.board.neighbors()) {

      // do not insert boards that match the current node's previous
      if (currentNode.previous == null
          || !currentNode.previous.board.equals(neighbor)) {
        queue.insert(new Node(neighbor, currentNode));
      }
    }
    return false;
  }

  public boolean isSolvable() {
    return solved;
  }

  public int moves() {
    if (solved) return finalNode.moveCount;
    return -1;
  }

  public Iterable<Board> solution() {

    if (!isSolvable()) return null;

    Stack<Board> solution = new Stack<Board>();
    Node nextNode = finalNode;

    for (int i = 0; i < moves(); i++) {
      solution.push(nextNode.board);
      nextNode = nextNode.previous;
    }

    return solution;
  }

  public static void main(String[] args) {

    // create initial board from file
    In in = new In(args[0]);
    int N = in.readInt();
    int[][] blocks = new int[N][N];
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        blocks[i][j] = in.readInt();
    Board initial = new Board(blocks);

    // solve the puzzle
    Solver solver = new Solver(initial);

    // print solution to standard output
    if (!solver.isSolvable())
      StdOut.println("No solution possible");
    else {
      StdOut.println("Minimum number of moves = " + solver.moves());
      for (Board board : solver.solution())
        StdOut.println(board);
    }
  }
}
