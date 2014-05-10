#include "Effect.h"

Skybox::Skybox(Camera* camera)
{
	m_camera = camera;
	m_shader = default_shader;
	m_camera->AddPostEffect(m_shader);
}

Skybox::Skybox(Camera* camera, std::string cubemap)
{
	m_camera = camera;
	m_cubemap = cubemap;
	m_shader = default_shader;
	m_camera->SetKeyValue("skybox_texture", m_cubemap);
	m_camera->AddPostEffect(m_shader);

}
Skybox::Skybox(Camera* camera, std::string cubemap, bool active)
{
	m_camera = camera;
	m_cubemap = cubemap;
	m_shader = default_shader;
	m_camera->SetKeyValue("skybox_texture", m_cubemap);
	if (active) m_camera->AddPostEffect(m_shader);
}
Skybox::Skybox(Camera* camera, std::string cubemap, bool active, std::string shader)
{
	m_camera = camera;
	m_cubemap = cubemap;
	m_shader = shader;
	m_camera->SetKeyValue("skybox_texture", m_cubemap);
	if (active) m_camera->AddPostEffect(m_shader);
}
void Skybox::Activate()
{
	m_camera->AddPostEffect(m_shader);
}
void Skybox::SetIntensity(const float intensity)
{
	m_intensity = intensity;
	m_camera->SetKeyValue("skybox_intensity", to_string(m_intensity));
}

Bloom::Bloom(Camera* camera)
{
	m_camera = camera;
	m_shader = default_shader;
	m_camera->AddPostEffect(m_shader);
}

Bloom::Bloom(Camera* camera, bool active)
{
	m_camera = camera;
	m_shader = default_shader;
	if (active) m_camera->AddPostEffect(m_shader);
}

Bloom::Bloom(Camera* camera, bool active, std::string shader)
{
	m_camera = camera;
	m_shader = shader;
	if (active) m_camera->AddPostEffect(m_shader);
}

void Bloom::Activate()
{
	m_camera->AddPostEffect(m_shader);
}

void Bloom::SetParams(const float lum, const float midgray, const float cutoff)
{
	m_luminance = lum;
	m_middlegray = midgray;
	m_whitecutoff = cutoff;

	m_camera->SetKeyValue("bloom_Luminance", to_string(m_luminance));
	m_camera->SetKeyValue("bloom_MiddleGray", to_string(m_middlegray));
	m_camera->SetKeyValue("bloom_WhiteCutoff", to_string(m_whitecutoff));
}

void Bloom::SetLuminance(const float lum)
{
	m_luminance = lum;
	m_camera->SetKeyValue("bloom_Luminance", to_string(m_luminance));
}
void Bloom::SetMiddlegray(const float midgray)
{
	m_middlegray = midgray;
	m_camera->SetKeyValue("bloom_MiddleGray", to_string(m_middlegray));
}
void Bloom::SetCutOff(const float cutoff)
{
	m_whitecutoff = cutoff;
	m_camera->SetKeyValue("bloom_WhiteCutoff", to_string(m_whitecutoff));
}