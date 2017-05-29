public class Rect extends Figure implements Polygon {
  private float width_, height_;

  public Rect() {
    width_ = random(20, 50);
    height_ = random(20, 50);
  }

  // abstract method in Figure
  public void display() {
    pushStyle();
    fill(rgb());
    rect(position().x, position().y, width_, height_);
    popStyle();
  }

  // interface methods

  // method declared in Polygon interface
  public int numberOfSides() {
    return 4;
  }

  public void contour() {
    pushStyle();
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    rect(position().x, position().y, width_, height_);
    popStyle();
  }
}