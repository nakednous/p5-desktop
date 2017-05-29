/**
 * PostEffects.
 * by Ivan Castellanos and Jean Pierre Charalambos.
 *
 * This example illustrates how to attach a PShape to an interactive frame.
 * PShapes attached to interactive frames can then be automatically picked
 * and easily drawn.
 *
 * Press '1' to '9' to (de)activate effect.
 * Press 'h' to display the key shortcuts and mouse bindings in the console.
 */

import remixlab.proscene.*;

PShader noiseShader, kaleidoShader, raysShader, dofShader, pixelShader, edgeShader, colorShader, fxaaShader, horizontalShader;
PGraphics drawGraphics, dofGraphics, noiseGraphics, kaleidoGraphics, raysGraphics, pixelGraphics, edgeGraphics, graphics, colorGraphics, fxaaGraphics, horizontalGraphics;
Scene scene;
boolean bdepth, brays, bpixel, bedge, bdof, bkaleido, bnoise, bfxaa, bhorizontal;
float posns[];
int startTime;
InteractiveFrame[] models;
PFont font;

public void setup() {
  size(1200, 800, P3D);
  font = loadFont("FreeSans-36.vlw");
  textFont(font);
  colorMode(HSB, 255);
  posns = new float[300];  
  for (int i = 0; i<100; i++){
    posns[3*i]=random(-1000, 1000);
    posns[3*i+1]=random(-1000, 1000);
    posns[3*i+2]=random(-1000, 1000);
  }  
  graphics = createGraphics(width, height, P3D);  
  scene = new Scene(this, graphics);
  scene.setAxesVisualHint(false);
  scene.setGridVisualHint(false);
  models = new InteractiveFrame[100];
  for (int i = 0; i < models.length; i++) {
    models[i] = new InteractiveFrame(scene, shape());
    models[i].translate(posns[3*i], posns[3*i+1], posns[3*i+2]);
  }
  scene.setRadius(1000);
  scene.showAll();
     
  colorShader = loadShader("colorfrag.glsl");
  colorShader.set("maxDepth", scene.radius()*2);
  colorGraphics = createGraphics(width, height, P3D);
  colorGraphics.shader(colorShader);
  
  edgeShader = loadShader("edge.glsl");
  edgeGraphics = createGraphics(width, height, P3D);
  edgeGraphics.shader(edgeShader);
  edgeShader.set("aspect", 1.0/width, 1.0/height);
  
  pixelShader = loadShader("pixelate.glsl");
  pixelGraphics = createGraphics(width, height, P3D);
  pixelGraphics.shader(pixelShader);
  pixelShader.set("xPixels", 100.0);
  pixelShader.set("yPixels", 100.0);
  
  raysShader = loadShader("raysfrag.glsl");
  raysGraphics = createGraphics(width, height, P3D);
  raysGraphics.shader(raysShader);
  raysShader.set("lightPositionOnScreen", 0.5, 0.5);
  raysShader.set("lightDirDOTviewDir", 0.7);
  
  dofShader = loadShader("dof.glsl");  
  dofGraphics = createGraphics(width, height, P3D);
  dofGraphics.shader(dofShader);
  dofShader.set("aspect", width / (float) height);
  dofShader.set("maxBlur", 0.015);  
  dofShader.set("aperture", 0.02);
  
  kaleidoShader = loadShader("kaleido.glsl");
  kaleidoGraphics = createGraphics(width, height, P3D);
  kaleidoGraphics.shader(kaleidoShader);
  kaleidoShader.set("segments", 2.0);

  noiseShader = loadShader("noise.glsl");
  noiseGraphics = createGraphics(width, height, P3D);
  noiseGraphics.shader(noiseShader);
  noiseShader.set("frequency", 4.0);
  noiseShader.set("amplitude", 0.1);
  noiseShader.set("speed", 0.1);
  
  fxaaShader = loadShader("fxaa.glsl");
  fxaaGraphics = createGraphics(width, height, P3D);
  fxaaGraphics.shader(fxaaShader);
  fxaaShader.set("resolution", 1.0 / width, 1.0 / height);
  
  horizontalShader = loadShader("horizontal.glsl");
  horizontalGraphics = createGraphics(width, height, P3D);
  horizontalGraphics.shader(horizontalShader);
  horizontalShader.set("h", 0.005);
  horizontalShader.set("r", 0.5);
  frameRate(100);
  smooth(8);
}

