import java.util.HashMap;
class GeneratorController {
  HashMap<String, VariableController> lookup = new HashMap<String, VariableController>();
  public GeneratorController(VariableController... vars) {
    for (VariableController v : vars) {
      lookup.put(v.name, v);
    }
  }

  public void set(PShader s) {
    for (VariableController v : lookup.values()) {
      v.set(s);
    }
  }

  public void hit(String variable, PVector amount) {
    lookup.get(variable).hit(amount);
  }
}

public static class GeneratorBuilder {
  ArrayList<VariableController> vars = new ArrayList<VariableController>();
  Sinusoid host;
  protected GeneratorBuilder(Sinusoid host) {
    this.host = host;
  }
  public static GeneratorBuilder create(Sinusoid host) {
    return new GeneratorBuilder(host);
  }

  public GeneratorBuilder add(String name, float def, float drag,
     float lowerBound, float upperBound) {
    VariableController obj = host.new FloatController(name, def, drag, lowerBound, upperBound);
    this.vars.add(obj);
    
    return this;
  }

  public GeneratorBuilder add(String name, PVector def, float drag, Rectangle bounds) 
  {
    VariableController obj = host.new VectorController(name, def, drag, bounds);
    this.vars.add(obj);
    return this;
  }

  public GeneratorBuilder addWeight(String name) {
    VariableController obj = host.new WeightController(name);
    this.vars.add(obj);
    return this;
  }

  public GeneratorBuilder addPosition(String name, float drag) {
    VariableController obj = host.new PositionController(name, drag);
    this.vars.add(obj);
    return this;
  }

  public GeneratorController build() {
    return host.new GeneratorController(vars.toArray(new VariableController[1]));
  }
}