-----------------------------
-- Simple post effect script
-----------------------------

--Called once at start
function Script:Start()
	--Load this script's shader
	--self.shader = Shader:Load("_klepto_skybox.shader")
	self.shader = Shader:Load("Shaders/PostEffects/EffectClass/_klepto_skybox.shader")
end

--Called each time the camera is rendered
function Script:Render(camera,context,buffer,depth,diffuse,normals)
	--Enable the shader and draw the diffuse image onscreen

	if self.texture==nil then
		self.texture = camera:GetKeyValue("skybox_texture","Materials/Sky/skybox_texture.tex")
		self.sky = Texture:Load(self.texture)
	end

	local Intensity = camera:GetKeyValue("skybox_intensity","1.0")
	self.shader:SetFloat("Intensity",Intensity)

	if self.shader then 
		self.shader:Enable() 
		self.sky:Bind(2)
		depth:Bind(3)	
	end

	context:DrawImage(diffuse,0,0,buffer:GetWidth(),buffer:GetHeight())
end

--Called when the effect is detached or the camera is deleted
function Script:Detach()
	if self.shader then
		self.shader:Release()
		self.shader = nil
		self.sky:Release()
		self.sky = nil
	end
end