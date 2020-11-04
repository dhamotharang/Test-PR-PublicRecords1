dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs(driver_license_nbr <> ''), 
                              TRANSFORM(Layouts.key_slim_layout, SELF := LEFT)); 
dSlimeCrashSearch := DISTRIBUTED(dsSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch := SORT(dSlimeCrashSearch, accident_nbr, driver_license_nbr, dlnbr_st, report_code, jurisdiction_state, jurisdiction,
                          accident_date, report_type_id, LOCAL); 
uSlimeCrashSearch := DEDUP(sSlimeCrashSearch, accident_nbr, driver_license_nbr, dlnbr_st, report_code, jurisdiction_state, jurisdiction,
                            accident_date, report_type_id, LOCAL); 
											 
EXPORT Key_eCrashV2_DlnNbrDLState := INDEX(uSlimeCrashSearch,
																					 {driver_license_nbr, dlnbr_st, jurisdiction_state, jurisdiction},
																					 {uSlimeCrashSearch},
																					 Files_eCrash.FILE_KEY_DLN_NBR_DL_STATE_SF);
																							