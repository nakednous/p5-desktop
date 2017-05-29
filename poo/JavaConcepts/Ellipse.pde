public class Ellipse extends Figure {
  private float width_, height_;

  public Ellipse() {
    width_ = random(20, 50);
    height_ = random(20, 50);
  }

  // abstract method in Figure
  public void display() {
    pushStyle();
    fill(rgb());
    ellipse(position().x, position().y, width_, height_);
    popStyle();
  }
}