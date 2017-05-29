import remixlab.bias.Agent;
import remixlab.proscene.Scene;

public class Agente extends Agent {
  
  public static final int ATAJO_NO = Atajo.registerID(0,"ATAJO_NO");
  public static final int ATAJO_DO = Atajo.registerID(1,"ATAJO_DO");

  
  protected Input input;
  Scene scene;

  public Agente(Scene scn) {
    super(scn.inputHandler());
    scene = scn;
    register();
    addGrabber(scene.eyeFrame());
    setDefaultGrabber(scene.eyeFrame());
    input = new DummyInput();
  }
  
  public void register() {
    scene.inputHandler().registerAgent(this);
  }

  public void unregister() {
    scene.inputHandler().unregisterAgent(this);
  }
  
  @Override
  public Evento feed(){
    int nx = input.getInput();
    if( nx == 0){
      return new Evento(ATAJO_NO);
    }
    return new Evento(ATAJO_DO);
  }

}