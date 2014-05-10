LeadwerksRenderFramework
========================

Opensource posteffect render class for Leadwerks engine 3.1.

Example usage :

Add Effect.h and Effect.cpp to your project

	Skybox* mysky = new Skybox(camera);
	mysky->SetIntensity(0.6);

	Bloom* mybloom = new Bloom(camera);
	mybloom->SetLuminance(0.08);



