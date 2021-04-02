EXPORT Key_eCrashV2_OfficerBadgeNbr := INDEX(mod_PrepEcrashSearchKeys().uSlimOfficerBadgeNbr,
																				     {officer_id, jurisdiction_state, jurisdiction},
																				     {mod_PrepEcrashSearchKeys().uSlimOfficerBadgeNbr},
																				     Files_eCrash.FILE_KEY_OFFICER_BADGE_NBR_STATE_SF);