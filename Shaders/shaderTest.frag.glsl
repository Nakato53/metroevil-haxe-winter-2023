#version 450

#ifdef GL_ES
precision mediump float;
#endif

uniform float width;
uniform float height;

out vec4 fragColor;

void main(){
     vec2 st = gl_FragCoord.xy;
	fragColor = vec4(st.x/width,st.y/height,1, 1.0);
}