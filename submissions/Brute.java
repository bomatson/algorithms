import java.util.Collections;
import java.util.ArrayList;
import java.util.List;

public class Brute {
  public static void main(String[] args) {

    StdDraw.setXscale(0, 32768);
    StdDraw.setYscale(0, 32768);

    String filename = args[0];
    In in = new In(filename);

    int N = in.readInt();
    Point[] points = new Point[N];

    for (int i = 0; i < N; i++) {
      int x = in.readInt();
      int y = in.readInt();
      points[i] = new Point(x, y);
      points[i].draw();
    }

    for (int i = 0; i < N; i++) {

      for (int j = i + 1; j < N; j++) {
        double s1 = points[i].slopeTo(points[j]);

        for (int q = j + 1; q < N; q++) {
          double s2 = points[i].slopeTo(points[q]);

          if (s1 == s2) {
            for (int r = q + 1; r < N; r++) {
              double s3 = points[i].slopeTo(points[r]);

              if (s1 == s3) {

                List<Point> collinear = new ArrayList<Point>(4);
                collinear.add(points[i]);
                collinear.add(points[j]);
                collinear.add(points[q]);
                collinear.add(points[r]);

                // Collections.sort uses modified mergesort, guaranteed n log n
                // Also, compared using the point's compareTo
                // could use the Comparator here, but no need to

                Collections.sort(collinear);

                for (int c = 0; c < 3; c++) {
                  StdOut.print(collinear.get(c));
                  StdOut.print(" -> ");
                }

                StdOut.println(Collections.max(collinear));
                Collections.min(collinear).drawTo(Collections.max(collinear));
              }
            }
          }
        }
      }
    }
  }
}
