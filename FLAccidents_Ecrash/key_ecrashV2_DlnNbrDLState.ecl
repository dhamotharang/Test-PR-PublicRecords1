EXPORT Key_eCrashV2_DlnNbrDLState := INDEX(mod_PrepEcrashSearchKeys().uSlimDlnNbrDLState,
																					 {driver_license_nbr, dlnbr_st, jurisdiction_state, jurisdiction},
																					 {mod_PrepEcrashSearchKeys().uSlimDlnNbrDLState},
																					 Files_eCrash.FILE_KEY_DLN_NBR_DL_STATE_SF);
																							