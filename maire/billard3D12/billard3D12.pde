/* Billard3D12
 * fait par Jacques Maire le 09/02/2016
 */

import remixlab.dandelion.constraint.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;

import remixlab.proscene.*;

Scene scene;
Arbre arbre;


public void setup() {
  size(600, 600, P3D);
  scene = new Scene(this);  
  scene.setRadius(1600);
  scene.showAll();
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);



  arbre=new Arbre(scene);

  for (InteractiveFrame frm : scene.frames())
    frm.setHighlightingMode(InteractiveFrame.HighlightingMode.NONE);

  noStroke();
  rectMode(CENTER);
  ellipseMode(RADIUS);
  frameRate(9);
}



void draw() {
  background(0, 0, 255);

  pointLight(255, 255, 255, 0, 1000, 0);
  pointLight(255, 255, 0, 0, 0, 1000);
  scene.camera().lookAt(new Vec() );
  scene.camera().setPosition(0, 1000, 300);
  arbre.moteurBoite();
  /*
  fill(255, 50, 150);
   scene.drawFrames();
   //*/
  ///*
  for (InteractiveFrame frm : scene.frames()) {
    fill(255, 50, scene.mouseAgent().inputGrabber() == frm ? 0 : 255);
    frm.draw(scene.pg());
  }
  //*/
  println(frameRate);
}