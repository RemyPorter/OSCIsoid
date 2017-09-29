import java.awt.Rectangle; 
PShader waves;

GeneratorController MarchingX = GeneratorBuilder.create(this)
              .add("marchingXWeight", 1.0, 0.99, 0.0, 1.0)
              .add("marchingXDir", -1.0, 0.99, -2, 2)
              .build();

GeneratorController Rotion = GeneratorBuilder.create(this)
              .add("rotionWeight", 0.5, 0.8, 0.0, 1.0)
              .add("rotionCenter", new PVector(50,50), 
                0.999,new Rectangle(0,0,100,100))
              .build();

OscWrapper osc = new OscWrapper(4601)
              .add("marchingX", MarchingX)
              .add("rotion", Rotion);

void setup() {
  size(640, 640, P3D);
  //fullScreen(P3D);
  waves = loadShader("waves.glsl");
}

void mousePressed() {
  Rotion.hit("rotionCenter", PVector.random2D());
}

void draw() {
  //xdir += random(-0.25,0.25);
  waves.set("resolution", new PVector(width, height, 0));
  waves.set("time", millis() / 1000.0);
  waves.set("scale", 15.0);
  
  MarchingX.set(waves);
  Rotion.set(waves);
  if (random(0.0,1.0) > 0.85)
    MarchingX.hit("marchingXDir", new PVector(0.03, 0));

  waves.set("cubidWeight", 0.05);
  waves.set("cubidPower", 3.2);
  waves.set("divXWeight", 0.0);
  shader(waves);
  fill(#FF0000);
  rect(0, 0, width, height);
}