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

uniform bool isbackbuffer;
out vec4 fragData0;

/*---------------------------------------------------------------------------------------------------------
FXAA 3.11 for LeadWerks engine converted by Franck Poulain and originaly made by TIMOTHY LOTTES
---------------------------------------------------------------------------------------------------------*/

#extension GL_EXT_gpu_shader4 : enable 

// PARAMETERS
#define FXAA_QUALITY__PRESET 10

// IMPORTANT: You can find other parameters to tweak in the main() function of this shader

// Dont touch this
#define FXAA_GLSL_400
#define FXAA_GREEN_AS_LUMA 1
#define FXAA_FAST_PIXEL_OFFSET 0
#define FXAA_GATHER4_ALPHA 0

#define COLOR texture1
uniform sampler2D COLOR;
uniform vec2 buffersize;


/*--------------------------------------------------------------------------*/
#ifndef FXAA_GLSL_120
        #define FXAA_GLSL_120 0
#endif


/*==========================================================================*/
#ifndef FXAA_GREEN_AS_LUMA
        #define FXAA_GREEN_AS_LUMA 0
#endif
/*--------------------------------------------------------------------------*/

#ifndef FXAA_DISCARD
        #define FXAA_DISCARD 0
#endif
/*--------------------------------------------------------------------------*/
#ifndef FXAA_FAST_PIXEL_OFFSET
        //
        // Used for GLSL 120 only.
        //
        // 1 = GL API supports fast pixel offsets
        // 0 = do not use fast pixel offsets
        //
        #ifdef GL_EXT_gpu_shader4
                #define FXAA_FAST_PIXEL_OFFSET 1
        #endif
        #ifdef GL_NV_gpu_shader5
                #define FXAA_FAST_PIXEL_OFFSET 1
        #endif
        #ifdef GL_ARB_gpu_shader5
                #define FXAA_FAST_PIXEL_OFFSET 1
        #endif
        #ifndef FXAA_FAST_PIXEL_OFFSET
                #define FXAA_FAST_PIXEL_OFFSET 0
        #endif
#endif

/*--------------------------------------------------------------------------*/
#ifndef FXAA_GATHER4_ALPHA
        //
        // 1 = API supports gather4 on alpha channel.
        // 0 = API does not support gather4 on alpha channel.
        //
        #if (FXAA_HLSL_5 == 1)
                #define FXAA_GATHER4_ALPHA 1
        #endif
        #ifdef GL_ARB_gpu_shader5
                #define FXAA_GATHER4_ALPHA 1
        #endif
        #ifdef GL_NV_gpu_shader5
                #define FXAA_GATHER4_ALPHA 1
        #endif
        #ifndef FXAA_GATHER4_ALPHA
                #define FXAA_GATHER4_ALPHA 0
        #endif
#endif



#ifndef FXAA_QUALITY__PRESET
        #define FXAA_QUALITY__PRESET 13
#endif


/*============================================================================

                                                   FXAA QUALITY - PRESETS

============================================================================*/

/*============================================================================
                                         FXAA QUALITY - MEDIUM DITHER PRESETS
============================================================================*/

#if (FXAA_QUALITY__PRESET == 10)
        #define FXAA_QUALITY__PS 3
        #define FXAA_QUALITY__P0 1.5
        #define FXAA_QUALITY__P1 3.0
        #define FXAA_QUALITY__P2 12.0
#endif

#if (FXAA_QUALITY__PRESET == 11)
        #define FXAA_QUALITY__PS 4
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 3.0
        #define FXAA_QUALITY__P3 12.0
#endif

#if (FXAA_QUALITY__PRESET == 12)
        #define FXAA_QUALITY__PS 5
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 4.0
        #define FXAA_QUALITY__P4 12.0
#endif

#if (FXAA_QUALITY__PRESET == 13)
        #define FXAA_QUALITY__PS 6
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 4.0
        #define FXAA_QUALITY__P5 12.0
#endif

#if (FXAA_QUALITY__PRESET == 14)
        #define FXAA_QUALITY__PS 7
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 4.0
        #define FXAA_QUALITY__P6 12.0
