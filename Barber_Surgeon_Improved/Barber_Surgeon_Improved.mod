return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Barber_Surgeon_Improved` encountered an error loading the Darktide Mod Framework.")

		new_mod("Barber_Surgeon_Improved", {
			mod_script       = "Barber_Surgeon_Improved/scripts/mods/Barber_Surgeon_Improved/Barber_Surgeon_Improved",
			mod_data         = "Barber_Surgeon_Improved/scripts/mods/Barber_Surgeon_Improved/Barber_Surgeon_Improved_data",
			mod_localization = "Barber_Surgeon_Improved/scripts/mods/Barber_Surgeon_Improved/Barber_Surgeon_Improved_localization",
		})
	end,
	packages = {},
}
