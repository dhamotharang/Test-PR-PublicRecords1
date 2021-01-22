EXPORT Key_eCrashV2_VinNbr :=	INDEX(mod_PrepEcrashSearchKeys().uSlimVinNbr,
																		{vin, jurisdiction_state, jurisdiction},
																		{mod_PrepEcrashSearchKeys().uSlimVinNbr},
																		Files_eCrash.FILE_KEY_VINNBR_SF);
																							