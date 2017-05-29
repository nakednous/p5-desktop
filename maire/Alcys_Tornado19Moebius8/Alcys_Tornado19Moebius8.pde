//spire torique
import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;

Scene scene;
Tore Tore;
int nfaces=6;//nfaces>1
int nbnoeud=100;
float     rayonTore=130;
float    rayonCercle=80;
void setup() {
  size(900, 800, P3D);
  scene=new Scene(this);
  scene.showAll();
  scene.setRadius(300); 
  scene.showAll();
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);
  
  Tore=new Tore();
}
void draw() {
  background(255);
  directionalLight(255, 255, 255, -1, -1, 0);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(255, 255, 0, 0, 0, 1);
  //lights();
  Tore.remplir();
  int kplus;
  for(int k=0;k<nfaces;k++){
   // color cc=(k%2==0)? color(255,255,0): color(255,0,0);
     kplus=(k==(nfaces-1))? 0: k+1;
  Tore.dessiner(k, kplus,color(255,255,0),color(255,255,200));
  }
 


 pushMatrix();
  scene.beginScreenDrawing();
  fill(0);
  text("nombre de faces :nfaces = "+nfaces, 20, 30, 0);
  text("rayon du cerceau: rayonTore = "+rayonTore, 20,50,0);
    text("rayon du cercle: rayonCercle = "+rayonCercle, 20,70,0);
  scene.endScreenDrawing(); 
  popMatrix();
  
  if (keyPressed) { 
    char letter=key;
 switch(letter) {
  case 'p': 
    saveFrame("logo-####.png");
    println("image png");
    break; 
  default:
    println("p pour sauver l'image");  
    break;
}
 }
}



class Tore {
  
  

  float angle=TWO_PI/nbnoeud;
  InteractiveFrame frame0, frame1;
  Vec[][] points;

  Tore() {

    frame0=new InteractiveFrame(scene);
    frame1=new InteractiveFrame(scene);
    frame1.setReferenceFrame(frame0);
    points=new Vec[nfaces][nbnoeud+1];
    ;
  }

  void remplir() { 

    for (int i=0;i<nbnoeud+1;i++) {


      pushMatrix();
      frame0.setOrientation(new Quat(new Vec(0, 0, 1), angle*i));
      frame0.applyTransformation();    
      frame1.setTranslation(new Vec(rayonTore, 0, 0));  
      frame1.setRotation(new Quat(new Vec(0, 1, 0), angle*i));
      frame1.applyTransformation();
      for(int m=0;m<nfaces;m++){
      points[m][i]=frame1.inverseCoordinatesOf(new Vec(rayonCercle*cos(m*TWO_PI/nfaces), 0, rayonCercle*sin(m*TWO_PI/nfaces) ));}
      popMatrix();
    }
  }

  void   dessiner(int a, int b,color c1,color c2) {
    noStroke();
    int jj,ii;
    beginShape(TRIANGLE_STRIP);
    for (int i=0;i<nbnoeud+1;i++) {
      if(i<nbnoeud){jj= i+1 ;ii=i;} else{ii=0;jj=1;}
     
      Vec n=dif(points[a][ii], points[b][ii]).cross(dif(points[a][ii], points[b][jj]));
      normal(n.x(), n.y(), n.z());
      fill(c1);
       vertex( 2*points[a][jj].x()- points[b][ii].x(), 2*points[a][jj].y()- points[b][ii].y(), 2*points[a][jj].z()- points[b][ii].z());
      //vertex( points[a][ii].x(), points[a][ii].y(), points[a][ii].z());
      fill(c2); 
      vertex( 2*points[b][jj].x()- points[a][ii].x(), 2*points[b][jj].y()- points[a][ii].y(), 2*points[b][jj].z()- points[a][ii].z());
    }
    endShape();
  }
}



//---------------------------------------------------------------

Vec dif(Vec u, Vec v) {
  return new Vec(u.x()-v.x(), u.y()-v.y(), u.z()-v.z());
}
void ligne(Vec u, Vec v) {
  line(u.x(), u.y(), u.z(), v.x(), v.y(), v.z());
}

//----------------------------------------------------------------