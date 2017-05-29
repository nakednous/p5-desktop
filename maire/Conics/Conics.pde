/** Conics
 *
 *  fait par Jacques Maire
 *
 *  jeudi 5 juin 2014
 *
 *  http://www.xelyx.fr , http:www.alcys.com
 *
 *  Deux faisceaux de droites se rencontrent
 *  Inspiration: Frank Ayres Projective Geometry Schaum's :chapitre 8
 **/





import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;



Scene scene;
Faisceau faisceau;
float temps;
AxisPlaneConstraint  planaireZ;
int nframes=4;
InteractiveFrame[] frames;

void setup() {
  size(700, 700, P3D); 
  scene=new Scene(this);
  scene.setRadius(1000);
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);
  scene.camera().setPosition(new Vec(0, 0, 800 ));

  rectMode(CENTER);

  planaireZ=new WorldConstraint();
  planaireZ.setRotationConstraintType(AxisPlaneConstraint.Type.FORBIDDEN);
  planaireZ.setTranslationConstraint(AxisPlaneConstraint.Type.PLANE, new Vec( 0.0f, 0.0f, 1.0f));



  frames=new InteractiveFrame[nframes];

  for (int i=0; i<nframes; i++) {
    frames[i]=new InteractiveFrame(scene);
  }
  frames[0].setPosition(0, -200, 0);//P
  frames[1].setPosition(-200, 0, 0);//R
  frames[2].setPosition(200, 0, 0);//S
  frames[3].setPosition(130, 300, 0);
  frames[0].setConstraint(planaireZ);
  frames[2].setConstraint(planaireZ);
  frames[3].setConstraint(planaireZ);
  frames[1].setConstraint(planaireZ);


  faisceau=new Faisceau();
}

void draw() { 
  temps=0.0001*millis();
  background(205, 200, 255);

lights();
lights();
  fill(0,0,255,40);
  rect(0, 0, 1200, 1200);

  faisceau.actualiser();
  for (int i=0; i<nframes; i++) {
    pushMatrix();
    frames[i].applyTransformation();
    fill(0);
    noStroke();
    sphere(10);
    popMatrix();
  }
  ligne(frames[0].position(), frames[1].position(), color(0, 255, 0));
  ligne(frames[0].position(), frames[2].position(), color(0, 255, 0));
  ligne(frames[2].position(), frames[3].position(), color(0));
  ligne(frames[1].position(), frames[3].position(), color(0));
}



void ligne(Vec fro, Vec too, color c ) {
  stroke(c);
  line(fro.x(), fro.y(), fro.z(), too.x(), too.y(), too.z());
}



Vec comb(float t1, Vec v1, float t2, Vec v2) {
  Vec res=Vec.add(Vec.multiply(v1, t1), Vec.multiply(v2, t2));
  return res;
}



Vec comb(float t1, Vec v1, float t2, Vec v2, float t3, Vec v3) {
  Vec res=Vec.add(Vec.add(Vec.multiply(v1, t1), Vec.multiply(v2, t2)), Vec.multiply(v3, t3));
  return res;
}



Vec barycentre(float lamb, Vec u, Vec v) {
  return comb(1-lamb, u, lamb, v);
}



float determinant(Vec u, Vec v) {
  return u.x()*v.y()-u.y()*v.x();
}


Vec inter2Lines(Vec f1, Vec t1, Vec f2, Vec t2) {
  Vec dir1=Vec.subtract(t1, f1);
  Vec dir2=Vec.subtract(t2, f2);
  float de=determinant(dir2, dir1); 
  Vec ab=Vec.subtract(f2, f1);
  float lambda = determinant(ab, dir1)/de;
  return comb(1, f2, -lambda, dir2);
} 




void balle(Vec p, float r, color c) {
  pushMatrix();
  translate(p.x(), p.y(), p.z()+100);
  
 
   fill(255);
  box(3, 3, 100);
  noStroke();
  fill(255,255,0);
   translate(0,0,50);
  sphere(r);
  popMatrix();
}