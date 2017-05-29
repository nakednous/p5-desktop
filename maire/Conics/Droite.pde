class Droite {
  Vec from, to, dir;
  float angle;


  Droite(Vec q0, Vec q1) {
    from=q0;
    to=q1;
    dir=Vec.subtract(q1, q0);
  }
  Droite(Vec q0, float r, float theta) {
    from=q0;
    dir=new Vec(r*cos(theta), r*sin(theta), 0);
    to=Vec.add(q0, dir);
  }
  Droite(float ang) {

    angle= ang;
    actualiser();
  }


  void actualiser() {
    from=frames[1].position();
    dir=new Vec(300*cos(angle+temps), 300*sin(angle+temps), 0);
    to=Vec.add(from, dir);
    ligne(from, to, color(0, 255, 0));//la droite d
    Vec D1=inter2Lines(from, to, frames[2].position(), frames[3].position());
    Vec D2=inter2Lines(D1, frames[0].position(), frames[1].position(), frames[3].position());
    ligne(frames[2].position(), D2, color(255, 0, 0));
    Vec D3=inter2Lines(from, to, frames[2].position(), D2);
    ligne(from, D3, color(255, 0, 0));
    ligne(frames[2].position(), D3, color(255, 0, 0));
    balle(D3, 9, color(0, 0, 255));
   
  }





  void tourner(float theta, float r) {
    dir= new Vec(r*cos(theta), r*sin(theta));
    to=Vec.add(from, dir);
  }
}
