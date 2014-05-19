#include "Effect.h"

BaseEffect::BaseEffect(long t, Camera *camera, std::string shader)
{
	type = t;

	m_camera = camera;

	m_shader = shader;

	m_active = true;
}


BaseEffect::BaseEffect(long t, Camera *camera, bool active, std::string shader)
{
	type = t;

	m_camera = camera;

	m_shader = shader;

	m_active = active;
}

void BaseEffect::Activate()
{
	m_camera->AddPostEffect(m_shader);
}


BaseEffect::~BaseEffect()
{
}

Effect::Effect()
{
}

Effect::~Effect()
{
	RemoveEffects();
}

bool Effect::AddEffect(BaseEffect *baseEffect, bool isFront)
{
	bool added = false;

	//Check if you already have added this effect
	std::list<BaseEffect*>::iterator it;

	for (it = effectList.begin(); it != effectList.end(); it++)
	{
		BaseEffect *effect = (BaseEffect*)(*it);

		if (effect->GetType() == baseEffect->GetType())
			added = false;
	}

	if (!added)
	{
		if (isFront)
			effectList.push_front(baseEffect);
		else
			effectList.push_back(baseEffect);

		baseEffect->GetCamera()->AddPostEffect(baseEffect->GetShader());

		added = true;
	}

	return added;
}

void Effect::RemoveEffects()
{
	std::list<BaseEffect*>::iterator it;

	for (it = effectList.begin(); it != effectList.end(); it++)
	{
		BaseEffect *effect = (BaseEffect*)(*it);

		delete effect;

		effect = NULL;
	}
}

bool Effect::RemoveEffectAt(int index)
{
	bool removed = false;

	int i = 0;

	std::list<BaseEffect*>::iterator it;

	for (it = effectList.begin(); it != effectList.end(); ++it)
	{
		BaseEffect *effect = (BaseEffect*)(*it);

		if (i == index)
		{
			delete *it;
			*it = 0;
			it = effectList.erase(it);

			removed = true;
		}
		else
			++it;
	}

	return removed;
}

bool Effect::RemoveEffectByType(long type)
{
	bool removed = false;

	int i = 0;

	std::list<BaseEffect*>::iterator it;

	for (it = effectList.begin(); it != effectList.end(); ++it)
	{
		BaseEffect *effect = (BaseEffect*)(*it);

		if (effect->GetType() == type)
		{
			delete *it;
			*it = 0;
			it = effectList.erase(it);

			removed = true;
		}
		else
			++it;
	}

	return removed;
}

Dof::Dof(Camera* camera) : BaseEffect(kEffectTypeDOF, camera, "Shaders/PostEffects/EffectClass/04_PP_dof.lua")
{
}

Dof::Dof(Camera* camera, bool active) : BaseEffect(kEffectTypeDOF, camera, active, "Shaders/PostEffects/EffectClass/04_PP_dof.lua")
{

}

Dof::Dof(Camera* camera, bool active, std::string shader) : BaseEffect(kEffectTypeDOF, camera, active, shader)
{
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

Skybox::Skybox(Camera* camera) : BaseEffect(kEffectTypeSkybox, camera, "Shaders/PostEffects/EffectClass/00_PP_klepto_skybox.lua")
{
}

Skybox::Skybox(Camera* camera, std::string cubemap) : BaseEffect(kEffectTypeSkybox, camera, "Shaders/PostEffects/EffectClass/00_PP_klepto_skybox.lua")
{
	m_cubemap = cubemap;
	m_camera->SetKeyValue("skybox_texture", m_cubemap);

}

Skybox::Skybox(Camera* camera, std::string cubemap, bool active) : BaseEffect(kEffectTypeSkybox, camera, active, "Shaders/PostEffects/EffectClass/00_PP_klepto_skybox.lua")
{
	m_cubemap = cubemap;
	m_camera->SetKeyValue("skybox_texture", m_cubemap);
}

Skybox::Skybox(Camera* camera, std::string cubemap, bool active, std::string shader) : BaseEffect(kEffectTypeSkybox, camera, active, shader)
{
	m_cubemap = cubemap;
	m_camera->SetKeyValue("skybox_texture", m_cubemap);
}

void Skybox::SetIntensity(const float intensity)
{
	m_intensity = intensity;
	m_camera->SetKeyValue("skybox_intensity", to_string(m_intensity));
}

Bloom::Bloom(Camera* camera) : BaseEffect(kEffectTypeBloom, camera, "Shaders/PostEffects/EffectClass/08_PP_Bloom.lua")
{
}

Bloom::Bloom(Camera* camera, bool active) : BaseEffect(kEffectTypeBloom, camera, active, "Shaders/PostEffects/EffectClass/08_PP_Bloom.lua")
{
}

Bloom::Bloom(Camera* camera, bool active, std::string shader) : BaseEffect(kEffectTypeBloom, camera, active, shader)
{
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

Fog::Fog(Camera* camera) : BaseEffect(kEffectTypeFog, camera, "Shaders/PostEffects/EffectClass/50_PP_klepto_Fog.lua")
{
}

Fog::Fog(Camera* camera, bool active) : BaseEffect(kEffectTypeFog, camera, active, "Shaders/PostEffects/EffectClass/50_PP_klepto_Fog.lua")
{
}

Fog::Fog(Camera* camera, bool active, std::string shader) : BaseEffect(kEffectTypeFog, camera, active, shader)
{
}


void Fog::SetParams(const Vec2 fogrange, const Vec4 fogcolor, const Vec2 fogangle)
{
	m_fogrange = fogrange;
	m_fogcolor = fogcolor;
	m_fogangle = fogangle;

	m_camera->SetKeyValue("fog_fogrange", to_string(m_fogrange.x) + "," + to_string(m_fogrange.y));
	m_camera->SetKeyValue("fog_fogcolor", to_string(m_fogcolor.x) + "," + to_string(m_fogcolor.y) + "," + to_string(m_fogcolor.z) + "," + to_string(m_fogcolor.w));
	m_camera->SetKeyValue("fog_fogangle", to_string(m_fogangle.x) + "," + to_string(m_fogangle.y));
}
void Fog::SetFogRange(const Vec2 fogrange)
{
	m_fogrange = fogrange;
	m_camera->SetKeyValue("fog_fogrange", to_string(m_fogrange.x) + "," + to_string(m_fogrange.y));
}
void Fog::SetFogColor(const Vec4 fogcolor)
{
	m_fogcolor = fogcolor;
	m_camera->SetKeyValue("fog_fogcolor", to_string(m_fogcolor.x) + "," + to_string(m_fogcolor.y) + "," + to_string(m_fogcolor.z) + "," + to_string(m_fogcolor.w));
}
void Fog::SetFogAngle(const Vec2 fogangle)
{
	m_fogangle = fogangle;
	m_camera->SetKeyValue("fog_fogangle", to_string(m_fogangle.x) + "," + to_string(m_fogangle.y));
}
