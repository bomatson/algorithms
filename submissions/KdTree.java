import java.util.ArrayList;
import java.util.List;

public class KdTree {
  private static class Node {
    private Point2D p;      // the point
    private RectHV rect;    // the axis-aligned rectangle corresponding to this node
    private Node lb;        // the left/bottom subtree
    private Node rt;        // the right/top subtree
    private boolean vert;   // is the level vertical

    public Node(final Point2D p, final boolean vert, final RectHV newRect) {
      this.p = p;
      this.vert = vert;
      this.rect = newRect;
    }

    @Override
    public String toString() {
      return "Node [vertical=" + vert
        + ", p=" + p + ", rect=" + rect
        + ", lb=" + lb + ", rt=" + rt + "]";
    }
  }

  private Node root;
  private int N;

  public KdTree() {
    this.N = 0;
  }

  public boolean isEmpty() {
    return (root == null);
  }

  public int size() {
    return N;
  }

  public void insert(Point2D p) {

    if(isEmpty()) {
      RectHV rect = new RectHV(p.x(), 0, p.x(), 1);
      root = new Node(p, true, rect);

      N++;
    } else if(!contains(p)) {

      Node parent = parent(root, p);
      boolean currentDirection = !parent.vert;
      RectHV parentRect = parent.rect;
      RectHV rect = null;

      if(lessThan(parent.p, p, parent.vert)) {

        if(parent.vert) {
          // less than parent, vertical, use x as max for rect
          /* StdOut.println("vertical, less than"); */
          rect = new RectHV(parentRect.xmin(), p.y(), parentRect.xmax(), p.y());
        } else {
          /* StdOut.println("horiz parent, less than p"); */
          /* StdOut.println("p: " + p); */
          /* StdOut.println("parent: " + parent); */
          /* StdOut.println("parentRect: " + parent.rect); */
          rect = new RectHV(p.x(), parentRect.ymin(), p.x(), parentRect.ymax());
        }

        parent.lb = new Node(p, currentDirection, rect);

      } else {

        if(parent.vert) {
          /* StdOut.println("vertical, greater than"); */
          rect = new RectHV(parentRect.xmin(), p.y(), 1, p.y());
        } else {
          /* StdOut.println("horiz, greater than"); */
          rect = new RectHV(p.x(), parentRect.ymax(), p.x(), 1);
        }

        parent.rt = new Node(p, currentDirection, rect);
      }

      N++;
    }
  }

  public boolean contains(Point2D p) {
    // does the set contain point p?
    if(isEmpty()) return false;
    if(root.p.equals(p)) return true;
    return find(root, p) != null;
  }

  private Node parent(Node node, Point2D p) {
    if(node == null) return node;
    Node match = null;

    if(lessThan(node.p, p, node.vert)) {
      if(node.lb == null) {
        match = node;
      } else {
        match = parent(node.lb, p);
      }
    } else {
      if(node.rt == null) {
        match = node;
      } else {
        match = parent(node.rt, p);
      }
    }
    return match;
  }

  private boolean lessThan(Point2D origin, Point2D other, boolean vert){
    // if the origin point is vertical, compare the origin x to the new x
    // if the origin point is horizontal, compare the origin y to the new y

    if(vert) return other.x() <= origin.x();
    else     return other.y() < origin.y();
  }

  private Node find(Node node, Point2D p) {
    if(node == null) return null;
    if(node.p.equals(p)) return node;

    Node match = null;
    if(lessThan(node.p, p, node.vert)) {
      match = find(node.lb, p);
    } else {
      match = find(node.rt, p);
    }

    return match;
  }

  public void draw() {
    keepDrawingFrom(root);
  }

  private void keepDrawingFrom(Node node) {
    if (node == null) return;

    StdDraw.setPenRadius(.02);
    StdDraw.point(node.p.x(), node.p.y());

    if(node.vert) StdDraw.setPenColor(StdDraw.RED);
    else StdDraw.setPenColor(StdDraw.BLUE);

    // draw a rectangle from node.rect
    StdDraw.setPenRadius(.01);

    StdDraw.line(node.rect.xmin(), node.rect.ymin(),
        node.rect.xmax(),node.rect.ymax());

    StdDraw.setPenColor(StdDraw.BLACK);

    keepDrawingFrom(node.lb);
    keepDrawingFrom(node.rt);
  }

  public Iterable<Point2D> range(RectHV rect) {
    List<Point2D> points = new ArrayList<Point2D>();

    intersection(root, rect, points);

    return points;
  }

  private void intersection(Node node, RectHV rect, List<Point2D> points) {

    if (node != null && rect.intersects(node.rect)) {
      if (rect.contains(node.p)) {
        points.add(node.p);
      }

      // only search subtrees if the rectangles intersect
      // current bug: look into insert rectangles - all are overlapping?
      /* if (!rect.intersects(rect)) return; */

      if (node.lb != null) intersection(node.lb, rect, points);
      if (node.rt != null) intersection(node.rt, rect, points);
    }
  }

  public Point2D nearest(Point2D p) {
    // a nearest neighbor in the set to point p; null if the set is empty
    return findClosest(p, root, root.p.distanceTo(p));
  }

  private Point2D findClosest(Point2D p, Node node, double closest) {
    Node left = node.lb;
    Node right = node.rt;
    double currentClosest = closest;
    Point2D champion = node.p;

    if (left != null && lessThan(left.p, p, node.vert)) {
      if (left.p.distanceTo(p) < currentClosest) {
        currentClosest = left.p.distanceTo(p);
        findClosest(p, left, currentClosest);
      }
    } else if (right != null && lessThan(right.p, p, node.vert)) {
      if (right.p.distanceTo(p) < currentClosest) {
        currentClosest = right.p.distanceTo(p);
        findClosest(p, right, currentClosest);
      }
    }

    return champion;
  }

  public static void main(String[] args) {

    String filename = args[0];
    In in = new In(filename);
    StdDraw.show(0);

    KdTree kdtree = new KdTree();
    while (!in.isEmpty()) {
      double x = in.readDouble();
      double y = in.readDouble();
      Point2D p = new Point2D(x, y);
      kdtree.insert(p);
    }

    Point2D p = new Point2D(0.7d, 0.2d);
    kdtree.insert(p);

    Point2D np = new Point2D(0.5d, 0.4d);
    kdtree.insert(np);

    Point2D ap = new Point2D(0.2d, 0.3d);
    kdtree.insert(ap);

    Point2D mp = new Point2D(0.4d, 0.7d);
    kdtree.insert(mp);

    Point2D gp = new Point2D(0.9d, 0.6d);
    kdtree.insert(gp);

    Point2D bp = new Point2D(0.2d, 0.8d);
    kdtree.insert(bp);
    // draw the points
    StdDraw.clear();
    StdDraw.setPenColor(StdDraw.BLACK);
    StdDraw.setPenRadius(.02);
    kdtree.draw();

    StdDraw.show(40);
    /* while(true) {} */
  }
}

