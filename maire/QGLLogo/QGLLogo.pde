import remixlab.proscene.*;

Scene scene;

void setup() {
  size(640, 360, P3D);
  //Scene instantiation
  scene = new Scene(this);
  scene.setRadius(9);
  scene.showAll();
}

void draw() {
  background(50);
  noStroke();
  lights();
  ambientLight(51, 102, 126);
  drawSpiral();
  translate(0.5,0.5,0.5);
  drawSpiral();
  /*
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  scene.translate(0.5,0.5,0.5);
  drawSpiral();
  */
}

void drawSpiral() {
  pushStyle();
  colorMode(RGB, 1);
  float nbSteps = 200.0;
  beginShape(QUAD_STRIP); 
  for (int i=0; i<nbSteps; ++i) {
      float ratio = i/nbSteps;
      float angle = 21.0*ratio;
      float c = cos(angle);
      float s = sin(angle);
      float r1 = 1.0 - 0.8f*ratio;
      float r2 = 0.8f - 0.8f*ratio;
      float alt = ratio - 0.5f;
      float nor = 0.5f;
      float up = sqrt(1.0-nor*nor);
      fill(1.0-ratio, 0.2f , ratio);
      normal(nor*c, up, nor*s);
      vertex(r1*c, alt, r1*s);
      vertex(r2*c, alt+0.05f, r2*s);
    }
  endShape();  
  popStyle();
}
