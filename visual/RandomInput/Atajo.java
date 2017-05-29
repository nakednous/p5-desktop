import remixlab.bias.*;

public class Atajo extends Shortcut {
  public Atajo(int m, int id) {
    super(m, id);
  }

  @Override
  public Class eventClass() {
    return Evento.class;
  }

  public static int registerID(int id, String description) {
    return Shortcut.registerID(Atajo.class, id, description);
  }

  public static int registerID(String description) {
    return Shortcut.registerID(Atajo.class, description);
  }

  public static boolean hasID(int id) {
    return Shortcut.hasID(Atajo.class, id);
  }
}