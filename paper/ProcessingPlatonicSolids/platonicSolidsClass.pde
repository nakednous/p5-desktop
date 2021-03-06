class Icosahedron {
  // icosahedron
  float x, y, z;
  float radius;
  float vertexRadius;
  boolean showFaces;
  int currentColor;
  PVector topPoint;
  PVector[] topPent = new PVector[5];
  PVector bottomPoint;
  PVector[] bottomPent = new PVector[5];
  float angle = 0;
  float triDist;
  float triHt;
  float a, b, c;

  // constructor
  Icosahedron(float radius, float vertexRadius, boolean showFaces){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = showFaces;
    init();
  }

  Icosahedron(float radius, float vertexRadius){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = true;
    init();
  }

  Icosahedron(float radius){
    this.radius = radius;
    this.vertexRadius = 0;
    this.showFaces = true;
    init();
  }
  
  // calculate geometry
  void init(){
    c = dist(cos(0)*radius, sin(0)*radius, cos(radians(72))*radius,  sin(radians(72))*radius);
    b = radius;
    a = (float)(Math.sqrt(((c*c)-(b*b))));

    triHt = (float)(Math.sqrt((c*c)-((c/2)*(c/2))));

    for (int i=0; i<topPent.length; i++){
      topPent[i] = new PVector(cos(angle)*radius, sin(angle)*radius, triHt/2.0f);
      angle+=radians(72);
    }
    topPoint = new PVector(0, 0, triHt/2.0f+a);
    angle = 72.0f/2.0f;
    for (int i=0; i<topPent.length; i++){
      bottomPent[i] = new PVector(cos(angle)*radius, sin(angle)*radius, -triHt/2.0f);
      angle+=radians(72);
    }
    bottomPoint = new PVector(0, 0, -(triHt/2.0f+a));
  }

  // draws icosahedron 
  void create(PGraphics pg){
    // vertexes
    if(vertexRadius > 0)
    {
      for(int i=0;i<5;i++)
      {
        vertexSphere(pg, topPent[i].x,topPent[i].y,topPent[i].z,vertexRadius);
        vertexSphere(pg, bottomPent[i].x,bottomPent[i].y,bottomPent[i].z,vertexRadius);
      }
      vertexSphere(pg, topPoint.x,topPoint.y,topPoint.z,vertexRadius);
      vertexSphere(pg, bottomPoint.x,bottomPoint.y,bottomPoint.z,vertexRadius);
    }
    
    if(!showFaces)
    {
      currentColor = g.fillColor;
      pg.fill(0,0,0,0);
    }
    for (int i=0; i<topPent.length; i++){
      // icosahedron top
      pg.beginShape();
      if (i<topPent.length-1){
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+topPoint.x, y+topPoint.y, z+topPoint.z);
        pg.vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
      } 
      else {
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+topPoint.x, y+topPoint.y, z+topPoint.z);
        pg.vertex(x+topPent[0].x, y+topPent[0].y, z+topPent[0].z);
      }
      pg.endShape(CLOSE);

      // icosahedron bottom
      pg.beginShape();
      if (i<bottomPent.length-1){
        pg.vertex(x+bottomPent[i].x, y+bottomPent[i].y, z+bottomPent[i].z);
        pg.vertex(x+bottomPoint.x, y+bottomPoint.y, z+bottomPoint.z);
        pg.vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
      } 
      else {
        pg.vertex(x+bottomPent[i].x, y+bottomPent[i].y, z+bottomPent[i].z);
        pg.vertex(x+bottomPoint.x, y+bottomPoint.y, z+bottomPoint.z);
        pg.vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
      }
      pg.endShape(CLOSE);
    }

    // icosahedron body
    for (int i=0; i<topPent.length; i++){
      if (i<topPent.length-2){
        pg.beginShape();
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
        pg.vertex(x+bottomPent[i+2].x, y+bottomPent[i+2].y, z+bottomPent[i+2].z);
        pg.endShape(CLOSE);

        pg.beginShape();
        pg.vertex(x+bottomPent[i+2].x, y+bottomPent[i+2].y, z+bottomPent[i+2].z);
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
        pg.endShape(CLOSE);
      } 
      else if (i==topPent.length-2){
        pg.beginShape();
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
        pg.vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        pg.endShape(CLOSE);

        pg.beginShape();
        pg.vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
        pg.endShape(CLOSE);
      }
      else if (i==topPent.length-1){
        pg.beginShape();
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        pg.vertex(x+bottomPent[1].x, y+bottomPent[1].y, z+bottomPent[1].z);
        pg.endShape(CLOSE);

        pg.beginShape();
        pg.vertex(x+bottomPent[1].x, y+bottomPent[1].y, z+bottomPent[1].z);
        pg.vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        pg.vertex(x+topPent[0].x, y+topPent[0].y, z+topPent[0].z);
        pg.endShape(CLOSE);
      }
    }
    if(!showFaces)
    {
      pg.fill(currentColor);
    }

  }

  void vertexSphere(PGraphics pg, float x, float y, float z, float r)
  {
    pg.pushMatrix();
    pg.translate(x,y,z);
    pg.sphere(r);
    pg.popMatrix();
  }

}


