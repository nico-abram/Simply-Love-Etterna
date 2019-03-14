return LoadActor("MusicWheelItem sort.png" )..{
	InitCommand=function(self)
		self:zoomto(_screen.w/2,50):horizalign(left):addx(-_screen.w/10)
	end
}