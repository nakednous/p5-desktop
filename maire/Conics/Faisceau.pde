class Faisceau {
  int numero; 
  int ndroites=120;
  Droite[] droites;

  Faisceau() {
    droites=new Droite[ndroites];
    for (int i=0; i<ndroites; i++) {
      droites[i]=new Droite(TWO_PI/170*i);
    }
  }

  Droite uneDroite(Vec pt) {
    return new Droite(frames[1].position(), pt);
  }
  
  
  
  void actualiser() {
    for (int i=0; i<ndroites; i++) {
      droites[i].actualiser();
    }
  }
}
