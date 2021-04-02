EXPORT Key_eCrashV2_LicensePlateNbr := INDEX(mod_PrepEcrashSearchKeys().uSlimLicensePlateNbr,
																						 {tag_nbr, tagnbr_st, jurisdiction_state, jurisdiction},
																						 {mod_PrepEcrashSearchKeys().uSlimLicensePlateNbr},
																						 Files_eCrash.FILE_KEY_LICENSE_PLATE_NBR_SF);