public void draw() {
  PGraphics pg = graphics;

  // 1. Draw into main buffer
  scene.beginDraw();
  pg.background(255);
  scene.drawFrames();
  scene.endDraw();
 
  drawGraphics = graphics;
  
  if (bdepth){
    colorGraphics.beginDraw();
    colorGraphics.background(0);
    scene.drawFrames(colorGraphics);
    colorGraphics.endDraw();
    drawGraphics = colorGraphics;
  }
  if (bkaleido) {
    kaleidoGraphics.beginDraw();
    kaleidoShader.set("tex", drawGraphics);
    kaleidoGraphics.image(graphics, 0, 0);
    kaleidoGraphics.endDraw();    
    drawGraphics = kaleidoGraphics;
  }
  if (bnoise) {
    noiseGraphics.beginDraw();
    noiseShader.set("time", millis() / 1000.0);
    noiseShader.set("tex", drawGraphics);
    noiseGraphics.image(graphics, 0, 0);
    noiseGraphics.endDraw();    
    drawGraphics = noiseGraphics;
  }
  if (bpixel) {
    pixelGraphics.beginDraw();
    pixelShader.set("tex", drawGraphics);
    pixelGraphics.image(graphics, 0, 0);
    pixelGraphics.endDraw();
    drawGraphics = pixelGraphics;    
  }
  if (bdof) {  
    dofGraphics.beginDraw();
    dofShader.set("focus", map(mouseX, 0, width, -0.5f, 1.5f));    
    dofShader.set("tDepth", colorGraphics);
    dofShader.set("tex", drawGraphics);
    dofGraphics.image(graphics, 0, 0);
    dofGraphics.endDraw();    
    drawGraphics = dofGraphics;
  }
  if (bedge) {  
    edgeGraphics.beginDraw();
    edgeShader.set("tex", drawGraphics);
    edgeGraphics.image(graphics, 0, 0);
    edgeGraphics.endDraw();    
    drawGraphics = edgeGraphics;
  }
  if (bhorizontal) {
    horizontalGraphics.beginDraw();
    horizontalShader.set("tDiffuse", drawGraphics);
    horizontalGraphics.image(graphics, 0, 0);
    horizontalGraphics.endDraw();    
    drawGraphics = horizontalGraphics;
  }
  if (brays) {   
    raysGraphics.beginDraw();
    raysShader.set("otex", drawGraphics);
    raysShader.set("rtex", drawGraphics);
    raysGraphics.image(graphics, 0, 0);
    raysGraphics.endDraw();    
    drawGraphics = raysGraphics;
  }
  if (bfxaa) {
    fxaaGraphics.beginDraw();
    fxaaShader.set("tDiffuse", drawGraphics);
    fxaaGraphics.image(graphics, 0, 0);
    fxaaGraphics.endDraw();    
    drawGraphics = fxaaGraphics;
  }
  scene.display(drawGraphics);
  drawText();
}

void drawText() {
  pushStyle();
  fill(0);
  scene.beginScreenDrawing();
  int y = 35;
  int inc = 35;
  text(bdepth ? "1. Depth (*)" : "1. Depth", 5, y);
  text(bkaleido ? "2. Kaleidoscope (*)" : "2. Kaleidoscope", 5, (y += inc));
  text(bnoise ? "3. Noise (*)" : "3. Noise", 5, (y += inc));
  text(bpixel ? "4. Pixelate (*)" : "4. Pixelate", 5, (y += inc));
  text(bdof ? "5. DOF (*)" : "5. DOF", 5, (y += inc));
  text(bedge ? "6. Edge (*)" : "6. Edge", 5, (y += inc));
  text(bhorizontal ? "7. Horizontal (*)" : "7. Horizontal", 5, (y += inc));
  text(brays ? "8. Rays (*)" : "8. Rays", 5, (y += inc));
  text(bfxaa ? "9. Fxaa (*)" : "9. Fxaa", 5, (y += inc));
  scene.endScreenDrawing();
  popStyle();
}

PShape shape() {
  PShape fig;
  if (int(random(2))%2 == 0)
    fig = createShape(BOX, 120);
  else
    fig = createShape(SPHERE, 100);
  fig.setStroke(255);
  fig.setFill(color(random(0,255), random(0,255), random(0,255)));
  return fig;
}

void keyPressed() {
  if(key=='1')
    bdepth = !bdepth;
  if(key=='2')
    bkaleido = !bkaleido;
  if(key=='3')
    bnoise = !bnoise;
  if(key=='4')
    bpixel = !bpixel;
  if(key=='5')
    bdof = !bdof;  
  if(key=='6')
    bedge = !bedge;
  if(key=='7')
    bhorizontal = !bhorizontal;
  if(key=='8')
    brays = !brays;
  if(key=='9')
    bfxaa = !bfxaa;
  if(key == ' ')
    scene.togglePickingBuffer();
}