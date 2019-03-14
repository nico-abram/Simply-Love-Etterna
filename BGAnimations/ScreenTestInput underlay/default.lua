local function input(event)
	if not event.PlayerNumber or not event.button then
		return false
	end
	
	local state = "Off"
	if event.type ~= "InputEventType_Release" then
		state = "On"		
	end
		
	MESSAGEMAN:Broadcast(ToEnumShortString(event.PlayerNumber) .. event.button .. state)
	return false
end



return Def.ActorFrame {
	InitCommand=function(self)
		self:queuecommand("Capture")
	end;
	CaptureCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(input)
	end;
	OffCommand=function(self)
		self:sleep(0.4)
	end;
	
	Def.DeviceList {
		Font=THEME:GetPathF("","_miso");
		InitCommand=function(self)
			self:xy(_screen.cx,_screen.h-60):zoom(0.8): NoStroke()
		end;
	};
		
	LoadActor("visuals");
};