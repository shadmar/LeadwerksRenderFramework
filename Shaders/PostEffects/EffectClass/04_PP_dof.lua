-----------------------------
-- Simple post effect script
-----------------------------
--Called once at start
function Script:Start()
	--Load this script's shader
	--self.shader = Shader:Load("Shadmar_Shaders/_dof.shader")
	self.shader = Shader:Load("Shaders/PostEffects/EffectClass/_dof.shader")
end

--Called each time the camera is rendered
function Script:Render(camera,context,buffer,depth,diffuse,normals)
	--Brightpass
	self.shader:Enable()
	diffuse:Bind(1)
	depth:Bind(2)
	context:DrawImage(diffuse,0,0,buffer:GetWidth(),buffer:GetHeight())

end

--Called when the effect is detached or the camera is deleted
function Script:Release()
	if self.shader then
		self.shader:Release()
		self.shader = nil
	end	
end