#endif

#if (FXAA_QUALITY__PRESET == 15)
        #define FXAA_QUALITY__PS 8
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 2.0
        #define FXAA_QUALITY__P6 4.0
        #define FXAA_QUALITY__P7 12.0
#endif



#if (FXAA_QUALITY__PRESET == 20)
        #define FXAA_QUALITY__PS 3
        #define FXAA_QUALITY__P0 1.5
        #define FXAA_QUALITY__P1 2.0
        #define FXAA_QUALITY__P2 8.0
#endif

#if (FXAA_QUALITY__PRESET == 21)
        #define FXAA_QUALITY__PS 4
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 8.0
#endif

#if (FXAA_QUALITY__PRESET == 22)
        #define FXAA_QUALITY__PS 5
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 8.0
#endif

#if (FXAA_QUALITY__PRESET == 23)
        #define FXAA_QUALITY__PS 6
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 8.0
#endif

#if (FXAA_QUALITY__PRESET == 24)
        #define FXAA_QUALITY__PS 7
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 3.0
        #define FXAA_QUALITY__P6 8.0
#endif

#if (FXAA_QUALITY__PRESET == 25)
        #define FXAA_QUALITY__PS 8
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 2.0
        #define FXAA_QUALITY__P6 4.0
        #define FXAA_QUALITY__P7 8.0
#endif

#if (FXAA_QUALITY__PRESET == 26)
        #define FXAA_QUALITY__PS 9
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 2.0
        #define FXAA_QUALITY__P6 2.0
        #define FXAA_QUALITY__P7 4.0
        #define FXAA_QUALITY__P8 8.0
#endif

#if (FXAA_QUALITY__PRESET == 27)
        #define FXAA_QUALITY__PS 10
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 2.0
        #define FXAA_QUALITY__P6 2.0
        #define FXAA_QUALITY__P7 2.0
        #define FXAA_QUALITY__P8 4.0
        #define FXAA_QUALITY__P9 8.0
#endif

#if (FXAA_QUALITY__PRESET == 28)
        #define FXAA_QUALITY__PS 11
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 2.0
        #define FXAA_QUALITY__P6 2.0
        #define FXAA_QUALITY__P7 2.0
        #define FXAA_QUALITY__P8 2.0
        #define FXAA_QUALITY__P9 4.0
        #define FXAA_QUALITY__P10 8.0
#endif

#if (FXAA_QUALITY__PRESET == 29)
        #define FXAA_QUALITY__PS 12
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.5
        #define FXAA_QUALITY__P2 2.0
        #define FXAA_QUALITY__P3 2.0
        #define FXAA_QUALITY__P4 2.0
        #define FXAA_QUALITY__P5 2.0
        #define FXAA_QUALITY__P6 2.0
        #define FXAA_QUALITY__P7 2.0
        #define FXAA_QUALITY__P8 2.0
        #define FXAA_QUALITY__P9 2.0
        #define FXAA_QUALITY__P10 4.0
        #define FXAA_QUALITY__P11 8.0
#endif

#if (FXAA_QUALITY__PRESET == 39)
        #define FXAA_QUALITY__PS 12
        #define FXAA_QUALITY__P0 1.0
        #define FXAA_QUALITY__P1 1.0
        #define FXAA_QUALITY__P2 1.0
        #define FXAA_QUALITY__P3 1.0
        #define FXAA_QUALITY__P4 1.0
        #define FXAA_QUALITY__P5 1.5
        #define FXAA_QUALITY__P6 2.0
        #define FXAA_QUALITY__P7 2.0
        #define FXAA_QUALITY__P8 2.0
        #define FXAA_QUALITY__P9 2.0
        #define FXAA_QUALITY__P10 4.0
        #define FXAA_QUALITY__P11 8.0
#endif



