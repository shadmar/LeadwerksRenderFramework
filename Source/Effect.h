#include "Leadwerks.h"

using namespace Leadwerks;

class Dof
{
private:
	float m_ndofstart; //near dof blur start
	float m_ndofdist;  //near dof blur falloff distance
	float m_fdofstart; //far dof blur start
	float m_fdofdist; //far dof blur falloff distance

	bool m_vignetting; //use optical lens vignetting?
	float m_vignout;   //vignetting outer border
	float m_vignin;    //vignetting inner border
	float m_vignfade;  //f-stops till vignette fades

	float m_maxblur;   //clamp value of max blur (0.0 = no blur,1.0 default)

	float m_threshold; //highlight threshold;
	float m_gain;	   //highlight gain;
	float m_bias;	   //bokeh edge bias
	float m_fringe;    //bokeh chromatic aberration/fringing
	float m_namount;   //dither amount

	std::string m_shader;
	Camera* m_camera;
public:
	Dof();
	Dof(Camera* camera);
	Dof(Camera* camera, bool active);
	Dof(Camera* camera, bool active, std::string shader);
	~Dof(){ delete m_camera; };

	void Activate();

	void SetNearStart(const float nearstart);
	void SetNearDist(const float neardist);
	void SetFarStart(const float farstart);
	void SetFarDist(const float fardist);

	void EnableVignette(const bool enabled);
	void SetVinetteOuterBorder(const float outerborder);
	void SetVinetteInnerBorder(const float innerborder);
	void SetVinetteFade(const float fade);

	void SetMaxBlur(const float maxblur);

	void SetHighlightThreshold(const float treshold);
	void SetHighlightGain(const float gain);

	void SetBokehBias(const float bias);
	void GetBokehFringe(const float fringe);
	void SetDither(const float dither);

	const float GetNearStart() { return m_ndofstart; }
	const float GetNearDist() { return m_ndofdist; }
	const float GetFarStart() { return m_fdofstart; }
	const float GetFarDist() { return m_fdofdist; }

	const bool GetVignetteEnabled() { return m_vignetting; }
	const float GetVinetteOuterBorder() { return m_vignout; }
	const float GetVinetteInnerBorder() { return m_vignin; }
	const float GetVinetteFade() { return m_vignfade; }

	const float GetMaxBlur() { return m_maxblur; }

	const float GetHighlightThreshold() { return m_threshold; }
	const float GetHighlightGain() { return m_gain; }

	const float GetBokehBias() { return m_bias; }
	const float GetBokehFringe() { return m_fringe; }
	const float GetDither() { return m_namount; }

	const std::string default_shader = "Shaders/PostEffects/EffectClass/04_PP_dof.lua";
};

class Skybox
{
private:
	float m_intensity;
	std::string m_shader;
	std::string m_cubemap;
	Camera* m_camera;
public:
	Skybox();
	Skybox(Camera* camera);
	Skybox(Camera* camera, std::string cubemap);
	Skybox(Camera* camera, std::string cubemap, bool active);
	Skybox(Camera* camera, std::string cubemap, bool active, std::string shader);
	~Skybox(){ delete m_camera; };

	void Activate();
	void SetIntensity(const float intensity);

	const float GetIntensity() { return m_intensity; }

	const std::string default_shader = "Shaders/PostEffects/EffectClass/00_PP_klepto_skybox.lua";
};

class Bloom
{
private:
	float m_luminance;
	float m_middlegray;
	float m_whitecutoff;
	std::string m_shader;
	Camera* m_camera;

public:
	Bloom();
	Bloom(Camera* camera);
	Bloom(Camera* camera, bool active);
	Bloom(Camera* camera, bool active, std::string shader);
	~Bloom(){ delete m_camera; };

	void Activate();
	void SetParams(const float lum, const float midgray, const float cutoff);
	void SetLuminance(const float lum);
	void SetMiddlegray(const float midgray);
	void SetCutOff(const float cutoff);

	const float GetLuminance() { return m_luminance; }
	const float GetMiddlegray() { return m_middlegray; }
	const float GetCutOff() { return m_whitecutoff; }

	const std::string default_shader = "Shaders/PostEffects/EffectClass/08_PP_Bloom.lua";
};



