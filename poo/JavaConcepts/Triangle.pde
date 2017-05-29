public class Triangle extends Figure implements Polygon {
  private float delta;
  
  public Triangle() {
    float delta = random(15, 30);
  }

  // abstract method in Figure
  public void display() {
    pushStyle();
    fill(rgb());
    triangle(x1_, y1_, x2_, y2_, x3_, y3_);
    popStyle();
  }

  // interface methods

  // method declared in Polygon interface
  public int numberOfSides() {
    return 3;
  }

  public void contour() {
    pushStyle();
    noFill();
    stroke(0, 0, 255);
    strokeWeight(3);
    float x1_ = position().x - delta;
    float y1_ = position().y + delta;
    float x2_ = position().x;
    float y2_ = position().y - delta;
    float x3_ = position().x + delta;
    float y3_ = position().y + delta;
    triangle(x1_, y1_, x2_, y2_, x3_, y3_);
    popStyle();
  }
}