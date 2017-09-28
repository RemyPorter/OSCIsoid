#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec3 resolution;
uniform float scale;
/////////// controls

uniform float marchingXWeight;
uniform float marchingYWeight;
uniform float marchingXDir;

uniform vec3 rotionCenter;
uniform float rotionWeight;

uniform float cubidWeight;
uniform float cubidPower;

uniform float divXWeight;

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

/////////////////////////

void main( void ) {
    vec2 position = gl_FragCoord.xy / resolution.xy;
    vec2 rc = rotionCenter.xy;// / resolution.xy;
    position *= scale;

    float step = (marchingX(position, marchingXDir, time) * marchingXWeight
         + marchingY(position, 1.543, time) * marchingYWeight
         + rotion(position, 2, time, rc) * rotionWeight
         + cubid(position, cubidPower, time) * cubidWeight
         + divX(position, 15, time) * divXWeight
         ) / 2;

    gl_FragColor = vec4(step, step, step, 1.0 );

}