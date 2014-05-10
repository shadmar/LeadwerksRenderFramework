#include "Effect.h"

Dof::Dof(Camera* camera)
{
	m_camera = camera;
	m_shader = default_shader;
	m_camera->AddPostEffect(m_shader);
}

Dof::Dof(Camera* camera, bool active)
{
	m_camera = camera;
	m_shader = default_shader;
	if (active) m_camera->AddPostEffect(m_shader);
}
Dof::Dof(Camera* camera, bool active, std::string shader)
{
	m_camera = camera;
	m_shader = shader;
	if (active) m_camera->AddPostEffect(m_shader);
}

void Dof::SetNearStart(const float nearstart)
{
	m_ndofstart = nearstart;
	m_camera->SetKeyValue("dof_ndofstart", to_string(m_ndofstart));
}

void Dof::SetNearDist(const float neardist)
{
	m_ndofdist = neardist;
	m_camera->SetKeyValue("dof_ndofdist", to_string(m_ndofdist));
}

void Dof::SetFarStart(const float farstart)
{
	m_fdofstart = farstart;
	m_camera->SetKeyValue("dof_fdofstart", to_string(m_fdofstart));
}

void Dof::SetFarDist(const float fardist)
{
	m_fdofdist = fardist;
	m_camera->SetKeyValue("dof_fdofdist", to_string(m_fdofdist));
}

void Dof::EnableVignette(const bool enabled)
{
	m_vignetting = true;
	if (m_vignetting)
		m_camera->SetKeyValue("dof_vignetting", to_string(1));
	else
		m_camera->SetKeyValue("dof_vignetting", to_string(0));
}

void Dof::SetVinetteOuterBorder(const float outerborder)
{
	m_vignout = outerborder;
	m_camera->SetKeyValue("dof_vignout", to_string(m_vignout));
}

void Dof::SetVinetteInnerBorder(const float innerborder)
{
	m_vignin = innerborder;
	m_camera->SetKeyValue("dof_vignin", to_string(m_vignin));
}

void Dof::SetVinetteFade(const float fade)
{
	m_vignfade = fade;
	m_camera->SetKeyValue("dof_vignfade", to_string(m_vignfade));
}

void Dof::SetMaxBlur(const float maxblur)
{
	m_maxblur = maxblur;
	m_camera->SetKeyValue("dof_maxblur", to_string(m_maxblur));
}

void Dof::SetHighlightThreshold(const float treshold)
{
	m_threshold = treshold;
	m_camera->SetKeyValue("dof_threshold", to_string(m_threshold));
}
void Dof::SetHighlightGain(const float gain)
{
	m_gain = gain;
	m_camera->SetKeyValue("dof_gain", to_string(m_gain));
}

void Dof::SetBokehBias(const float bias)
{
	m_bias = bias;
	m_camera->SetKeyValue("dof_bias", to_string(m_bias));
}
void Dof::GetBokehFringe(const float fringe)
{
	m_fringe = fringe;
	m_camera->SetKeyValue("dof_fringe", to_string(m_fringe));
}
void Dof::SetDither(const float dither)
{
	m_namount = dither;
	m_camera->SetKeyValue("dof_namount", to_string(m_namount));
}

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