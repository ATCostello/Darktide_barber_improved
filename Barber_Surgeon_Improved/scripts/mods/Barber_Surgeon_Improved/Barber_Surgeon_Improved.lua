local mod = get_mod("Barber_Surgeon_Improved")

local CharacterAppearanceView = require("scripts/ui/views/character_appearance_view/character_appearance_view")

local LOC_SHOW_GEAR = "loc_bsi_show_gear"
local LOC_HIDE_GEAR = "loc_bsi_hide_gear"

local GEAR_SLOTS = {
	"slot_gear_head",
	"slot_gear_upperbody",
	"slot_gear_lowerbody",
	"slot_gear_extra_cosmetic",
}

local function get_equipped_loadout()
	local player = Managers.player and Managers.player:local_player(1)

	if not player then
		return nil
	end

	local profile = player:profile()

	return profile and profile.loadout
end

local function gear_is_hidden(view)
	return not view._bsi_gear_shown
end

CharacterAppearanceView.cb_toggle_gear = function(self)
	local character_create = self._character_create

	if not character_create then
		return
	end

	self._bsi_gear_shown = not self._bsi_gear_shown

	local loadout = self._bsi_gear_shown and get_equipped_loadout() or nil

	for i = 1, #GEAR_SLOTS do
		local slot_name = GEAR_SLOTS[i]
		local item = loadout and loadout[slot_name] or nil

		character_create:set_item_per_slot(slot_name, item)
	end
end

mod:hook_safe(CLASS.CharacterAppearanceView, "_setup_input_legend", function(self)
	if not self._is_barber then
		return
	end

	local input_legend = self._input_legend_element

	if not input_legend then
		return
	end

	input_legend:add_entry(
		LOC_SHOW_GEAR,
		"hotkey_menu_special_1",
		function(parent, id)
			local display_name = gear_is_hidden(parent) and LOC_SHOW_GEAR or LOC_HIDE_GEAR

			if parent._input_legend_element and id then
				parent._input_legend_element:set_display_name(id, display_name)
			end

			return parent._is_barber and parent._is_character_showing
		end,
		callback(self, "cb_toggle_gear"),
		"right_alignment"
	)
end)

return mod
