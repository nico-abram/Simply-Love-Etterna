local textcolor = "#FFFFFF";
if SL.Global.ActiveColorIndex > 5 then
	textcolor = "#1E282F";
end

return LoadFont("_miso") .. {
	InitCommand=function(self)
		self:zoom(0.65):diffuse(color(textcolor))
	end;
};