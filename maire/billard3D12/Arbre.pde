public class Arbre {
  InteractiveFrame  laBoite, laBille;
  InteractiveFrame[] bump;  
  Vec   vBoite, pBoite;
  float largeur, rBille,  rayBump, disBump;
  int  choc;
  int[] chocB;
  Scene scene;

  Arbre(Scene s) {


    scene=s;  
    vBoite=new Vec(-13, -13, 12);
    pBoite=new Vec(150, -400, 400);
    largeur=600;
    rBille=110;
    rayBump=100;
    disBump=200;
    chocB=new int[8];
    //l arbre des frames
    laBille  =new InteractiveFrame(scene);
    laBoite  =new InteractiveFrame(scene, laBille);
    bump=new InteractiveFrame[8];
    for (int i=0; i<8; i++) bump[i]=new InteractiveFrame(scene, laBoite);

    laBille.setTranslation(new Vec(0, 0, 0));
    laBoite.setPosition(pBoite);
    bump[0].setTranslation(new Vec(disBump, disBump, disBump));
    bump[1].setTranslation(new Vec(disBump, -disBump, disBump));
    bump[2].setTranslation(new Vec(disBump, -disBump, -disBump));
    bump[3].setTranslation(new Vec(disBump, disBump, -disBump));

    bump[4].setTranslation(new Vec(-disBump, disBump, disBump));
    bump[5].setTranslation(new Vec(-disBump, -disBump, disBump));
    bump[6].setTranslation(new Vec(-disBump, -disBump, -disBump));
    bump[7].setTranslation(new Vec(-disBump, disBump, -disBump));
    //graphics handLers
    laBille.setShape(this, "dessinBille");
    laBoite.setShape(this, "dessinBoite");
    for (int i=0; i<8; i++)bump[i].setShape(this, "dessinBump"+i);
  }
  
  
  void dessinBump0(PGraphics pg) {
    pg.pushMatrix();
    pg.fill((chocB[0]>0)?#FFFF00:#FF0000);
    pg.noStroke();
    pg.sphere(rayBump*max(1,0.04*chocB[0]));
    println(chocB[0]);
    pg.popMatrix();
  }
   void dessinBump1(PGraphics pg) {
    pg.pushMatrix();
     pg.fill((chocB[1]>0)?#FFFF00:#FF0000);
    pg.sphere(rayBump*max(1,0.04*chocB[1]));
    pg.popMatrix();
  }
   void dessinBump2(PGraphics pg) {
    pg.pushMatrix();
     pg.fill((chocB[2]>0)?#FFFF00:#FF0000);
    pg.sphere(rayBump*max(1,0.04*chocB[2]));
    pg.popMatrix();
  }
   void dessinBump3(PGraphics pg) {
    pg.pushMatrix();
     pg.fill((chocB[3]>0)?#FFFF00:#FF0000);
    pg.sphere(rayBump*max(1,0.04*chocB[3]));
    pg.popMatrix();
  }
  
void dessinBump4(PGraphics pg) {
    pg.pushMatrix();
    pg.fill((chocB[4]>0)?#FFFF00:#FF0000);
    pg.noStroke();
    pg.sphere(rayBump*max(1,0.04*chocB[4]));
    pg.popMatrix();
  }
   void dessinBump5(PGraphics pg) {
    pg.pushMatrix();
     pg.fill((chocB[5]>0)?#FFFF00:#FF0000);
    pg.noStroke();
    pg.sphere(rayBump*max(1,0.04*chocB[5]));
    pg.popMatrix();
  }
   void dessinBump6(PGraphics pg) {
    pg.pushMatrix();
     pg.fill((chocB[6]>0)?#FFFF00:#FF0000);
    pg.sphere(rayBump*max(1,0.04*chocB[6]));
    pg.popMatrix();
  }
   void dessinBump7(PGraphics pg) {
    pg.pushMatrix();
     pg.fill((chocB[7]>0)?#FFFF00:#FF0000);
    pg.sphere(rayBump*max(1,0.04*chocB[7]));
    pg.popMatrix();
  }
  void dessinBoite(PGraphics pg) {
    pg.pushMatrix();
    boitefaces(pg, largeur);
    pg.popMatrix();
  }
  void dessinBille(PGraphics pg) {
    pg.pointLight(255,255,255,rBille+5,-rBille-5,rBille+5);
    pg.fill(100,100,255,190);    
    pg.sphere(rBille);
  }

  void moteurBoite() {
    Vec ancPos=laBoite.translation();
    Vec  newPos=Vec.add(vBoite, ancPos);
    if ((newPos.x()-rBille<-largeur)||(newPos.x()+rBille>largeur)) {
      vBoite.setX(vBoite.x()*-1.0);
      choc=40;
    }

    if ((newPos.y()-rBille<-largeur)||(newPos.y()+rBille>largeur)) {
      vBoite.setY(vBoite.y()*-1.0);
      choc=40;
    }

    if ((newPos.z()-rBille<-largeur)||(newPos.z()+rBille>largeur)) {
      vBoite.setZ(vBoite.z()*-1.0);
      choc=40;
    }
    
    for (int i=0; i<8; i++) {
    Vec vite=rebond(i);
    if (vite.magnitude()>0) {
      vBoite=vite.get();
      chocB[i]=40;
    }
} 
    laBoite.setTranslation(Vec.add(vBoite, laBoite.translation())); 
    if (choc>0)choc--; 
    for(int i=0;i<8;i++)if (chocB[i]>0)chocB[i]--;  
  }

 

  void boitefaces(PGraphics pg, float m) {
    beginShape(QUADS);
    pg.fill(255, 255, 100,200);
    pg.vertex(m, m, m);//haut
    pg.vertex(m, -m, m);
    pg.vertex(-m, -m, m);
    pg.vertex(-m, m, m);
    pg.fill(0, 155, 255);
    pg.vertex(m, m, -m);//bas
    pg.vertex(m, -m, -m);
    pg.vertex(-m, -m, -m);
    pg.vertex(-m, m, -m);
    pg.fill(155, 0, 255);
    pg.vertex(m, m, m);//droit
    pg.vertex(m, -m, m);
    pg.vertex(m, -m, -m);
    pg.vertex(m, m, -m);
    pg.fill(255, 255, 255);
    pg.vertex(-m, m, m);//gauche
    pg.vertex(-m, -m, m);
    pg.vertex(-m, -m, -m);
    pg.vertex(-m, m, -m);
    endShape();
  }


  Vec rebond(int n) {
    Vec posbump=bump[n].translation();
    Vec posboit=laBoite.translation();
    Vec norma=Vec.add(posbump, posboit);
    if ( norma.magnitude()>rayBump+rBille) return new Vec();
    else {    
      Vec vitnorma=Vec.projectVectorOnAxis(vBoite, norma);
      Vec vitplan=Vec.projectVectorOnPlane(vBoite, norma);
      
      return Vec.subtract(vitplan, vitnorma);
    }
  }
}