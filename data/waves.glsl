#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec3 resolution;
uniform float scale;
/////////// controls

uniform float marchingXWeight;
uniform float marchingYWeight;
uniform float marchingXDir;
uniform float marchingYDir;

uniform vec3 rotionCenter;
uniform float rotionWeight;
uniform float rotionSpeed;

uniform float cubidWeight;
uniform float cubidPower;

uniform float divXWeight;
uniform float divXSpeed;

uniform float divYSpeed;
uniform float divYWeight;

uniform float checkSpeed;
uniform float checkWeight;
uniform float checkStrength;

uniform float tulipSpeed;
uniform float tulipDir;
uniform float tulipWeight;

uniform float infiniteSpeed;
uniform float infiniteWeight;

/////////////////////

/////////// generator functions

float marchingX(vec2 pos, float speed, float time) {
    return abs(sin(pos.x * speed + time));
}

float marchingY(vec2 pos, float speed, float time) {
    return abs(sin(pos.y * speed + time));
}

float rotion(vec2 pos, float speed, float time, vec2 c) {
    return sin(speed * distance(vec2(pos.x*5,pos.y*5), c) / 2 + time);
}

float cubid(vec2 pos, float speed, float time) {
    return cos(pow(pos.x / 3, speed) - pow(pos.y / 3, speed) - time);
}

float divX(vec2 pos, float speed, float time) {
    return sin(speed * pos.x / (pos.y + 10 + time) + time);
}

float divY(vec2 pos, float speed, float time) {
  return sin(speed * pos.y / (pos.x + 10 + time) + time);
}

float checker(vec2 pos, float speed, float time, float strength) {
  return sin(pos.x * speed) * cos(pos.y * speed) + strength;
}

float tulip(vec2 pos, float speed, float time, float dir) {
  return sin(pos.y + cos(pos.x) * speed * dir + tan(pos.y + time * dir) - cos(pos.x + time * dir));
}

float infiniteChecker(vec2 pos, float speed, float time) {
  return sin(pos.x * pos.y * speed / 2) + cos(speed * pos.x / (pos.y + 0.0000001) - time);
}

/////////////////////////

void main( void ) {
    vec2 position = gl_FragCoord.xy / resolution.xy;
    vec2 rc = rotionCenter.xy;// / resolution.xy;
    position *= scale;

    float step = (marchingX(position, marchingXDir, time) * marchingXWeight
         + marchingY(position, marchingYDir, time) * marchingYWeight
         + rotion(position, rotionSpeed, time, rc) * rotionWeight
         + cubid(position, cubidPower, time) * cubidWeight
         + divX(position, divXSpeed, time) * divXWeight
         + divY(position, divYSpeed, time) * divYWeight
         + checker(position, checkSpeed, time, checkStrength) * checkWeight
         + tulip(position, tulipSpeed, time, tulipDir) * tulipWeight
         + infiniteChecker(position, infiniteSpeed, time) * infiniteWeight
         ) / 2;

    gl_FragColor = vec4(step, step, step, 1.0 );

}