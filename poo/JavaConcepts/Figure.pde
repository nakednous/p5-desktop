public abstract class Figure {
  private PVector pos_;
  private color color_;

  public Figure() {
    setPosition();
    setColor();
  }

  public PVector position() {
    return pos_;
  }

  public void setPosition() {
    setPosition(new PVector(random(30, width-30), random(30, height-30)));
  }

  public void setPosition(PVector pos) {
    pos_ = pos;
  }

  public void setColor() {
    setColor(color(random(0, 255), random(0, 255), random(0, 255)));
  }

  public void setColor(color c) {
    color_ = c;
  }

  public color rgb() {
    return color_;
  }

  public abstract void display();
}