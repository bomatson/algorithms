import java.util.ArrayList;
import java.util.List;

public class PointSET {
  private SET<Point2D> collection;

  public PointSET() {
    collection = new SET<Point2D>();
  }

  public boolean isEmpty() {
    return collection.isEmpty();
  }

  public int size() {
    return collection.size();
  }

  public void insert(Point2D p) {
    collection.add(p);
  }

  public boolean contains(Point2D p) {
    return collection.contains(p);
  }

  public void draw() {
    for( Point2D p : collection) {
      StdDraw.point(p.x(), p.y());
    }
  }

  public Iterable<Point2D> range(RectHV rect) {
    // all points that are inside the rectangle
    List<Point2D> points = new ArrayList<Point2D>();

    for( Point2D point : collection) {
      if(rect.contains(point)) {
        points.add(point);
      }
    }

    return points;
  }

  public Point2D nearest(Point2D p) {
    Point2D closest = null;

    for( Point2D point : collection) {
      if(closest == null) {
        closest = point;
      } else if(point.distanceTo(p) < closest.distanceTo(p)) {
        closest = point;
      }
    }

    return closest;
  }

  public static void main(String[] args) {
    String filename = args[0];
    In in = new In(filename);
    StdDraw.show(0);

    // initialize the data structures with N points from standard input
    PointSET brute = new PointSET();
    /* KdTree kdtree = new KdTree(); */
    while (!in.isEmpty()) {
      double x = in.readDouble();
      double y = in.readDouble();
      Point2D p = new Point2D(x, y);
      /* kdtree.insert(p); */
      brute.insert(p);
    }

    double x0 = 0.0, y0 = 0.0;      // initial endpoint of rectangle
    double x1 = 0.0, y1 = 0.0;      // current location of mouse
    boolean isDragging = false;     // is the user dragging a rectangle

    // draw the points
    StdDraw.clear();
    StdDraw.setPenColor(StdDraw.BLACK);
    StdDraw.setPenRadius(.01);
    brute.draw();

    while (true) {
      StdDraw.show(40);

      // user starts to drag a rectangle
      if (StdDraw.mousePressed() && !isDragging) {
        x0 = StdDraw.mouseX();
        y0 = StdDraw.mouseY();
        isDragging = true;
        continue;
      }

      // user is dragging a rectangle
      else if (StdDraw.mousePressed() && isDragging) {
        x1 = StdDraw.mouseX();
        y1 = StdDraw.mouseY();
        continue;
      }

      // mouse no longer pressed
      else if (!StdDraw.mousePressed() && isDragging) {
        isDragging = false;
      }


      RectHV rect = new RectHV(Math.min(x0, x1), Math.min(y0, y1),
          Math.max(x0, x1), Math.max(y0, y1));
      // draw the points
      StdDraw.clear();
      StdDraw.setPenColor(StdDraw.BLACK);
      StdDraw.setPenRadius(.01);
      brute.draw();

      // draw the rectangle
      StdDraw.setPenColor(StdDraw.BLACK);
      StdDraw.setPenRadius();
      rect.draw();

      // draw the range search results for brute-force data structure in red
      StdDraw.setPenRadius(.03);
      StdDraw.setPenColor(StdDraw.RED);
      for (Point2D p : brute.range(rect))
        p.draw();

      // draw the range search results for kd-tree in blue
      /* StdDraw.setPenRadius(.02); */
      /* StdDraw.setPenColor(StdDraw.BLUE); */
      /* for (Point2D p : kdtree.range(rect)) */
      /*   p.draw(); */

      StdDraw.show(40);
    }
  }
}
