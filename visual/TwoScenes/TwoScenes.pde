/**
This sketch shows how geometric transformations could be regarded as
changing the frame (coordinate system) of reference. It also shows how
to use a matrix stack of transformations to "navigate" among frames.
See: http://processing.org/reference/pushMatrix_.html

A scene graph is just a hierarchy of nested frames. Here we implement
the following scene graph:

    W
    ^
    |
    |   
    L1
    ^
    |
    |
    L2

As you could see, there's no camera node, and there's no interactivity whatsoever.
That's next lab!

Using off-screen rendering we draw the above scene twice.
See: http://processing.org/reference/PGraphics.html

Press any key and see what happens.

 -jp
*/

PFont font;
PGraphics canvas1, canvas2;
String renderer = P2D;
// if opengl is not supported comment the prev line and uncomment this:
//String renderer = JAVA2D;
//dim
int w = 640;
int h = 720;
boolean withMatrixStack = false;

void setup() {
  size(640, 720, renderer);
  canvas1 = createGraphics(width, height/2, renderer);
  canvas2 = createGraphics(width, height/2, renderer);
  font = createFont("Arial", 12);
  textFont(font, 12);
}

public void draw() {
  background(255);
  canvas1.beginDraw();
  canvas1.background(255);
  // call scene off-screen rendering on canvas 1
  if (withMatrixStack)
    drawScene(canvas1);
  else
    drawSceneWithoutMatrixStack(canvas1);
  canvas1.endDraw();
  // draw canvas onto screen
  image(canvas1, 0, 0);

  canvas2.beginDraw();
  canvas2.background(255);
  // call scene off-screen rendering on canvas 1
  if (withMatrixStack)
    drawScene(canvas2);
  else
    drawSceneWithoutMatrixStack(canvas2);
  canvas2.endDraw();
  // draw canvas onto screen
  image(canvas2, 0, 360);
}

void drawScene(PGraphics pg) {
  // draw world coord sys axes
  drawAxis(pg, 1);
  // draw a rect in the world coord sys
  pg.fill(0, 255, 255);
  pg.rect(0, 0, 30, 10, 5);
  // define a local coordinate system (L1)
  pg.pushMatrix();
  pg.translate(150, 120);
  pg.rotate(QUARTER_PI / 2);  
  // draw a second rect respect to the local coordinate system
  drawAxis(pg, 0.4f);
  pg.fill(255, 0, 255);
  pg.rect(0, 0, 30, 10, 5);
  // define a second local coor sys define respect to the other local sys (L2)
  pg.pushMatrix();
  pg.translate(100, 100);
  pg.rotate(-QUARTER_PI);
  // draw a third rect respect to the local coordinate system
  drawAxis(pg, 0.4f);
  pg.fill(255, 255, 0);
  pg.rect(0, 0, 30, 10, 5);
  // "return" to the world coord sys
  pg.popMatrix();
  pg.popMatrix();
  // draw a triangle respect to the world coord sys
  pg.fill(0, 255, 0);
  pg.triangle(30, 75, 58, 20, 86, 75);
}

void drawSceneWithoutMatrixStack(PGraphics pg) {
  // draw world coord sys axes
  drawAxis(pg, 1);
  // draw a rect in the world coordinate system
  pg.fill(0, 255, 255);
  pg.rect(0, 0, 30, 10, 5);
  // define a local coordinate system
  pg.translate(150, 120);
  pg.rotate(QUARTER_PI / 2);
  // draw a second rect respect to the local coordinate system
  drawAxis(pg, 0.4f);
  pg.fill(255, 0, 255);
  pg.rect(0, 0, 30, 10, 5);
  // define a second local coor sys define respect to the other local system
  pg.translate(100, 100);
  pg.rotate(-QUARTER_PI);
  // draw a third rect respect to the local coordinate system
  drawAxis(pg, 0.4f);
  pg.fill(255, 255, 0);
  pg.rect(0, 0, 30, 10, 5);

  // Now that we haven't recorded our sequence of transformations
  // there's no simple way to draw this triangle respect to the world coordinate system
  pg.fill(0, 255, 0);
  pg.triangle(30, 75, 58, 20, 86, 75);
}

void drawAxis(PGraphics pg) {
  drawAxis(pg, 1);
}

void drawAxis(PGraphics pg, float s) {
  // X-Axis
  pg.strokeWeight(2);
  pg.stroke(255, 0, 0);
  pg.fill(255, 0, 0);
  pg.line(0, 0, 100 * s, 0);
  pg.text("X", 100 * s + 5, 0);
  // Y-Axis
  pg.stroke(0, 0, 255);
  pg.fill(0, 0, 255);
  pg.line(0, 0, 0, 100 * s);
  pg.text("Y", 0, 100 * s + 15);
}

void keyPressed() {
  withMatrixStack = !withMatrixStack;
}