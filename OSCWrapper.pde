import java.util.HashMap;
import oscP5.*;
import netP5.*;

class OscWrapper {
  OscP5 osc;
  HashMap<String, GeneratorController> gens = new HashMap<String, GeneratorController>();
  
  public OscWrapper(int port) {
    osc = new OscP5(this, port);
  }

  public OscWrapper add(String name, GeneratorController gen) {
    gens.put(name, gen);
    return this;
  }

  public void oscEvent(OscMessage msg) {
    String[] parsed = msg.addrPattern().split("/");
    String objectName = parsed[1];
    String genName = parsed[2];
    String varName = parsed[3];

    if (!objectName.equals("sin")) return; //abort if this isn't for us
    try {
      float x = (float)msg.arguments()[0];
      float y = (float)msg.arguments()[1];
      
      PVector force = new PVector(x, y);
      if (gens.containsKey(genName)) {
        gens.get(genName).hit(varName, force);
      }
    } catch (Exception ex) {
      println(ex);
      println(msg.typetag(), msg.addrPattern());
    }
  }

  public void set(PShader shader) {
    for (GeneratorController g : gens.values()) {
      g.set(shader);
    }
  }


}