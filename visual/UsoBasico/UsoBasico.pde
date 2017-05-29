import remixlab.proscene.*;
import remixlab.bias.event.*;

Scene scene;
InteractiveFrame f1, f2;
PShape s;

void setup() {
  size(600,600,P3D);
  scene = new Scene(this);
  // modo retenido
  s = createShape(BOX,30);
  s.fill(255,255,0);
  scene.loadConfig();
  f1 = new InteractiveFrame(scene);
  f1.setPickingPrecision(InteractiveFrame.PickingPrecision.EXACT);
  f1.setMotionBinding(LEFT, "translate");
  f2 = new InteractiveFrame(scene, f1);
  f2.setPosition(50,50,50);
  f1.setShape("figura");
  f2.setShape(s);
  f2.setClickBinding(RIGHT,1,"comportamiento");
}

void comportamiento(InteractiveFrame f, ClickEvent event) {
  println("Hola gente como va la causa!");
}

// modo inmediato
void figura(PGraphics pg) {
  pg.fill(0,0,255);
  pg.sphere(30);
}

void draw() {
  background(0);
  scene.drawFrames();
}

void keyPressed() {
  scene.saveConfig();
  if(key=='p')
    println(f1.info());
}