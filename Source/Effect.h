#include "Leadwerks.h"

using namespace Leadwerks;

enum
{
	kEffectTypeDOF = 'edof',
	kEffectTypeSkybox = 'esky',
	kEffectTypeBloom = 'eblo',
	kEffectTypeFog = 'efog'
};

class BaseEffect
{
	private:

		long					type;

		bool					m_active;

	protected:

		std::string				m_shader;

		Camera*					m_camera;

	public:

		BaseEffect(long type, Camera* camera, std::string shader);
		BaseEffect(long type, Camera* camera, bool active, std::string shader);
		~BaseEffect();

		virtual void Activate(void);

		long GetType(void)
		{
			return type;
		}

		void SetType(long t)
		{
			type = t;
		}

		bool GetActive(void)
		{
			return m_active;
		}

		void SetActive(bool a)
		{
			m_active = a;
		}

		std::string GetShader(void)
		{
			return m_shader;
		}

		void SetShader(std::string shader)
		{
			m_shader = shader;
		}

		Camera *GetCamera(void)
		{
			return m_camera;
		}
};


class Effect
{
	private:

		std::list<BaseEffect*>                    effectList;

	public:

		Effect();
		~Effect();

		void Update(void);

		bool AddEffect(BaseEffect *effect, bool isFront);

		bool RemoveEffectAt(int index);

		bool RemoveEffectByType(long type);

		void RemoveEffects();
};

extern Effect *TheEffect;


class Dof : public BaseEffect
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

public:
	Dof();
	Dof(Camera* camera);
	Dof(Camera* camera, bool active);
	Dof(Camera* camera, bool active, std::string shader);
	~Dof(){};

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
};

class Skybox : public BaseEffect
{
private:
	float m_intensity;
	std::string m_cubemap;
public:
	Skybox();
	Skybox(Camera* camera);
	Skybox(Camera* camera, std::string cubemap);
	Skybox(Camera* camera, std::string cubemap, bool active);
	Skybox(Camera* camera, std::string cubemap, bool active, std::string shader);
	~Skybox(){};

	void SetIntensity(const float intensity);

	const float GetIntensity() { return m_intensity; }
};

class Bloom : public BaseEffect
{
private:
	float m_luminance;
	float m_middlegray;
	float m_whitecutoff;


public:
	Bloom();
	Bloom(Camera* camera);
	Bloom(Camera* camera, bool active);
	Bloom(Camera* camera, bool active, std::string shader);
	~Bloom(){};

	void SetParams(const float lum, const float midgray, const float cutoff);
	void SetLuminance(const float lum);
	void SetMiddlegray(const float midgray);
	void SetCutOff(const float cutoff);

	const float GetLuminance() { return m_luminance; }
	const float GetMiddlegray() { return m_middlegray; }
	const float GetCutOff() { return m_whitecutoff; }
};

class Fog : public BaseEffect
{
private:
	Vec2 m_fogrange;
	Vec4 m_fogcolor;
	Vec2 m_fogangle;

public:
	Fog();
	Fog(Camera* camera);
	Fog(Camera* camera, bool active);
	Fog(Camera* camera, bool active, std::string shader);
	~Fog(){};

	void SetParams(const Vec2 fogrange, const Vec4 fogcolor, const Vec2 fogangle);
	void SetFogRange(const Vec2 fogrange);
	void SetFogColor(const Vec4 fogcolor);
	void SetFogAngle(const Vec2 fogangle);

	const Vec2 GetFogRange() { return m_fogrange; }
	const Vec4 GetFogColor() { return m_fogcolor; }
	const Vec2 GetFogAngle() { return m_fogangle; }
};