class Tetrahedron{

  // Tetrahedron
  float x, y, z;
  float radius;
  float vertexRadius;
  boolean showFaces;
  int currentColor;
  float a;
  PVector[] vert = new PVector[4];
  int[][] faces;
  
  // constructor
  Tetrahedron(float radius, float vertexRadius, boolean showFaces){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = showFaces;
    init();
  }

  Tetrahedron(float radius, float vertexRadius){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = true;
    init();
  }

  Tetrahedron(float radius){
    this.radius = radius;
    this.vertexRadius = 0;
    this.showFaces = true;
    init();
  }

  // calculate geometry
  void init(){
    a = radius*0.6666;
    vert[0] = new PVector( a, a, a );  // vertex 1
    vert[1] = new PVector(-a, -a, a );    // vertex 2
    vert[2] = new PVector(-a, a,-a );  // vertex 3
    vert[3] = new PVector( a, -a, -a );   // vertex 4
  }

  // draws tetrahedron 
  void create(PGraphics pg){
    // vertexes
    if(vertexRadius > 0)
    {
      for(int i=0;i<4;i++)
        vertexSphere(pg, vert[i].x,vert[i].y,vert[i].z,vertexRadius);
    }

    if(!showFaces)
    {
      currentColor = g.fillColor;
      pg.fill(0,0,0,0);
    }
    pg.beginShape(TRIANGLE_STRIP);
    pg.vertex(vert[0].x,vert[0].y,vert[0].z);  // vertex 1
    pg.vertex(vert[1].x,vert[1].y,vert[1].z);    // vertex 2
    pg.vertex(vert[2].x,vert[2].y,vert[2].z);  // vertex 3
    pg.vertex(vert[3].x,vert[3].y,vert[3].z);   // vertex 4
    pg.vertex(vert[0].x,vert[0].y,vert[0].z);  // vertex 1
    pg.vertex(vert[1].x,vert[1].y,vert[1].z);    // vertex 2
    pg.vertex(vert[3].x,vert[3].y,vert[3].z);   // vertex 4
    pg.vertex(vert[2].x,vert[2].y,vert[2].z);  // vertex 3
    pg.vertex(vert[1].x,vert[1].y,vert[1].z);    // vertex 2
    pg.endShape(CLOSE);
    if(!showFaces)
    {
      pg.fill(currentColor);
    }

  }

  void vertexSphere(PGraphics pg, float x, float y, float z, float r)
  {
    pg.pushMatrix();
    pg.translate(x,y,z);
    pg.sphere(r);
    pg.popMatrix();
  }

}

class Hexahedron{

  // Tetrahedron
  float x, y, z;
  float radius;
  float vertexRadius;
  boolean showFaces;
  int currentColor;
  float a;
  PVector[] vert = new PVector[8];
  int[][] faces;
  
  // constructor
  Hexahedron(float radius, float vertexRadius, boolean showFaces){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = showFaces;
    init();
  }
  
  Hexahedron(float radius, float vertexRadius){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = true;
    init();
  }

  Hexahedron(float radius){
    this.radius = radius;
    this.vertexRadius = 0;
    this.showFaces = true;
    init();
  }

