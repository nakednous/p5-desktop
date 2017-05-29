/**
 * Projectors
 * by Jean Pierre Charalambos.
 *
 * This example shows how perspective and orthographic projections work.
 *
 * Note that you can interact with everything, even with the eye representation
 * at the auxScene.
 *
 * Press 'h' to display the key shortcuts and mouse bindings in the console.
 * Press 'h' to switch between perspective and orthographics projections.
 */

import remixlab.dandelion.geom.*;
import remixlab.proscene.*;
import java.util.List;
import java.util.Arrays;

Scene scene, auxScene;
PGraphics canvas, auxCanvas;
InteractiveFrame frame1, auxFrame1;
InteractiveFrame iFrame;

int w = 800;
int h = 640;
boolean showMiniMap;

//Choose one of P3D for a 3D scene, or P2D or JAVA2D for a 2D scene
String renderer = P3D;
List<Vec> vertices = Arrays.asList(new Vec(50, -115, 0), new Vec(-70, -50, 0), new Vec(90, -45, 0));

void settings() {
  size(w, h, renderer);
}

void setup() {
  canvas = createGraphics(w, h, renderer);

  scene = new Scene(this, canvas);
  frame1 = new InteractiveFrame(scene, "frameDrawing");
  frame1.translate(30, 30);

  auxCanvas = createGraphics(w, h, renderer);
  auxScene = new Scene(this, auxCanvas);
  auxScene.setVisualHints(0);
  auxScene.setRadius(200);
  auxScene.showAll();

  auxFrame1 = new InteractiveFrame(auxScene);
  auxFrame1.set(frame1);

  iFrame = new InteractiveFrame(auxScene);
  //to not scale the iFrame on mouse hover uncomment:
  //iFrame.setHighlightingMode(InteractiveFrame.HighlightingMode.NONE);
  iFrame.setWorldMatrix(scene.eyeFrame());
  iFrame.setShape(scene.eyeFrame());
  smooth(8);
}

void draw() {
  InteractiveFrame.sync(scene.eyeFrame(), iFrame);
  InteractiveFrame.sync(frame1, auxFrame1);
  scene.beginDraw();
  canvas.background(120);
  scene.drawFrames();
  scene.endDraw();
  scene.display();
  if (showMiniMap) {
    noFill();
    strokeWeight(4);
    auxScene.beginDraw();
    auxCanvas.background(120);
    auxScene.drawFrames();
    // convert vertices from frame to world
    List<Vec> worldVertices = new ArrayList<Vec>();
    for (Vec v : vertices)
      worldVertices.add(frame1.inverseCoordinatesOf(new Vec(v.x(), v.y(), v.z())));
    auxScene.pg().pushStyle();
    auxScene.pg().stroke(0,255,0);
    auxScene.drawProjectors(scene.eye(), worldVertices);
    auxScene.pg().popStyle();
    auxScene.pg().fill(0, 0, 255, 125);
    auxScene.pg().stroke(0,0,255);
    auxScene.endDraw();
    auxScene.display();
  }
}

void keyPressed() {
  if (key == ' ') {
    showMiniMap = !showMiniMap;
    if(showMiniMap) {
      auxScene.eyeFrame().setWorldMatrix(scene.eyeFrame());
      scene.eyeFrame().matrix().print();
      auxScene.eyeFrame().matrix().print();
      /*
      auxScene.eyeFrame().setPosition(scene.eyeFrame().position());
      auxScene.eyeFrame().setOrientation(scene.eyeFrame().orientation());
      auxScene.eyeFrame().setMagnitude(scene.eyeFrame().magnitude());
      */
    }
    else {
      
    }
  }
  if(key == 'p') {
    scene.eyeFrame().matrix().print();
    auxScene.eyeFrame().matrix().print();
  }
}

void frameDrawing(PGraphics pg) {
  pg.fill(random(0, 255), random(0, 255), random(0, 255));
  pg.beginShape(TRIANGLES);
  for (Vec v : vertices)
    pg.vertex(v.x(), v.y());
  pg.endShape();
}