/*============================================================================

                                                                GLSL DEFINES

============================================================================*/

        
        #define FxaaSat(x) clamp(x, 0.0, 1.0)
        #define FxaaTexTop(t, p) textureLod(t, p, 0.0)
        
        
        #if (FXAA_FAST_PIXEL_OFFSET == 1)
                #define FxaaTexOff(t, p, o, r) textureLodOffset(t, p, 0.0, o)
        #else
                #define FxaaTexOff(t, p, o, r) textureLod(t, p + (o * r), 0.0)
        #endif
   

   #if (FXAA_GATHER4_ALPHA == 1)
                // use #extension GL_ARB_gpu_shader5 : enable
                #define FxaaTexAlpha4(t, p) textureGather(t, p, 3)
                #define FxaaTexOffAlpha4(t, p, o) textureGatherOffset(t, p, o, 3)
                #define FxaaTexGreen4(t, p) textureGather(t, p, 1)
                #define FxaaTexOffGreen4(t, p, o) textureGatherOffset(t, p, o, 1)
        #endif








/*============================================================================
                                   GREEN AS LUMA OPTION SUPPORT FUNCTION
============================================================================*/
#if (FXAA_GREEN_AS_LUMA == 0)
        float FxaaLuma(vec4 rgba) { return rgba.w; }
#else
        float FxaaLuma(vec4 rgba) { return rgba.y; }
#endif  




/*============================================================================

                                                         FXAA3 QUALITY - PC

============================================================================*/

