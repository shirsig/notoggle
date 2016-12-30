local shooting

local f = CreateFrame'Frame'
f:RegisterEvent'START_AUTOREPEAT_SPELL'
f:RegisterEvent'STOP_AUTOREPEAT_SPELL'
f:SetScript('OnEvent', function()
	shooting = event == 'START_AUTOREPEAT_SPELL'
end)

SLASH_SHOOT1 = '/shoot'
function SlashCmdList.SHOOT(command)
	if not shooting then
		CastSpellByName'Auto Shot'
		CastSpellByName'Shoot'
	end
end

f:SetScript('OnUpdate', function()
	f:SetScript('OnUpdate', nil)
	for i = 1, GetNumMacros() do
		if GetMacroInfo(i) == 'shoot' then
			EditMacro(i, 'shoot', 55, '/shoot', 1)
			return
		end
	end
	CreateMacro('shoot', 55, '/shoot', 1)
end)