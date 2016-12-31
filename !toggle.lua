local attacking, shooting

do
	local f = CreateFrame'Frame'
	f:RegisterEvent'PLAYER_ENTER_COMBAT'
	f:RegisterEvent'PLAYER_LEAVE_COMBAT'
	f:SetScript('OnEvent', function()
		attacking = event == 'PLAYER_ENTER_COMBAT'
	end)
end

do
	local f = CreateFrame'Frame'
	f:RegisterEvent'START_AUTOREPEAT_SPELL'
	f:RegisterEvent'STOP_AUTOREPEAT_SPELL'
	f:SetScript('OnEvent', function()
		shooting = event == 'START_AUTOREPEAT_SPELL'
	end)
end

local function ignore(name)
	local name = strlower(name)
	return name == 'attack' and attacking or (name == 'auto shot' or name =='shoot') and shooting
end

do
	local orig = CastSpell
	function CastSpell(index, booktype)
		if ignore(GetSpellName(index, booktype)) then return end
		return orig(index, booktype)
	end
end

do
	local orig = CastSpellByName
	function CastSpellByName(name)
		if ignore(name) then return end
		return orig(name)
	end
end

do
	local orig = UseAction
	function UseAction(slot, clicked, onself)
		if HasAction(slot) and not GetActionText(slot) then
			aurae_Tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
			aurae_TooltipTextRight1:SetText()
			aurae_Tooltip:SetAction(slot)
			if ignore(aurae_TooltipTextLeft1:GetText()) then return end
		end
		return orig(slot, clicked, onself)
	end
end