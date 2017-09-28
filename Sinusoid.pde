import java.awt.Rectangle; 
PShader waves;
float xdir = -1.2;
VariableController xWeight = new FloatController(
  "marchingXWeight", 0.25, 0.5, 0.0, 1.0
);
VariableController rotionCenter = new VectorController(
  "rotionCenter", new PVector(60,60), 0.99,
  new Rectangle(0, 0, 90, 90)
);
void setup() {
  //size(640, 640, P3D);
  fullScreen(P3D);
  waves = loadShader("waves.glsl");
  xWeight.hit(new PVector(-0.2, 0));
  rotionCenter.hit(PVector.random2D());
}

void mouseClicked() {
  rotionCenter.hit(PVector.random2D());
}



void draw() {
  //xdir += random(-0.25,0.25);
  waves.set("resolution", new PVector(width, height, 0));
  waves.set("time", millis() / 1000.0);
  waves.set("scale", 15.0);
  xWeight.set(waves);
  waves.set("marchingYWeight", 0.0);
  waves.set("marchingXDir", xdir);
  rotionCenter.set(waves);
  waves.set("rotionWeight", 0.3);
  waves.set("cubidWeight", 0.05);
  waves.set("cubidPower", 3.2);
  waves.set("divXWeight", 1.0);
  shader(waves);
  fill(#FF0000);
  rect(0, 0, width, height);
}