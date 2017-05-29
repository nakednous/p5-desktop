import remixlab.proscene.*;

Scene scene, auxScene;
PGraphics canvas, auxCanvas;  
InteractiveFrame frame1, auxFrame1, frame2, auxFrame2, frame3, auxFrame3;
InteractiveFrame iFrame;

int w = 1110;
int h = 510;
int oW = w/3;
int oH = h/3;
int oX = w - oW;
int oY = h - oH;
boolean showMiniMap  = true;

//Choose FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void settings() {
  size(w, h, renderer);
}

void setup() {
  canvas = createGraphics(w, h, renderer);
  scene = new Scene(this, canvas);
  frame1 = new InteractiveFrame(scene);
  frame1.setHighlightingMode(InteractiveFrame.HighlightingMode.FRONT_PICKING_SHAPES);
  frame1.setFrontShape(frameShape(true));
  frame1.setPickingShape(frameShape(false));
  frame1.translate(-30, -30);
  frame2 = new InteractiveFrame(scene, frame1);
  frame2.setHighlightingMode(InteractiveFrame.HighlightingMode.FRONT_PICKING_SHAPES);
  frame2.setFrontShape(frameShape(true));
  frame2.setPickingShape(frameShape(false));
  frame2.translate(60, 0);
  frame3 = new InteractiveFrame(scene, frame2);
  frame3.setHighlightingMode(InteractiveFrame.HighlightingMode.FRONT_PICKING_SHAPES);
  frame3.setFrontShape(frameShape(true));
  frame3.setPickingShape(frameShape(false));
  frame3.translate(60, 0);

  auxCanvas = createGraphics(oW, oH, renderer);
  auxScene = new Scene(this, auxCanvas, oX, oY);
  auxScene.setVisualHints(0);
  auxScene.setRadius(200);
  auxScene.showAll();

  auxFrame1 = new InteractiveFrame(auxScene);
  auxFrame1.set(frame1);
  auxFrame1.setHighlightingMode(InteractiveFrame.HighlightingMode.FRONT_PICKING_SHAPES);
  auxFrame2 = new InteractiveFrame(auxScene, auxFrame1);
  auxFrame2.set(frame2);
  auxFrame2.setHighlightingMode(InteractiveFrame.HighlightingMode.FRONT_PICKING_SHAPES);
  auxFrame3 = new InteractiveFrame(auxScene, auxFrame2);
  auxFrame3.set(frame3);
  auxFrame3.setHighlightingMode(InteractiveFrame.HighlightingMode.FRONT_PICKING_SHAPES);

  iFrame = new InteractiveFrame(auxScene);
  //to not scale the iFrame on mouse hover uncomment:
  //iFrame.setHighlightingMode(InteractiveFrame.HighlightingMode.NONE);
  iFrame.setWorldMatrix(scene.eyeFrame());
  iFrame.setShape(scene.eyeFrame());
}

void draw() {
  InteractiveFrame.sync(scene.eyeFrame(), iFrame);
  InteractiveFrame.sync(frame1, auxFrame1);
  InteractiveFrame.sync(frame2, auxFrame2);
  InteractiveFrame.sync(frame3, auxFrame3);
  scene.beginDraw();
  canvas.background(0);
  scene.drawFrames();
  scene.endDraw();
  scene.display();
  if (showMiniMap) {
    auxScene.beginDraw();
    auxCanvas.background(29, 153, 243);
    auxScene.pg().fill(255, 0, 255, 125);
    auxScene.drawFrames();
    auxScene.endDraw();
    auxScene.display();
  }
}

void keyPressed() {
  if (key == ' ')
    showMiniMap = !showMiniMap;
  if (key == 'x')
    iFrame.setShape("eyeDrawing");
  if (key == 'y')
    iFrame.setShape(scene.eyeFrame());
}

PShape frameShape(boolean front) {
  PShape s = createShape();
  s.beginShape();
  if(front)
    s.fill(255,0,0);
  else
    s.fill(0,255,0);
  s.noStroke();
  s.vertex(0, 0);
  s.vertex(0, 50);
  s.vertex(50, 50);
  s.vertex(50, 0);
  s.endShape(CLOSE);
  return s;
}

void eyeDrawing(PGraphics pg) {
  if (auxScene.is3D())
    pg.box(200);
  else {
    pg.pushStyle();
    pg.rectMode(CENTER);
    pg.rect(0, 0, 200, 200);
    pg.popStyle();
  }
}