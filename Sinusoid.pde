import java.awt.Rectangle; 
PShader waves;

void setup() {
  size(640, 640, P3D);
  //fullScreen(P3D);
  waves = loadShader("waves.glsl");
}

void mousePressed() {
  Rotion.hit("rotionWeight", new PVector(0.2, 0));
}

void draw() {
  //xdir += random(-0.25,0.25);
  waves.set("resolution", new PVector(width, height, 0));
  waves.set("time", millis() / 1000.0);
  waves.set("scale", 15.0);
  
  osc.set(waves);
  
  shader(waves);
  fill(#FF0000);
  rect(0, 0, width, height);
}