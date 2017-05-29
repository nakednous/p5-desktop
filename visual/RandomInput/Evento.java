import remixlab.bias.*;

public class Evento extends BogusEvent {

  public Evento(int id) {
    super(BogusEvent.NO_MODIFIER_MASK, id);
  }
  
  @Override
  public Atajo shortcut() {
    return new Atajo(modifiers(), id());
  }
  
}