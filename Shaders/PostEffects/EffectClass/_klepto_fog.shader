SHADER version 1
@OpenGL2.Vertex
//Uniforms
uniform mat4 entitymatrix;
uniform mat4 projectioncameramatrix;

//Attributes
attribute vec3 vertex_position;

//Outputs
varying vec4 ex_color;
varying float ex_selectionstate;

void main()
{
	mat4 entitymatrix_=entitymatrix;
	entitymatrix_[0][3]=0.0;
	entitymatrix_[1][3]=0.0;
	entitymatrix_[2][3]=0.0;
	entitymatrix_[3][3]=1.0;
	
	gl_Position = projectioncameramatrix * entitymatrix_ * vec4(vertex_position, 1.0);
	
	ex_color = vec4(entitymatrix[0][3],entitymatrix[1][3],entitymatrix[2][3],entitymatrix[3][3]);
	
	//If an object is selected, 10 is subtracted from the alpha color.
	//This is a bit of a hack that packs a per-object boolean into the alpha value.
	ex_selectionstate = 0.0;
	if (ex_color.a<-5.0)
	{
		ex_color.a += 10.0;
		ex_selectionstate = 1.0;
	}
}
@OpenGL2.Fragment
//Inputs
varying vec4 ex_color;
varying float ex_selectionstate;

void main(void)
{
	gl_FragColor = ex_color * (1.0-ex_selectionstate) + ex_selectionstate * (ex_color*0.5+vec4(0.5,0.0,0.0,0.0));
}
@OpenGLES2.Vertex
//Uniforms
uniform mediump mat4 entitymatrix;
uniform mediump mat4 projectioncameramatrix;

//Attributes
attribute mediump vec3 vertex_position;

//Outputs
varying mediump vec4 ex_color;

void main()
{
	mat4 entitymatrix_=entitymatrix;
	entitymatrix_[0][3]=0.0;
	entitymatrix_[1][3]=0.0;
	entitymatrix_[2][3]=0.0;
	entitymatrix_[3][3]=1.0;
	
	gl_Position = projectioncameramatrix * entitymatrix_ * vec4(vertex_position, 1.0);
	ex_color = vec4(entitymatrix[0][3],entitymatrix[1][3],entitymatrix[2][3],entitymatrix[3][3]);
}
@OpenGLES2.Fragment
//Inputs
varying mediump vec4 ex_color;

void main(void)
{
	gl_FragColor = ex_color;
}
@OpenGL4.Vertex
#version 400

uniform mat4 projectionmatrix;
uniform mat4 drawmatrix;
uniform vec2 offset;
uniform vec2 position[4];
uniform mat4 projectioncameramatrix;
uniform mat4 camerainversematrix;
uniform vec3 cameraposition;

in vec3 vertex_position;

void main() {
    gl_Position = projectionmatrix * (drawmatrix * vec4(position[gl_VertexID]+offset, 0.0, 1.0));
}
@OpenGL4.Fragment
#version 400

uniform sampler2D texture1;
uniform samplerCube texture2;
uniform sampler2DMS texture3;

uniform bool isbackbuffer;
uniform vec2 buffersize;
out vec4 fragData0;
uniform samplerCube uTexture;
smooth in vec3 eyeDirection;
uniform vec2 camerarange;
uniform float camerazoom;
uniform vec3 cameraposition;
uniform mat4 camerainversematrix;
uniform mat4 projectionmatrix;

uniform vec2 fogrange = vec2(0.0,15.0);
uniform vec4 fogcolor = vec4(0.72,0.73,0.67,1.0);
uniform vec2 fogangle  = vec2(5.0,15.0);


float DepthToZPosition(in float depth) {
	return camerarange.x / (camerarange.y - depth * (camerarange.y - camerarange.x)) * camerarange.y;
}

void main() {
	//integer screen coordinates
	//needed for depth lookup
	ivec2 icoord = ivec2(gl_FragCoord.xy);
	if (isbackbuffer) icoord.y = int(buffersize.y) - icoord.y;
	
	//floating screencoords normalised to range 0-1
	vec2 coord = vec2(gl_FragCoord.xy/buffersize);
	if (isbackbuffer) coord.y = 1.0 - coord.y;

	//fetch depth value
	float depth = texelFetch(texture3,icoord,0).x;

	//calculating worldposition from cameramatrix,screenposition and depth
	//normalize it to get the cubecoords
	vec3 screencoord;
	screencoord = vec3(((coord.x)-0.5) * 2.0,((coord.y)-0.5) * 2.0 / (buffersize.x/buffersize.y),DepthToZPosition( depth ));
	screencoord.x *= screencoord.z;
	screencoord.y *= -screencoord.z;
	vec4 worldpostemp= vec4(screencoord,1.0) * camerainversematrix;
	vec3 worldpos = worldpostemp.xyz;// / 1.0-worldpostemp.w;
	worldpos+=cameraposition;
	vec3 cubecoord = normalize(worldpos.xyz);

	fragData0 = texture(texture1,coord);

	if(depth == 1.0) //no geometry rendered --> background
	{		
		vec3 normal=normalize(cubecoord);
		normal.y=max(normal.y,0.0);
		float angle=asin(normal.y)*57.2957795-fogangle.x;
		float fogeffect=1.0-clamp(angle/(fogangle.y-fogangle.x),0.0,1.0);
		fogeffect *= fogcolor.w;
		fragData0=fragData0*(1.0-fogeffect)+fogeffect*fogcolor;
        }
	else // no background - render input + fog to output
	{
		float lineardepth = DepthToZPosition(depth);
		float fogeffect = clamp( 1.0 - (fogrange.y - lineardepth) / (fogrange.y - fogrange.x) , 0.0, 1.0 );
		fragData0 = fragData0 * (1.0 - fogeffect) + fogcolor * fogeffect;	
	}
}
