EXPORT Key_EcrashV2_LastName := INDEX(mod_PrepEcrashSearchKeys().uSlimLastName,
																		 {lname, jurisdiction_state, jurisdiction},
																		 {mod_PrepEcrashSearchKeys().uSlimLastName},
																		 Files_eCrash.FILE_KEY_LAST_NAME_STATE_SF);