/*************************************************************************
 * Name:
 * Email:
 *
 * Compilation:  javac Point.java
 * Execution:
 * Dependencies: StdDraw.java
 *
 * Description: An immutable data type for points in the plane.
 *
 *************************************************************************/

import java.util.Comparator;

public class Point implements Comparable<Point> {

    public final Comparator<Point> SLOPE_ORDER =
      new SlopeOrder();

    private final int x;
    private final int y;

    public Point(int x, int y) {
        /* DO NOT MODIFY */
        this.x = x;
        this.y = y;
    }

    // plot this point to standard drawing
    public void draw() {
        /* DO NOT MODIFY */
        StdDraw.point(x, y);
    }

    // draw line between this point and that point to standard drawing
    public void drawTo(Point that) {
        /* DO NOT MODIFY */
        StdDraw.line(this.x, this.y, that.x, that.y);
    }

    // slope between this point and that point
    public double slopeTo(Point that) {
      if (that.x == x && that.y == y) return Double.NEGATIVE_INFINITY;
      else if (that.x == x) return Double.POSITIVE_INFINITY;
      else if (that.y == y) return 0.0;

      return ((double) (that.y - y)) / (that.x - x);
    }

    // is this point lexicographically smaller than that one?
    // comparing y-coordinates and breaking ties by x-coordinates
    public int compareTo(Point that) {
      int otherX = that.x;
      int otherY = that.y;

      if (this.y < otherY || (this.y == otherY && this.x < otherX)) return -1;
      if (this.y == otherY && this.x == otherX) return 0;
      return 1;
    }

    // return string representation of this point
    public String toString() {
        /* DO NOT MODIFY */
        return "(" + x + ", " + y + ")";
    }

    private class SlopeOrder implements Comparator<Point>
    {
      public int compare(Point a, Point b)
      {
          double slopeA = slopeTo(a);
          double slopeB = slopeTo(b);

          if (slopeA < slopeB) return -1;
          if (slopeA == slopeB) return 0;

          return 1;
      }
    }

    public static void main(String[] args) {
        /* YOUR CODE HERE */
    }
}
