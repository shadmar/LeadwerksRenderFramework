#include "Leadwerks.h"

using namespace Leadwerks;

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



