/**
 * Ceva 14/02/2014
 */

import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;

Scene scene;
Ceva ceva;
boolean stop, onScreen;
float slideX=50;
float temps=0;
PFont font;
color col;

void setup() {
  size(640, 640, P3D);
  scene =new Scene(this);
  scene.setRadius(500);
  scene.camera().setType(Camera.Type.ORTHOGRAPHIC);
  scene.camera().setPosition(new Vec(0, 0, 500));
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);
  colorMode(RGB, 255);
  ceva=new Ceva();
  onScreen=false;
  font = loadFont("FreeSans-16.vlw");
  textFont(font);
  col=#44ff44;
}

void draw() {
  background(255);//255, 200, 0

  ceva.cevaDraw();
  //utilisation du code de Jean-Pierre Charalambos de l'exemple ScreenDrawing
  scene.beginScreenDrawing();
  pushStyle();
  fill(250, 50);
  noStroke();
  rect(0, height-140, width, 140);
  stroke(255, 0, 0);
  fill(255, 255, 150, 100);
  rect(50, height-55, slideX-40, 10);
  strokeWeight(4);
  fill(col);
  ellipse(20, height-20, 30, 30); 
  noFill();
  triangle(slideX+30, height-50, slideX+10, height-70, slideX+10, height-30);
  fill(0);
  text(temps, slideX+30, height-45);
  popStyle();
  scene.endScreenDrawing();

  scene.beginScreenDrawing();
  fill(0);
  textFont(font);
  text( "Comprendre le théorème de CEVA en moins de 15 secondes", 20, 30);
  if (onScreen)
  { 
    text("Click the blue button to handle 3d scene ", 50, height-15);
    col=#7777ff;
  }
  else {
    text("Click the green button to handle Timeline", 50, height-15);
    col=#44ff44;
  }    
  scene.endScreenDrawing();
}


void mouseDragged() {
  if (!scene.isMouseAgentEnabled())
    slideX=constrain(mouseX, 50, width-80);
  temps=map(slideX, 50, width-80, 0, 15);
}

void mouseReleased() {
  float y=mouseY;
  float x=mouseX;
  float dis=sqrt(sq(x-20)+sq(y-height+20));
  if (dis<30) {
    if (scene.isMouseAgentEnabled())
      scene.disableMouseAgent();
    else
      scene.enableMouseAgent();
    onScreen = !onScreen;
  }
}

//-------------------------------------------- 
class Ceva {
  InteractiveFrame[] reperes ;
  InteractiveFrame frame0;

  AxisPlaneConstraint  contraintePlane;
  Vec[] points, pieds, dirCotes, dirCeva, outPoints;

  String letexte;
  String lettres="a1a3a2b1b3b2";
  int nbEtapes=8;
  int etape=0;
  int nbCouleurs=13;
  int[][]  etapesAlphas;  
  int[] couleurs;
  PFont font;

  Ceva() {
    frame0=new InteractiveFrame(scene);
    reperes=new InteractiveFrame[4];
    points   =new Vec[4];
    pieds    =new Vec[4];
    dirCotes =new Vec[4];
    dirCeva  =new Vec[4];
    outPoints =new Vec[4];
    couleurs =new int[nbCouleurs];
    font = loadFont("FreeSans-16.vlw");
    textFont(font);

    contraintePlane=new WorldConstraint();
    contraintePlane.setTranslationConstraint(AxisPlaneConstraint.Type.PLANE, new Vec(0.0f, 0.0f, 1.0f));
    contraintePlane.setRotationConstraint(AxisPlaneConstraint.Type.FORBIDDEN, new Vec(0.0f, 0.0f, 0.0f));

    for (int i=0;i<4;i++) {
      reperes[i]=new InteractiveFrame(scene);
      reperes[i].setConstraint(contraintePlane);
    }

    reperes[0].setTranslation(20, -height/15, 0); 
    reperes[1].setTranslation( width/14, -height/3, 0); 
    reperes[2].setTranslation( width/3, height/4-20, 0); 
    reperes[3].setTranslation(- width/3+10, height/10-10, 0);
  }



