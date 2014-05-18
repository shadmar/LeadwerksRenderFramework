-----------------------------
-- Simple post effect script
-----------------------------
--Script.SkyTexture = "PostEffects/Media/SkyLE25.tex" --Cubemap
--Script.FogRange = Vec2(0.0,75.0) --Range of Fog 
--Script.FogColor = Vec4(0.72,0.73,0.67,1.0) --Color of Fog
--Script.FogAngle  = Vec2(5.0,15.0) --Angle Range where fog is blended with the skybox


--Called once at start
function Script:Start()
	self.shader = Shader:Load("Shaders/PostEffects/EffectClass/_klepto_fog.shader")
end

--Called each time the camera is rendered
function Script:Render(camera,context,buffer,depth,diffuse,normals)
	--Enable the shader and draw the diffuse image onscreen
	if self.shader then 
		self.shader:Enable() 
		depth:Bind(3)
		
	local fogrange=camera:GetKeyValue("fog_fogrange","0,400")
	local fogcolor=camera:GetKeyValue("fog_fogcolor","0.72,0.73,0.67,1.0")
	local fogangle=camera:GetKeyValue("fog_fogangle","5,21")

	self.shader:SetVec2("fogrange",Vec2(fogrange))
	self.shader:SetVec4("fogcolor",Vec4(fogcolor))
	self.shader:SetVec2("fogangle",Vec2(fogangle))
	end

	context:DrawImage(diffuse,0,0,buffer:GetWidth(),buffer:GetHeight())
end

--Called when the effect is detached or the camera is deleted
function Script:Detach()
	if self.shader then
		self.shader:Release()
		self.shader = nil
	end
end