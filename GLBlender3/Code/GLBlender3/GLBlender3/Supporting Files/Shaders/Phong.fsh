// Fragment Shader

static const char* PhongFSH = STRINGIFY
(

// Varying
varying highp vec3 vNormal;
varying highp vec2 vTexel;
 
// Uniforms
uniform highp vec3 uDiffuse;
uniform highp vec3 uSpecular;
uniform sampler2D uTexture;

void main(void) {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}

);