  // calculate geometry
  void init(){
    a = radius/1.1414;
    faces = new int[6][4];
    vert[0] = new PVector(  a,  a,  a );
    vert[1] = new PVector(  a,  a, -a );
    vert[2] = new PVector(  a, -a, -a );
    vert[3] = new PVector(  a, -a,  a );
    vert[4] = new PVector( -a, -a,  a );
    vert[5] = new PVector( -a,  a,  a );
    vert[6] = new PVector( -a,  a, -a );
    vert[7] = new PVector( -a, -a, -a );
    
    faces[0] = new int[] {0, 1, 2, 3};
    faces[1] = new int[] {4, 5, 6, 7};
    faces[2] = new int[] {0, 3, 4, 5};
    faces[3] = new int[] {1, 2, 7, 6};
    faces[4] = new int[] {2, 3, 4, 7};
    faces[5] = new int[] {0, 5, 6, 1};
  }

  // draws hexahedron 
  void create(PGraphics pg){ 
    // vertexes
    if(vertexRadius > 0)
    {
      for(int i=0;i<8;i++)
        vertexSphere(pg, vert[i].x,vert[i].y,vert[i].z,vertexRadius);
    }
    
    if(!showFaces)
    {
      currentColor = g.fillColor;
      pg.fill(0,0,0,0);
    }
    
    for(int i=0; i<6; i++)
    {
      pg.beginShape();
      for(int j=0; j<4; j++)
      {
        pg.vertex(vert[faces[i][j]].x,vert[faces[i][j]].y,vert[faces[i][j]].z);
      }
      pg.endShape();
    }

    if(!showFaces)
    {
      pg.fill(currentColor);
    }

  }

  void vertexSphere(PGraphics pg, float x, float y, float z, float r)
  {
    pg.pushMatrix();
    pg.translate(x,y,z);
    pg.sphere(r);
    pg.popMatrix();
  }

}

class Octahedron{

  // Octahedron
  float x, y, z;
  float radius;
  float vertexRadius;
  boolean showFaces;
  int currentColor;
  float a;
  PVector[] vert = new PVector[6];
  int[][] faces;

  // constructor
  Octahedron(float radius, float vertexRadius, boolean showFaces){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = showFaces;
    init();
  }

  Octahedron(float radius, float vertexRadius){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = true;
    init();
  }

  Octahedron(float radius){
    this.radius = radius;
    this.vertexRadius = 0;
    this.showFaces = true;
    init();
  }

  // calculate geometry
  void init(){
    a = radius;
    vert[0] = new PVector( a, 0, 0 ); 
    vert[1] = new PVector( 0, a, 0 );
    vert[2] = new PVector( 0, 0, a ); 
    vert[3] = new PVector( -a, 0, 0 ); 
    vert[4] = new PVector( 0, -a, 0 ); 
    vert[5] = new PVector( 0, 0, -a );
  }

  // draws octahedron 
  void create(PGraphics pg){
    // vertexes
    if(vertexRadius > 0)
    {
      for(int i=0;i<6;i++)
        vertexSphere(pg, vert[i].x,vert[i].y,vert[i].z,vertexRadius);
    }
    
    if(!showFaces)
    {
      currentColor = g.fillColor;
      pg.fill(0,0,0,0);
    }

    pg.beginShape(TRIANGLE_FAN); 
    pg.vertex(vert[4].x,vert[4].y,vert[4].z);
    pg.vertex(vert[0].x,vert[0].y,vert[0].z);
    pg.vertex(vert[2].x,vert[2].y,vert[2].z);
    pg.vertex(vert[3].x,vert[3].y,vert[3].z);
    pg.vertex(vert[5].x,vert[5].y,vert[5].z);
    pg.vertex(vert[0].x,vert[0].y,vert[0].z);
    pg.endShape();
  
    pg.beginShape(TRIANGLE_FAN);    
    pg.vertex(vert[1].x,vert[1].y,vert[1].z);
    pg.vertex(vert[0].x,vert[0].y,vert[0].z);
    pg.vertex(vert[2].x,vert[2].y,vert[2].z);
    pg.vertex(vert[3].x,vert[3].y,vert[3].z);
    pg.vertex(vert[5].x,vert[5].y,vert[5].z);
    pg.vertex(vert[0].x,vert[0].y,vert[0].z);
    pg.endShape();

    if(!showFaces)
    {
      pg.fill(currentColor);
    }

  }

