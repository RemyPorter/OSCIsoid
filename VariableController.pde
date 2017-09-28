class VariableController<T> {
  PVector momentum;
  T value;
  String name;
  float drag;

  public VariableController(String name, T def, float drag) {
    this.name = name;
    this.value = def;
    this.drag = drag;
    momentum = new PVector(0,0);
  }

  public void hit(PVector hit) {
    momentum.add(hit);
  };

  public void set(PShader ps) {};
}

class FloatController extends VariableController<Float> {
  public FloatController(String name, Float def, float drag) {
    super(name, def, drag);
  }

  void set(PShader ps) {
    value += momentum.mag();
    ps.set(name, value);
    momentum.mult(drag);
  }
}

class VectorController extends VariableController<PVector> {
  public VectorController(String name, PVector def, float drag) { 
    super(name, def, drag);
  }

  void set(PShader ps) {
    value.add(momentum);
    ps.set(name, value);
    momentum.mult(drag);
  }
}