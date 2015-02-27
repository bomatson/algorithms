import java.util.Arrays;

public class Fast {
  public static void main(String[] args) {
    StdDraw.setXscale(0, 32768);
    StdDraw.setYscale(0, 32768);
    StdDraw.setPenRadius(0.01);  // make the points a bit larger

    // read in the input
    String filename = args[0];
    In in = new In(filename);

    int N = in.readInt();
    Point[] points = new Point[N];
    Point lastPoint = null;

    for (int i = 0; i < N; i++) {
      int x = in.readInt();
      int y = in.readInt();
      points[i] = new Point(x, y);
    }

    // sort the natural points
    Arrays.sort(points);

    for (int i = 0; i < N; i++) {

      Point p = points[i];
      p.draw();

      // new aux array to walk through for each origin point
      Point[] slopeOrderPoints = points.clone();
      Arrays.sort(slopeOrderPoints, i, N, p.SLOPE_ORDER);

      int low = 0,
          high = 0;

      double lastSlope = p.slopeTo(slopeOrderPoints[i]);

      for (int k = i + 1; k < N; k++) {

        double currentSlope = p.slopeTo(slopeOrderPoints[k]);

        if (currentSlope == lastSlope) {
          high++;

        } else {
          if (high - low >= 2 && slopeOrderPoints[high] != lastPoint) {
            lastPoint = slopeOrderPoints[high];

            StdOut.print(p);

            for (int j = low; j <= high; j++)
              StdOut.print(" -> " + slopeOrderPoints[j]);

            StdOut.println();

            p.drawTo(slopeOrderPoints[high]);
          }

          low = k;
          high = k;
          lastSlope = currentSlope;
        }
      }

      if (high - low >= 2 && slopeOrderPoints[high] != lastPoint) {
        lastPoint = slopeOrderPoints[high];

        StdOut.print(p);

        for (int j = low; j <= high; j++)
          StdOut.print(" -> " + slopeOrderPoints[j]);

        StdOut.println();

        p.drawTo(slopeOrderPoints[high]);
      }
    }

    StdDraw.show(0);
  }
}