  void vertexSphere(PGraphics pg, float x, float y, float z, float r)
  {
    pg.pushMatrix();
    pg.translate(x,y,z);
    pg.sphere(r);
    pg.popMatrix();
  }

}

class Dodecahedron{

  // Dodecahedron
  float x, y, z;
  float radius;
  float vertexRadius;
  boolean showFaces;
  int currentColor;
  float a,b,c;
  PVector[] vert;
  int[][] faces;
  
  // constructor
  Dodecahedron(float radius, float vertexRadius, boolean showFaces){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = showFaces;
    init();
  }
  
  Dodecahedron(float radius, float vertexRadius){
    this.radius = radius;
    this.vertexRadius = vertexRadius;
    this.showFaces = true;
    init();
  }

  Dodecahedron(float radius){
    this.radius = radius;
    this.vertexRadius = 0;
    this.showFaces = true;
    init();
  }

  // calculate geometry
  void init(){
    a = radius/1.618033989;
    b = radius;
    c = 0.618033989*a;
    faces = new int[12][5];
    vert = new PVector[20];
    vert[ 0] = new PVector(a, a, a);
    vert[ 1] = new PVector(a, a, -a);
    vert[ 2] = new PVector(a, -a, a);
    vert[ 3] = new PVector(a, -a, -a);
    vert[ 4] = new PVector(-a, a, a);
    vert[ 5] = new PVector(-a, a, -a);
    vert[ 6] = new PVector(-a, -a, a);
    vert[ 7] = new PVector(-a, -a, -a);
    vert[ 8] = new PVector(0, c, b);
    vert[ 9] = new PVector(0, c, -b);
    vert[10] = new PVector(0, -c, b);
    vert[11] = new PVector(0, -c, -b);
    vert[12] = new PVector(c, b, 0);
    vert[13] = new PVector(c, -b, 0);
    vert[14] = new PVector(-c, b, 0);
    vert[15] = new PVector(-c, -b, 0);
    vert[16] = new PVector(b, 0, c);
    vert[17] = new PVector(b, 0, -c);
    vert[18] = new PVector(-b, 0, c);
    vert[19] = new PVector(-b, 0, -c);
    
    faces[ 0] = new int[] {0, 16, 2, 10, 8};
    faces[ 1] = new int[] {0, 8, 4, 14, 12};
    faces[ 2] = new int[] {16, 17, 1, 12, 0};
    faces[ 3] = new int[] {1, 9, 11, 3, 17};
    faces[ 4] = new int[] {1, 12, 14, 5, 9};
    faces[ 5] = new int[] {2, 13, 15, 6, 10};
    faces[ 6] = new int[] {13, 3, 17, 16, 2};
    faces[ 7] = new int[] {3, 11, 7, 15, 13};
    faces[ 8] = new int[] {4, 8, 10, 6, 18};
    faces[ 9] = new int[] {14, 5, 19, 18, 4};
    faces[10] = new int[] {5, 19, 7, 11, 9};
    faces[11] = new int[] {15, 7, 19, 18, 6};
  }

  // draws dodecahedron 
  void create(PGraphics pg){
    // vertexes
    if(vertexRadius > 0)
    {
      for(int i=0;i<20;i++)
        vertexSphere(pg, vert[i].x,vert[i].y,vert[i].z,vertexRadius);
    }
    
    if(!showFaces)
    {
      currentColor = g.fillColor;
      pg.fill(0,0,0,0);
    }
    
    for(int i=0; i<12; i++)
    {
      pg.beginShape();
      for(int j=0;j<5;j++)
      {
        pg.vertex(vert[faces[i][j]].x,vert[faces[i][j]].y,vert[faces[i][j]].z);
      }
      pg.endShape();
    }

    if(!showFaces)
    {
      pg.fill(currentColor);
    }

  }

  void vertexSphere(PGraphics pg, float x, float y, float z, float r)
  {
    pg.pushMatrix();
    pg.translate(x,y,z);
    pg.sphere(r);
    pg.popMatrix();
  }

}