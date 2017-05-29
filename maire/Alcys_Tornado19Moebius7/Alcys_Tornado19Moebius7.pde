//spire torique
import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;

Scene scene;
Torus torus;

/*
int nfaces=2;//nfaces>1
int nbnodes=100;
float torusRadius=180;
float circleRadius=70;
*/

int nfaces=5;//nfaces>1
int nbnodes=100;
float torusRadius=180;
float circleRadius=120;

void setup() {
  size(600, 600, P3D);
  scene=new Scene(this);
  scene.showAll();
  scene.setRadius(300); 
  scene.showAll();
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);

  torus=new Torus();
}

void draw() {
  background(125);
  directionalLight(255, 255, 255, -1, -1, 0);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(255, 255, 0, 0, 0, 1);
  //lights();
  torus.cover();
  int kplus;
  for (int k=0;k<nfaces;k++) {
    color cc=(k%2==0)? color(255, 0, 255): color(0, 255, 0);
    kplus=(k==(nfaces-1))? 0: k+1;
    torus.draw(k, kplus, cc, cc);
  }
}

class Torus {
  float angle=TWO_PI/nbnodes;
  Frame frame0, frame1;
  Vec[][] points;

  Torus() {
    frame0=new Frame();
    frame1=new Frame();
    frame1.setReferenceFrame(frame0);
    points=new Vec[nfaces][nbnodes+1];
  }

  void cover() {
    for (int i=0;i<nbnodes+1;i++) {
      pushMatrix();
      frame0.setOrientation(new Quat(new Vec(0, 0, 1), angle*i));
      scene.applyTransformation(frame0);
      frame1.setTranslation(new Vec(torusRadius, 0, 0));  
      frame1.setRotation(new Quat(new Vec(0, 1, 0), angle*i));
      scene.applyTransformation(frame1);
      for (int m=0;m<nfaces;m++) {
        points[m][i]=frame1.inverseCoordinatesOf(new Vec(circleRadius*cos(m*TWO_PI/nfaces), 0, circleRadius*sin(m*TWO_PI/nfaces) ));
      }
      popMatrix();
    }
  }

  void draw(int a, int b, color c1, color c2) {
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int i=0;i<nbnodes;i++) {
      int j=i+1;
      Vec n = Vec.subtract(points[a][i], points[b][i]).cross(Vec.subtract(points[a][i], points[b][j]));
      normal(n.x(), n.y(), n.z());
      fill(c1);
      vertex( points[a][i].x(), points[a][i].y(), points[a][i].z());
      fill(c2); 
      vertex( points[b][j].x(), points[b][j].y(), points[b][j].z());
    }
    Vec n = Vec.subtract(points[a][0], points[b][0]).cross(Vec.subtract(points[a][0], points[b][1]));
    normal(n.x(), n.y(), n.z());
    fill(c1);
    vertex( points[a][0].x(), points[a][0].y(), points[a][0].z());
    fill(c2);  
    vertex( points[b][1].x(), points[b][1].y(), points[b][1].z()); 
    endShape();
  }
}