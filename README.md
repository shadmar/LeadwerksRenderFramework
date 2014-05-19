LeadwerksRenderFramework
========================

Opensource posteffect render class for Leadwerks engine 3.1.

Example usage :

Add Effect.h and Effect.cpp to your project

	Effect* TheEffect = new Effect(); //Load world create the manager object

	//Add Effects
	Skybox* mysky = new Skybox(camera);
	mysky->SetIntensity(1.1);
	TheEffect->AddEffect(mysky, false);

	Bloom* mybloom = new Bloom(camera);
	mybloom->SetLuminance(0.12);
	mybloom->SetCutOff(0.9);
	TheEffect->AddEffect(mybloom, false);

	Dof *mydof = new Dof(camera);
	mydof->SetFarStart(40.0F);
	mydof->SetFarDist(400);
	TheEffect->AddEffect(mydof, false);

	Fog *myfog = new Fog(camera);
	myfog->SetFogRange(Vec2(1, 1110));
	myfog->SetFogAngle(Vec2(5, 45));
	TheEffect->AddEffect(myfog, false);