  void cevaDraw() {

    remplirCouleurs();
    //directionalLight(255, 255, 255, 0, -1, -1);
    //  directionalLight(250, 250, 250,0, -1, -1);
    lights();
    //calculerPoints() 
    for ( int i=0;i<4;i++) {         
      pushMatrix();
      reperes[i].applyTransformation();
      points[i]=reperes[i].position();
      popMatrix();
    }
    // calculerPiedsEtOutPoints
    pieds[3]=intersection(3, 1, 2);
    pieds[2]=intersection(2, 3, 1);
    pieds[1]=intersection(1, 2, 3);
    outPoints[3]= outIntersection( 3, 2);
    outPoints[2]= outIntersection( 2, 3);
    outPoints[0]=comb(2, points[3], -1, outPoints[2]);//point K= sym2(J)

    // le graphisme

    drawTriangleABC();
    dessinPiedsPoints();

    drawArrowsCote() ;
    drawParalleles();   
    drawOut();  

    drawArrowsOut();
    drawTrianglesARO_IRC();
    drawTrianglesJBQ_OAQ();

    drawhomothetieO();
    conclusion();

    texte(etape);
  }  


  void drawTriangleABC() {
    placeSphere(points[0], #ffffff, 8);
    placeSphere(points[1], #ffffff, 8);
    placeSphere(points[2], #ffffff, 8);
    placeSphere(points[3], #ffffff, 8);
    stroke(0, 0, 255);
    strokeWeight(4);
    triangleC(-2, points[1], points[2], points[3], #ffffff, #ffffff, #ffffff);
    etape =0;
    letexte="on se donne 4 points interactifs par draguage : un triangle ABC et un point O";
  }


  void dessinPiedsPoints() {
    if (temps>2) {
      stroke(couleurs[1]);
      strokeWeight(1);

      ligne(points[3], pieds[3]);
      ligne(points[2], pieds[2]);          
      ligne(points[1], pieds[1]);
      placeSphere(pieds[1], couleurs[1], 6);
      placeSphere(pieds[2], couleurs[1], 6);
      placeSphere(pieds[3], couleurs[1], 6);
      etape=1;
      letexte="On trace les droites passant par des sommets et par O. Ces droites sont les céviennes de O";
    }
  }

  void drawArrowsCote() { 
    if (temps>3) {
      noStroke();
      for (int i=1;i<4;i++) {      
        int j=(i==3)? 1 : i+1; 
        fleche( pieds[6-i-j], points[i], couleurs[1]);
        drawText(" "+lettres.charAt(2*i-2)+lettres.charAt(2*i-1), comb(0.5, points[i], 0.5, pieds[6-i-j]));
      }
      for (int i=1;i<4;i++) {      
        int j=(i==3)? 1 : i+1;       
        fleche( pieds[6-i-j], points[j], couleurs[11]);
        drawText(" "+lettres.charAt(2*i+4)+lettres.charAt(2*i+5), comb(0.5, points[j], 0.5, pieds[6-i-j]));
      }
      etape=2;
      letexte= "Ces droites coupent les côtés dans les rapports b1/a1  b2/a2 b3/a3";
    }
  }

  void drawParalleles() {
    if (temps>4) {
      stroke(couleurs[3]);
      Vec dir=Vec.subtract(points[0], points[1]);
      ligne(points[1], dir, 3.0);
      ligne(points[2], dir, 3.0);
      ligne(points[3], dir, 3.0);
      etape=3;
      letexte=" On trace les parallèles à la droite (OA) qui passent par les autres sommets";
    }
  }




  void drawOut() {
    if (temps>5) {
      stroke(couleurs[0]);
      ligne( outPoints[3], pieds[3]);
      ligne( outPoints[2], pieds[2]);
      placeSphere(outPoints[2], couleurs[0], 4);
      placeSphere(outPoints[3], couleurs[0], 4);
      etape=4;
      letexte="Les céviennes differentes de (OA) coupent les parallèles rouges à (OA)";
    }
  }

  void drawArrowsOut() { 
    if (temps>=6 && temps<=7) {
      fleche( points[3], outPoints[2], couleurs[3]); 
      drawText("V3 ", comb(0.5, points[3], 0.5, outPoints[2]));
      fleche(points[2], outPoints[3], couleurs[3]); 
      drawText("V1 ", comb(0.5, points[2], 0.5, outPoints[3]));    
      fleche(points[1], points[0], couleurs[3]);
      drawText("V2 ", comb(0.5, points[1], 0.5, points[0]));
      etape=5; 
      letexte="Les vecteurs V1, V2, V3 sont représentés par les flêches rouges" ;
    }
  }

  void drawTrianglesARO_IRC() {
    if (temps>7 ) {
      noStroke(); 
      triangleC(-1, points[2], pieds[3], outPoints[3], couleurs[8], couleurs[8], couleurs[7]);
      triangleC(-1, points[1], pieds[3], points[0], couleurs[7], couleurs[8], couleurs[8]);
      fleche(points[2], outPoints[3], couleurs[3]); 
      drawText("V1 ", comb(0.5, points[2], 0.5, outPoints[3]));    
      fleche(points[1], points[0], couleurs[3]);
      drawText("V2 ", comb(0.5, points[1], 0.5, points[0]));
      drawText("V2 = (a1/b1)*V1", comb(0.8, points[1], 0.2, outPoints[3]));
      letexte="Les triangles verts sont homothétiques . les vecteurs V2 et V1 sont dans le rapport a1/b1";
      etape=6;
    }
  }
  void drawTrianglesJBQ_OAQ() {
    if (temps>8) {
      noStroke();
      triangleC(-1, points[3], pieds[2], outPoints[2], couleurs[5], couleurs[6], couleurs[5]);
      triangleC(-1, points[1], pieds[2], points[0], couleurs[5], couleurs[6], couleurs[5]);
      fleche( points[3], outPoints[2], couleurs[3]); 
      drawText("V3 ", comb(0.5, points[3], 0.5, outPoints[2]));

      fleche(points[1], points[0], couleurs[3]);
      drawText("V2 ", comb(0.5, points[1], 0.5, points[0]));
      drawText("V3 = (a2/b2)*V2", comb(0.2, points[1], 0.8, outPoints[2]));
      etape=7;   
      letexte="Les triangles rouges sont homothétiques . les vecteurs V3 et V2 sont dans le rapport a2/b2 ";
    }
  }
  void drawhomothetieO() {
    if (temps>9 ) {
      Vec v1 = Vec.multiply(outPoints[3], 1.05);
      Vec v2 = Vec.multiply(points[2], 1.05);
      fleche(v1, v2, couleurs[3]); 
      drawText("-V1 ", comb(0.3, v1, 0.7, v2));
      fleche(points[3], outPoints[2], couleurs[3]); 
      drawText("V3 ", comb(0.5, points[3], 0.5, outPoints[2]));  
      triangleC(-1, points[0], outPoints[3], points[2], couleurs[10], couleurs[10], couleurs[9]);
      triangleC(-1, points[3], points[0], outPoints[2], couleurs[10], couleurs[10], couleurs[9]);
      drawText("-V1 = (a3/b3)*V3", comb(0.1, points[2], 0.6, points[3]));
      etape=8;
      letexte= "Les triangles bleus sont homothétiques. V3 et -V1 sont dans le rapport a3 / b3 ";
    }
  } 
  void conclusion() {
    if (temps>10)
    { 
      letexte=" ";
      texteFinal("Comme -V1 = (a3/b3)*V3 et V3 = (a2/b2)*V2 et V2 = (a1/b1)*V1", 30, height-120) ;
      texteFinal("il en découle -V1 = (a3/b3)*(a2/b2)*(a1/b1)*V1", 30, height-100) ;
      texteFinal("donc -1 =a1*a2*a3/b1*b2*b3 qui la relation de Ceva pour les céviennes issues de O", 30, height-80) ;

      etape = 9;
    }
  }







  float det(float a, float b, float ap, float bp) {
    return a*bp-ap*b;
  }

  Vec cramer(float a, float b, float c, float ap, float bp, float cp) {
    float d=det(a, ap, b, bp);
    float dx=det(c, cp, b, bp);
    float dy=det(a, ap, c, cp);
    return new Vec(dx/d, dy/d, 0);
  }

  Vec intersection(int k, int i, int j) {
    Vec f1=points[i];
    Vec f2=points[j];
    Vec f3=points[k];
    Vec f1f2=Vec.subtract(points[j], points[i]);
    Vec f0f3=Vec.subtract(points[k], points[0]);   
    f1f2.normalize();
    f0f3.normalize();
    dirCotes[k]=f1f2;
    dirCeva[k]=f0f3;
    dirCeva[k].normalize();
    return cramer(-f1f2.y(), f1f2.x(), -f1f2.y()*f1.x()+f1f2.x()*f1.y(), 
    -f0f3.y(), f0f3.x(), -f0f3.y()*f3.x()+f0f3.x()*f3.y());
  }


  Vec outIntersection(int k, int i) {    
    Vec p=points[i];
    Vec q=points[k];
    Vec u=dirCeva[1];
    Vec v=dirCeva[k];
    Vec pq=Vec.subtract(q, p);  
    u.normalize();
    v.normalize();  
    return cramer(-u.y(), u.x(), -u.y()*p.x()+u.x()*p.y(), 
    -v.y(), v.x(), -v.y()*q.x()+v.x()*q.y());
  }


  void triangleC(float cor, Vec u, Vec v, Vec w, color c1, color c2, color c3) {
    beginShape();
    fill(c1);
    vertex( u.x(), u.y(), u.z()+cor);
    fill(c2);              
    vertex(v.x(), v.y(), v.z()+cor);
    fill(c3);    
    vertex(w.x(), w.y(), w.z()+cor);
    endShape(CLOSE);
  }

  void placeSphere(Vec v, color c, float r) {
    pushMatrix();     
    translate(v.x(), v.y(), v.z());
    fill(c);
    noStroke();
    sphere(r); 
    popMatrix();
  }


  Vec comb(float t1, Vec v1, float t2, Vec v2) {
    Vec res=Vec.add(Vec.multiply(v1, t1), Vec.multiply(v2, t2));
    return res;
  }

  void ligne(Vec u, Vec v) {
    line(u.x(), u.y(), u.z(), v.x(), v.y(), v.z());
  }



  void ligne(Vec u, Vec d, float a) {
    strokeWeight(4);
    line(u.x()-a*d.x(), u.y()-a*d.y(), u.z()-a*d.z(), u.x()+a*d.x(), u.y()+a*d.y(), u.z()+a*d.z());
    strokeWeight(2);
  }






  void remplirCouleurs() {
    couleurs[0]=color(0, 0, 255);//segments out QI Rj
    couleurs[1]=color(0, 0, 255);//les ceviennes
    couleurs[2]=color(0, 255, 0);//les fleches
    couleurs[3]=color(255, 0, 0);//les paralleles a OA 
    couleurs[4]=color(0, 0, 255);//les points dehors

    couleurs[5]=color(255, 55, 0, 45);
    couleurs[6]=color(255, 0, 55, 45);
    couleurs[7]=color(0, 255, 0, 45);
    couleurs[8]=color( 100, 255, 100, 45);
    couleurs[9]=color( 0, 155, 255, 80);
    couleurs[10]=color(0, 0, 255, 60);

    couleurs[11]=color(0, 255, 0);//les fleches
    couleurs[12]=color(255, 255, 0, 90);//les fleches
  }


  void fleche(Vec from, Vec to, color c) {
    pushMatrix();     
    Vec v=Vec.subtract(  from, to);
    float mg=v.magnitude(); 
    frame0.setZAxis(v);
    frame0.setTranslation( to);
    frame0.applyTransformation();
    fill(c);
    scene.drawCylinder(3, mg);
    scene.drawCone(16, 4, 15, 20);
    popMatrix();
  }


  void drawText(String tex, Vec v) {
    float leX = screenX(v.x()-7, v.y()+10, v.z());
    float leY = screenY(v.x()+7, v.y()+10, v.z());

    pushMatrix();
    scene.beginScreenDrawing();
    fill(0); 
    text(tex, leX+20, leY-15, 70);

    scene.endScreenDrawing(); 
    popMatrix();
  }
  void texte(int etap) {
    pushMatrix();
    scene.beginScreenDrawing();
    fill(0);
    textFont(font, 30); 
    text(etap, 13, height-40, 10); 
    textFont(font, 16);
    text(letexte, 5, height-80, 10);
    scene.endScreenDrawing(); 
    popMatrix();
  } 
  void texteFinal(String s, float x, float y) {
    pushMatrix();
    scene.beginScreenDrawing();
    fill(0); 
    textFont(font);
    text(s, x, y, 10);
    scene.endScreenDrawing(); 
    popMatrix();
  }
}