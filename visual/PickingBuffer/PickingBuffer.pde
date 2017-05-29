import remixlab.proscene.*;

Scene scene;
ArrayList<InteractiveFrame> list;
PGraphics canvas;
boolean pb = false;

void setup() {
  size(600,600,P3D);
  scene = new Scene(this);
  scene.setRadius(600);
  scene.showAll();
  list = new ArrayList<InteractiveFrame>();
  for (int i=0; i<100; i++) {
    list.add(new InteractiveFrame(scene,"drawCylinder"));
  }
  for(InteractiveFrame frame : list) {
    frame.setPosition(random(-400,400),random(-400,400),random(-400,400));
    frame.scale(0.4);
  }
  canvas = createGraphics(600,600,P3D);
}

void draw() {
  background(0);
  if(!pb) {
    int i = 0;
    for(InteractiveFrame frame : scene.frames()) {
      if(!frame.isEyeFrame()) {
        noStroke();
        fill(color(random(0,255), random(0,255), random(0,255)));
        frame.draw();
      }
    }
  }
  else {
    scene.beginScreenDrawing();
    image(scene.pickingBuffer(),0,0);
    scene.endScreenDrawing();
  }
}

void keyPressed() {
  if( key == ' ')
    pb = !pb;
}