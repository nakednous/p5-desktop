import java.util.*;

import remixlab.proscene.*;
import remixlab.bias.*;
import remixlab.bias.event.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.core.*;

Scene scene;
Agente agente;
InteractiveFrame iFrame;

void setup(){
  size(800,600,P3D);
  scene = new Scene(this);
  agente = new Agente(scene);
  
  iFrame = new InteractiveFrame(scene);
    iFrame.setPickingPrecision(InteractiveFrame.PickingPrecision.ADAPTIVE);
    iFrame.setGrabsInputThreshold(scene.radius() / 4);
    iFrame.translate(50, 50);
    
  scene.eyeFrame().setBinding(new Atajo(BogusEvent.NO_MODIFIER_MASK, Agente.ATAJO_DO), "accionDo");
  scene.eyeFrame().setBinding(new Atajo(BogusEvent.NO_MODIFIER_MASK, Agente.ATAJO_NO), "accionNo");
}

void draw(){
  background(255);
  pushMatrix();
    // Multiply matrix to get in the frame coordinate system.
    // applyMatrix(Scene.toPMatrix(iFrame.matrix())); //is possible but inefficient
    iFrame.applyTransformation();//very efficient
    // Draw an axis using the Scene static function
    scene.drawAxes(20);
    popMatrix();
}

public void accionDo(InteractiveFrame frame, Evento event) {
    println("evento do");
}

public void accionNo(InteractiveFrame frame, Evento event) {
    println("evento No");
}