uniform mat4 transform;

attribute vec4 position;
attribute vec4 color;

varying vec4 vertColor;
varying float fTime;
varying vec2 fResolution;
varying float fScale;

uniform float time;
uniform vec2 resolution;
uniform float waveScale;


void main() {
  gl_Position = transform * position;
  vertColor = color;
  fTime = time;
  fResolution = resolution;
  fScale = waveScale;
}