/*--------------------------------------------------------------------------*/
vec4 FxaaPixelShader(vec2 pos, vec4 fxaaConsolePosPos, sampler2D tex, sampler2D fxaaConsole360TexExpBiasNegOne, sampler2D fxaaConsole360TexExpBiasNegTwo, vec2 fxaaQualityRcpFrame, vec4 fxaaConsoleRcpFrameOpt, vec4 fxaaConsoleRcpFrameOpt2, vec4 fxaaConsole360RcpFrameOpt2, float fxaaQualitySubpix, float fxaaQualityEdgeThreshold, float fxaaQualityEdgeThresholdMin, float fxaaConsoleEdgeSharpness, float fxaaConsoleEdgeThreshold, float fxaaConsoleEdgeThresholdMin, vec4 fxaaConsole360ConstDir) 
{
/*--------------------------------------------------------------------------*/
        vec2 posM;
        posM.x = pos.x;
        posM.y = pos.y;
        #if (FXAA_GATHER4_ALPHA == 1)
                #if (FXAA_DISCARD == 0)
                        vec4 rgbyM = FxaaTexTop(tex, posM);
                        #if (FXAA_GREEN_AS_LUMA == 0)
                                #define lumaM rgbyM.w
                        #else
                                #define lumaM rgbyM.y
                        #endif
                #endif
                #if (FXAA_GREEN_AS_LUMA == 0)
                        vec4 luma4A = FxaaTexAlpha4(tex, posM);
                        vec4 luma4B = FxaaTexOffAlpha4(tex, posM, ivec2(-1, -1));
                #else
                        vec4 luma4A = FxaaTexGreen4(tex, posM);
                        vec4 luma4B = FxaaTexOffGreen4(tex, posM, ivec2(-1, -1));
                #endif
                #if (FXAA_DISCARD == 1)
                        #define lumaM luma4A.w
                #endif
                #define lumaE luma4A.z
                #define lumaS luma4A.x
                #define lumaSE luma4A.y
                #define lumaNW luma4B.w
                #define lumaN luma4B.z
                #define lumaW luma4B.x
        #else
                vec4 rgbyM = FxaaTexTop(tex, posM);
                #if (FXAA_GREEN_AS_LUMA == 0)
                        #define lumaM rgbyM.w
                #else
                        #define lumaM rgbyM.y
                #endif
                float lumaS = FxaaLuma(FxaaTexOff(tex, posM, ivec2( 0, 1), fxaaQualityRcpFrame.xy));
                float lumaE = FxaaLuma(FxaaTexOff(tex, posM, ivec2( 1, 0), fxaaQualityRcpFrame.xy));
                float lumaN = FxaaLuma(FxaaTexOff(tex, posM, ivec2( 0,-1), fxaaQualityRcpFrame.xy));
                float lumaW = FxaaLuma(FxaaTexOff(tex, posM, ivec2(-1, 0), fxaaQualityRcpFrame.xy));
        #endif
/*--------------------------------------------------------------------------*/
        float maxSM = max(lumaS, lumaM);
        float minSM = min(lumaS, lumaM);
        float maxESM = max(lumaE, maxSM);
        float minESM = min(lumaE, minSM);
        float maxWN = max(lumaN, lumaW);
        float minWN = min(lumaN, lumaW);
        float rangeMax = max(maxWN, maxESM);
        float rangeMin = min(minWN, minESM);
        float rangeMaxScaled = rangeMax * fxaaQualityEdgeThreshold;
        float range = rangeMax - rangeMin;
        float rangeMaxClamped = max(fxaaQualityEdgeThresholdMin, rangeMaxScaled);
        bool earlyExit = range < rangeMaxClamped;
/*--------------------------------------------------------------------------*/
        if(earlyExit)
                #if (FXAA_DISCARD == 1)
                        discard;
                #else
                        return rgbyM;
                #endif
/*--------------------------------------------------------------------------*/
        #if (FXAA_GATHER4_ALPHA == 0)
                float lumaNW = FxaaLuma(FxaaTexOff(tex, posM, ivec2(-1,-1), fxaaQualityRcpFrame.xy));
                float lumaSE = FxaaLuma(FxaaTexOff(tex, posM, ivec2( 1, 1), fxaaQualityRcpFrame.xy));
                float lumaNE = FxaaLuma(FxaaTexOff(tex, posM, ivec2( 1,-1), fxaaQualityRcpFrame.xy));
                float lumaSW = FxaaLuma(FxaaTexOff(tex, posM, ivec2(-1, 1), fxaaQualityRcpFrame.xy));
        #else
                float lumaNE = FxaaLuma(FxaaTexOff(tex, posM, ivec2(1, -1), fxaaQualityRcpFrame.xy));
                float lumaSW = FxaaLuma(FxaaTexOff(tex, posM, ivec2(-1, 1), fxaaQualityRcpFrame.xy));
        #endif
/*--------------------------------------------------------------------------*/
        float lumaNS = lumaN + lumaS;
        float lumaWE = lumaW + lumaE;
        float subpixRcpRange = 1.0/range;
        float subpixNSWE = lumaNS + lumaWE;
        float edgeHorz1 = (-2.0 * lumaM) + lumaNS;
        float edgeVert1 = (-2.0 * lumaM) + lumaWE;
/*--------------------------------------------------------------------------*/
        float lumaNESE = lumaNE + lumaSE;
        float lumaNWNE = lumaNW + lumaNE;
        float edgeHorz2 = (-2.0 * lumaE) + lumaNESE;
        float edgeVert2 = (-2.0 * lumaN) + lumaNWNE;
/*--------------------------------------------------------------------------*/
        float lumaNWSW = lumaNW + lumaSW;
        float lumaSWSE = lumaSW + lumaSE;
        float edgeHorz4 = (abs(edgeHorz1) * 2.0) + abs(edgeHorz2);
        float edgeVert4 = (abs(edgeVert1) * 2.0) + abs(edgeVert2);
        float edgeHorz3 = (-2.0 * lumaW) + lumaNWSW;
        float edgeVert3 = (-2.0 * lumaS) + lumaSWSE;
        float edgeHorz = abs(edgeHorz3) + edgeHorz4;
        float edgeVert = abs(edgeVert3) + edgeVert4;
/*--------------------------------------------------------------------------*/
        float subpixNWSWNESE = lumaNWSW + lumaNESE;
        float lengthSign = fxaaQualityRcpFrame.x;
        bool horzSpan = edgeHorz >= edgeVert;
        float subpixA = subpixNSWE * 2.0 + subpixNWSWNESE;
/*--------------------------------------------------------------------------*/
        if(!horzSpan) lumaN = lumaW;
        if(!horzSpan) lumaS = lumaE;
        if(horzSpan) lengthSign = fxaaQualityRcpFrame.y;
        float subpixB = (subpixA * (1.0/12.0)) - lumaM;
/*--------------------------------------------------------------------------*/
        float gradientN = lumaN - lumaM;
        float gradientS = lumaS - lumaM;
        float lumaNN = lumaN + lumaM;
        float lumaSS = lumaS + lumaM;
        bool pairN = abs(gradientN) >= abs(gradientS);
        float gradient = max(abs(gradientN), abs(gradientS));
        if(pairN) lengthSign = -lengthSign;
        float subpixC = FxaaSat(abs(subpixB) * subpixRcpRange);
/*--------------------------------------------------------------------------*/
        vec2 posB;
        posB.x = posM.x;
        posB.y = posM.y;
        vec2 offNP;
        offNP.x = (!horzSpan) ? 0.0 : fxaaQualityRcpFrame.x;
        offNP.y = ( horzSpan) ? 0.0 : fxaaQualityRcpFrame.y;
        if(!horzSpan) posB.x += lengthSign * 0.5;
        if( horzSpan) posB.y += lengthSign * 0.5;
/*--------------------------------------------------------------------------*/
        vec2 posN;
        posN.x = posB.x - offNP.x * FXAA_QUALITY__P0;
        posN.y = posB.y - offNP.y * FXAA_QUALITY__P0;
        vec2 posP;
        posP.x = posB.x + offNP.x * FXAA_QUALITY__P0;
        posP.y = posB.y + offNP.y * FXAA_QUALITY__P0;
        float subpixD = ((-2.0)*subpixC) + 3.0;
        float lumaEndN = FxaaLuma(FxaaTexTop(tex, posN));
        float subpixE = subpixC * subpixC;
        float lumaEndP = FxaaLuma(FxaaTexTop(tex, posP));
/*--------------------------------------------------------------------------*/
        if(!pairN) lumaNN = lumaSS;
        float gradientScaled = gradient * 1.0/4.0;
        float lumaMM = lumaM - lumaNN * 0.5;
        float subpixF = subpixD * subpixE;
        bool lumaMLTZero = lumaMM < 0.0;
/*--------------------------------------------------------------------------*/
        lumaEndN -= lumaNN * 0.5;
        lumaEndP -= lumaNN * 0.5;
        bool doneN = abs(lumaEndN) >= gradientScaled;
        bool doneP = abs(lumaEndP) >= gradientScaled;
        if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P1;
        if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P1;
        bool doneNP = (!doneN) || (!doneP);
        if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P1;
        if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P1;
/*--------------------------------------------------------------------------*/
        if(doneNP) {
                if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                doneN = abs(lumaEndN) >= gradientScaled;
                doneP = abs(lumaEndP) >= gradientScaled;
                if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P2;
                if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P2;
                doneNP = (!doneN) || (!doneP);
                if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P2;
                if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P2;
/*--------------------------------------------------------------------------*/
                #if (FXAA_QUALITY__PS > 3)
                if(doneNP) {
                        if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                        if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                        if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                        if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                        doneN = abs(lumaEndN) >= gradientScaled;
                        doneP = abs(lumaEndP) >= gradientScaled;
                        if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P3;
                        if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P3;
                        doneNP = (!doneN) || (!doneP);
                        if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P3;
                        if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P3;
/*--------------------------------------------------------------------------*/
                        #if (FXAA_QUALITY__PS > 4)
                        if(doneNP) {
                                if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                doneN = abs(lumaEndN) >= gradientScaled;
                                doneP = abs(lumaEndP) >= gradientScaled;
                                if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P4;
                                if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P4;
                                doneNP = (!doneN) || (!doneP);
                                if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P4;
                                if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P4;
/*--------------------------------------------------------------------------*/
                                #if (FXAA_QUALITY__PS > 5)
                                if(doneNP) {
                                        if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                        if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                        if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                        if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                        doneN = abs(lumaEndN) >= gradientScaled;
                                        doneP = abs(lumaEndP) >= gradientScaled;
                                        if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P5;
                                        if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P5;
                                        doneNP = (!doneN) || (!doneP);
                                        if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P5;
                                        if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P5;
/*--------------------------------------------------------------------------*/
                                        #if (FXAA_QUALITY__PS > 6)
                                        if(doneNP) {
                                                if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                                if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                                if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                                if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                                doneN = abs(lumaEndN) >= gradientScaled;
                                                doneP = abs(lumaEndP) >= gradientScaled;
                                                if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P6;
                                                if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P6;
                                                doneNP = (!doneN) || (!doneP);
                                                if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P6;
                                                if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P6;
/*--------------------------------------------------------------------------*/
                                                #if (FXAA_QUALITY__PS > 7)
                                                if(doneNP) {
                                                        if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                                        if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                                        if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                                        if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                                        doneN = abs(lumaEndN) >= gradientScaled;
                                                        doneP = abs(lumaEndP) >= gradientScaled;
                                                        if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P7;
                                                        if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P7;
                                                        doneNP = (!doneN) || (!doneP);
                                                        if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P7;
                                                        if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P7;
/*--------------------------------------------------------------------------*/
        #if (FXAA_QUALITY__PS > 8)
        if(doneNP) {
                if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                doneN = abs(lumaEndN) >= gradientScaled;
                doneP = abs(lumaEndP) >= gradientScaled;
                if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P8;
                if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P8;
                doneNP = (!doneN) || (!doneP);
                if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P8;
                if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P8;
/*--------------------------------------------------------------------------*/
                #if (FXAA_QUALITY__PS > 9)
                if(doneNP) {
                        if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                        if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                        if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                        if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                        doneN = abs(lumaEndN) >= gradientScaled;
                        doneP = abs(lumaEndP) >= gradientScaled;
                        if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P9;
                        if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P9;
                        doneNP = (!doneN) || (!doneP);
                        if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P9;
                        if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P9;
/*--------------------------------------------------------------------------*/
                        #if (FXAA_QUALITY__PS > 10)
                        if(doneNP) {
                                if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                doneN = abs(lumaEndN) >= gradientScaled;
                                doneP = abs(lumaEndP) >= gradientScaled;
                                if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P10;
                                if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P10;
                                doneNP = (!doneN) || (!doneP);
                                if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P10;
                                if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P10;
/*--------------------------------------------------------------------------*/
                                #if (FXAA_QUALITY__PS > 11)
                                if(doneNP) {
                                        if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                        if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                        if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                        if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                        doneN = abs(lumaEndN) >= gradientScaled;
                                        doneP = abs(lumaEndP) >= gradientScaled;
                                        if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P11;
                                        if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P11;
                                        doneNP = (!doneN) || (!doneP);
                                        if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P11;
                                        if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P11;
/*--------------------------------------------------------------------------*/
                                        #if (FXAA_QUALITY__PS > 12)
                                        if(doneNP) {
                                                if(!doneN) lumaEndN = FxaaLuma(FxaaTexTop(tex, posN.xy));
                                                if(!doneP) lumaEndP = FxaaLuma(FxaaTexTop(tex, posP.xy));
                                                if(!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
                                                if(!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
                                                doneN = abs(lumaEndN) >= gradientScaled;
                                                doneP = abs(lumaEndP) >= gradientScaled;
                                                if(!doneN) posN.x -= offNP.x * FXAA_QUALITY__P12;
                                                if(!doneN) posN.y -= offNP.y * FXAA_QUALITY__P12;
                                                doneNP = (!doneN) || (!doneP);
                                                if(!doneP) posP.x += offNP.x * FXAA_QUALITY__P12;
                                                if(!doneP) posP.y += offNP.y * FXAA_QUALITY__P12;
/*--------------------------------------------------------------------------*/
                                        }
                                        #endif
/*--------------------------------------------------------------------------*/
                                }
                                #endif
/*--------------------------------------------------------------------------*/
                        }
                        #endif
/*--------------------------------------------------------------------------*/
                }
                #endif
/*--------------------------------------------------------------------------*/
        }
        #endif
/*--------------------------------------------------------------------------*/
                                                }
                                                #endif
/*--------------------------------------------------------------------------*/
                                        }
                                        #endif
/*--------------------------------------------------------------------------*/
                                }
                                #endif
/*--------------------------------------------------------------------------*/
                        }
                        #endif
/*--------------------------------------------------------------------------*/
                }
                #endif
/*--------------------------------------------------------------------------*/
        }
/*--------------------------------------------------------------------------*/
  
        float dstN = posM.x - posN.x;
        float dstP = posP.x - posM.x;
        if(!horzSpan) dstN = posM.y - posN.y;
        if(!horzSpan) dstP = posP.y - posM.y;
/*--------------------------------------------------------------------------*/
        bool goodSpanN = (lumaEndN < 0.0) != lumaMLTZero;
        float spanLength = (dstP + dstN);
        bool goodSpanP = (lumaEndP < 0.0) != lumaMLTZero;
        float spanLengthRcp = 1.0/spanLength;
/*--------------------------------------------------------------------------*/
        bool directionN = dstN < dstP;
        float dst = min(dstN, dstP);
        bool goodSpan = directionN ? goodSpanN : goodSpanP;
        float subpixG = subpixF * subpixF;
        float pixelOffset = (dst * (-spanLengthRcp)) + 0.5;
        float subpixH = subpixG * fxaaQualitySubpix;
/*--------------------------------------------------------------------------*/
        float pixelOffsetGood = goodSpan ? pixelOffset : 0.0;
        float pixelOffsetSubpix = max(pixelOffsetGood, subpixH);
        if(!horzSpan) posM.x += pixelOffsetSubpix * lengthSign;
        if( horzSpan) posM.y += pixelOffsetSubpix * lengthSign;
        #if (FXAA_DISCARD == 1)
                return FxaaTexTop(tex, posM);
        #else
                return vec4(FxaaTexTop(tex, posM).xyz, lumaM);
        #endif
}
/*==========================================================================*/





void main( void )
{
        
        vec2 rcpFrame; 
        
        rcpFrame.x = 1.0 / buffersize.x;
        rcpFrame.y = 1.0 / buffersize.y;
 
	vec2 pos = vec2(gl_FragCoord.xy/buffersize);
	if (isbackbuffer) pos.y = 1.0 - pos.y;

        vec4 ConsolePosPos = vec4(0.0,0.0,0.0,0.0);
        vec4 ConsoleRcpFrameOpt = vec4(0.0,0.0,0.0,0.0);
        vec4 ConsoleRcpFrameOpt2 = vec4(0.0,0.0,0.0,0.0);
        vec4 Console360RcpFrameOpt2 = vec4(0.0,0.0,0.0,0.0);

        
        // Only used on FXAA Quality.
        // Choose the amount of sub-pixel aliasing removal.
        // This can effect sharpness.
        //   1.00 - upper limit (softer)
        //   0.75 - default amount of filtering
        //   0.50 - lower limit (sharper, less sub-pixel aliasing removal)
        //   0.25 - almost off
        //   0.00 - completely off
        float QualitySubpix = 0.75;
        
        // The minimum amount of local contrast required to apply algorithm.
        //   0.333 - too little (faster)
        //   0.250 - low quality
        //   0.166 - default
        //   0.125 - high quality 
        //   0.033 - very high quality (slower)
        float QualityEdgeThreshold = 0.033;
        
        // You dont need to touch theses variables it have no visible effect
        float QualityEdgeThresholdMin = 0.0;
        float ConsoleEdgeSharpness = 8.0;
        float ConsoleEdgeThreshold = 0.125;
        float ConsoleEdgeThresholdMin = 0.05;
        vec4  Console360ConstDir = vec4(1.0, -1.0, 0.25, -0.25);
  
        fragData0=FxaaPixelShader(pos, ConsolePosPos, COLOR, COLOR, COLOR, rcpFrame, ConsoleRcpFrameOpt, ConsoleRcpFrameOpt2, Console360RcpFrameOpt2, QualitySubpix, QualityEdgeThreshold, QualityEdgeThresholdMin, ConsoleEdgeSharpness, ConsoleEdgeThreshold, ConsoleEdgeThresholdMin, Console360ConstDir);
}
