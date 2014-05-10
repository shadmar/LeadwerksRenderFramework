SHADER version 1
@OpenGL2.Vertex
uniform mat4 projectionmatrix;
uniform mat4 drawmatrix;
uniform vec2 offset;
uniform vec2 position[4];
uniform vec2 texcoords[4];

attribute vec3 vertex_position;

varying vec2 ex_texcoords0;

void main(void)
{
	int i = int(vertex_position.x);//gl_VertexID was implemented in GLSL 1.30, not available in 1.20.
	gl_Position = projectionmatrix * (drawmatrix * vec4(position[i], 1.0, 1.0));
	ex_texcoords0 = texcoords[i];
}
@OpenGL2.Fragment
uniform sampler2D texture0;
uniform vec2 buffersize;
uniform vec4 drawcolor;

varying vec2 ex_texcoords0;

void main(void)
{
	gl_FragColor = texture2D(texture0,ex_texcoords0) * drawcolor;
}
@OpenGLES2.Vertex
uniform mediump mat4 projectionmatrix;
uniform mediump mat4 drawmatrix;
uniform mediump vec2 offset;

attribute mediump vec3 vertex_position;
attribute mediump vec2 vertex_texcoords0;

varying mediump vec2 ex_texcoords0;

void main(void)
{
	gl_Position = projectionmatrix * (drawmatrix * vec4(vertex_position, 1.0) + vec4(offset,0,0));
	ex_texcoords0 = vertex_texcoords0;
}
@OpenGLES2.Fragment
uniform sampler2D texture0;
uniform mediump vec2 buffersize;
uniform mediump vec4 drawcolor;

varying mediump vec2 ex_texcoords0;

void main(void)
{
	gl_FragData[0] = texture2D(texture0,ex_texcoords0) * drawcolor;
}
@OpenGL4.Vertex
#version 400

uniform mat4 projectionmatrix;
uniform mat4 drawmatrix;
uniform vec2 offset;
uniform vec2 position[4];

in vec3 vertex_position;

void main(void)
{
	gl_Position = projectionmatrix * (drawmatrix * vec4(position[gl_VertexID]+offset, 0.0, 1.0));
}
@OpenGL4.Fragment
#version 400

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform bool isbackbuffer;
uniform vec2 buffersize;
uniform float currenttime;

out vec4 fragData0;
in vec4 fragData2;

void main(void)
{

vec2 icoord = vec2(gl_FragCoord.xy/buffersize);
if (isbackbuffer) icoord.y = 1.0 - icoord.y;
	
	vec4 scene = texture2D(texture1, icoord); // rendered scene
	vec4 blur = texture2D(texture2, icoord); // glowmap
	fragData0 = clamp(scene + (blur), 0.0, 1.0);
}


/*
uniform vec4 drawcolor;

uniform vec2 blurbuffersize;

//Screen diffuse
uniform sampler2D texture0;

//Bloom texture
uniform sampler2D texture2;

//Shadow camera matrix
uniform vec2 gbuffersize;
uniform float camerazoom;
uniform vec2 camerarange;
uniform vec3 lightdir;
uniform mat4 camerainversematrix;
uniform mat4 camimat;
uniform vec3 campos;

varying vec2 ex_texcoords0;

void main(void)
{
	float ambient = 0.125;
	
        //Get diffuse color
        vec4 outcolor = texture2D(texture0,ex_texcoords0);
        
        vec4 bloom = texture2D(texture2,ex_texcoords0);
	vec4 obloom = bloom;
        float box = 1.0 / (blurbuffersize.x);
        float boy = 1.0 / (blurbuffersize.y);
        bloom.a = 0.0;
	
	vec4 dst = texture2D(texture0, ex_texcoords0); // rendered scene
	vec4 src = texture2D(texture2, ex_texcoords0); // glowmap
	src = (src * 0.5) + 0.5;
	float bloomthreshold = 0.75;
        float bloompower = 2.0;
	bloom = bloom * bloom * bloompower;
	gl_FragColor = dst + bloom;
}*/
