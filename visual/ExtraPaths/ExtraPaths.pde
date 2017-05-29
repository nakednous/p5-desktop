import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.bias.*;

Scene scene;

void setup() {
  size(600,600,P3D);
  scene = new Scene(this);
  scene.setKeyBinding(BogusEvent.CTRL, '6', "addKeyFrameToPath6");
  scene.setKeyBinding(BogusEvent.ALT, '6', "deletePath6");
  scene.setKeyBinding('6', "playPath6");
}

void draw() {
  background(0); 
}

public void addKeyFrameToPath6(Scene scn) {
  scn.eye().addKeyFrameToPath(6);
}

public void deletePath6(Scene scn) {
   scn.eye().deletePath(6);
}

public void playPath6(Scene scn) {
  scn.eye().playPath(6);
}