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

uniform float Intensity=1.0;


float DepthToZPosition(in float depth) {
	return camerarange.x / (camerarange.y - depth * (camerarange.y - camerarange.x)) * camerarange.y;
}

vec3 ScreenToWorldPosition(in float depth)
{
	vec2 coord = vec2(gl_FragCoord.x/buffersize.x,(-gl_FragCoord.y) / buffersize.y);
	vec3 screencoord = vec3(((coord.x)-0.5) * 2.0 * (buffersize.x/buffersize.y),((coord.y)+0.5) * 2.0,DepthToZPosition(depth));
	screencoord.x *= screencoord.z / camerazoom;
	screencoord.y *= -screencoord.z / camerazoom;
	if (!isbackbuffer) screencoord.y = 1.0 - screencoord.y;
	return  (vec4(screencoord,1.0) * camerainversematrix).xyz;
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

	vec3 cubecoord = ScreenToWorldPosition(depth);

	float isAtFarPlane = step(0.9998, depth);

	if(depth == 1) //no geometry rendered --> background
	{
		//copy skybox to output
		fragData0 = texture(texture2,cubecoord)*Intensity;

	}
	else
		fragData0 = texture(texture1,coord);
}
