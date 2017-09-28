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

GeneratorController MarchingX = new GeneratorController(
  new FloatController("marchingXWeight", 1.0, 0.99, 0.0, 1.0),
  new FloatController("marchingXDir", -1.0, 0.99, -2, 2)
);