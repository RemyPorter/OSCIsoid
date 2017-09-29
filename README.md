# Sinusoid
## About
Sinusoid is a music/graphical application built to turn live musical performances into trippy sinusoidal patterns. The long term goal is to wire this up to a Squaver (audio controlled synth), and use the gate/pitch CV outputs to control it.

For right now, it is meant to serve as an OSC-controlled visualizer.

## Architecture
### Shader
The core of this app is `waves.glsl`, a simple sinusoid shader. The basic logic of it is that it runs points through various sin-based algorithms to generate cool patterns. Each of these algorithms is implemented as a generator function, and the total value of those functions is combined by weights. These patterns (and their weights) are controlled (in the shader) by a set of published `uniform` variables.

### Sketch
`waves.glsl` is hosted by a Processing sketch. The sketch itself supplies the `uniform`s required by the shader, and it determines their correct values by a generally "physical" modeling system- the `VariableController` objects have "momentum"- a `PVector` that allows them to be nudged (scalar variables use the magnitude of the vector, vector variables do vector addition)- and "drag", a scaling factor which shrinks the "momentum" vector with each frame.

A `GeneratorController` aggregates a bunch of `VariableControllers`. There should be a 1:1 mapping of `GeneratorController`s to generator functions in the shader.

Finally, for the sketch, there's an OscWrapper, which takes OSC messages in the address pattern "/sin/$GEN\_NAME/$VAR\_NAME", and resolves them to a specific `VariableController` to hit. The messages should contain two arguments- floating point values which can then be turned into a PVector.

### Sonic-Pi
For testing purposes, I'm using Sonic-Pi's OSC functionality to send test messages. `osc_tester.rb` is a Sonic-Pi loop which just sends a simple message every beat.