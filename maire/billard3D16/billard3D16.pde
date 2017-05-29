/* Billard3D16
 * fait par Jacques Maire le 10/02/2016
 */

import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.proscene.*;

Scene scene;
Arbre arbre;

public void setup() {
  size(600, 600, P3D);
  scene = new Scene(this);  
  scene.setRadius(2200);
  scene.showAll();
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);



  arbre=new Arbre(scene);
  noStroke();
  rectMode(CENTER);
  ellipseMode(RADIUS);
  frameRate(1000);
}



void draw() {
  background(0, 0, 255);
  pointLight(255, 255, 255, 0, 0, 1000);
  scene.camera().lookAt(new Vec());
  scene.camera().setPosition(0, 1200, 0);
  arbre.moteurBoite();
  for (InteractiveFrame frm : scene.frames()) {
    frm.draw();
  }
}