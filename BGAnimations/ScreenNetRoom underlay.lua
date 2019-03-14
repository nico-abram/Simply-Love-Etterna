return Def.Actor {
    BeginCommand = SL.IsEtterna and function()
            SCREENMAN:GetTopScreen():AddInputCallback(MPinput)
        end or nil
}
