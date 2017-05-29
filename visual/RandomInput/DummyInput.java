import java.util.*;

public class DummyInput implements Input{
  public int getInput(){
    return new Random().nextInt(2);
  }
}