import java.util.ArrayList;
import java.util.List;

public class Board {
  private final int n;
  private final int[][] blocks;

  public Board(int[][] blocks) {
    this(blocks, blocks.length);
  }

  private Board(int[][] blocks, int length) {
    this.n = length;
    this.blocks = new int[n][n];

    for (int row = 0; row < n; row++) {
      for (int col = 0; col < n; col++) {
        this.blocks[row][col] = blocks[row][col];
      }
    }
  }

  public int dimension() {
    return n;
  }

  public int hamming() {
    // number of tiles out of place
    int outOfPlace = 0;
    int currentPlace = 0;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        currentPlace++;
        if (blocks[i][j] == 0) continue;
        if (blocks[i][j] != currentPlace) {
          outOfPlace++;
        }
      }
    }
    return outOfPlace;
  }

  public int manhattan() {
    // (x1 - x0) + (y1 - y0)

    int manhattanDistance = 0;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (blocks[i][j] == 0) continue;
        else {
          int targetX = (blocks[i][j] - 1) % n;
          int targetY = (blocks[i][j] - 1) / n;
          int distanceToX = j - targetX;
          int distanceToY = i - targetY;

          manhattanDistance += Math.abs(distanceToX) + Math.abs(distanceToY);
        }
      }
    }
    return manhattanDistance;
  }

  public boolean equals(Object y) {
    if (y == this) return true;

    if (y == null) return false;

    if (y.getClass() != this.getClass()) return false;

    Board other = (Board) y;
    if (other.dimension() != n) return false;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (blocks[i][j] != other.blocks[i][j]) return false;
      }
    }

    return true;
  }

  public boolean isGoal() {
    int currentPlace = 1;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (blocks[i][j] != currentPlace++ && blocks[i][j] != 0) {
          return false;
        }
      }
    }
    return true;
  }

  public String toString() {
    StringBuilder s = new StringBuilder();
    s.append(n + "\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        s.append(String.format("%2d ", blocks[i][j]));
      }
      s.append("\n");
    }
    return s.toString();
  }

  public Iterable<Board> neighbors() {
    List<Board> boards = new ArrayList<Board>();
    int[] horizontalNeighbors = { 1, -1, 0, 0 };
    int[] verticalNeighbors = { 0, 0, 1, -1 };
    boolean neighborly = false;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (!(blocks[i][j] == 0)) continue;

        for (int c = 0; c < 4; c++) {
          int vert = i + verticalNeighbors[c];
          int horiz = j + horizontalNeighbors[c];

          if (vert >= 0 && horiz >= 0 && horiz < n && vert < n) {

            int [][] copy = new int[n][];
            for (int q = 0; q < n; q++) {
              copy[q] = blocks[q].clone();
            }

            copy[i][j] = blocks[vert][horiz];
            copy[vert][horiz] = blocks[i][j];

            Board awesomeNewBoard = new Board(copy);
            boards.add(awesomeNewBoard);
          }
        }

        neighborly = true;
        break;
      }
      if (neighborly) break;
    }
    return boards;
  }

  public Board twin() {
    // a board that is obtained by exchanging two adjacent blocks in the same row
    boolean adjacent = false;
    int [][] copy = new int[n][];
    for (int i = 0; i < n; i++) {
      copy[i] = blocks[i].clone();
    }

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n - 1; j++) {
        if (copy[i][j] == 0 || copy[i][j + 1] == 0) continue;
        int swap1 = copy[i][j + 1];
        int swap2 = copy[i][j];

        copy[i][j] = swap1;
        copy[i][j + 1] = swap2;

        adjacent = true;
        break;
      }
      if (adjacent) break;
    }

    return new Board(copy);
  }

  public static void main(String[] args) {
  }
}
