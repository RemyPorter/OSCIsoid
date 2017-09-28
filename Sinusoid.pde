import java.awt.Rectangle; 
PShader waves;
float xdir = -1.2;

void setup() {
  //size(640, 640, P3D);
  fullScreen(P3D);
  waves = loadShader("waves.glsl");
}

void draw() {
  //xdir += random(-0.25,0.25);
  waves.set("resolution", new PVector(width, height, 0));
  waves.set("time", millis() / 1000.0);
  waves.set("scale", 15.0);
  
  MarchingX.set(waves);
  if (random(0.0,1.0) > 0.85)
    MarchingX.hit("marchingXDir", new PVector(0.03, 0));

  waves.set("rotionWeight", 0.0);
  waves.set("cubidWeight", 0.05);
  waves.set("cubidPower", 3.2);
  waves.set("divXWeight", 0.0);
  shader(waves);
  fill(#FF0000);
  rect(0, 0, width, height);
}