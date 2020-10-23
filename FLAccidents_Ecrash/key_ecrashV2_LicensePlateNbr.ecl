dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs(tag_nbr <> ''), TRANSFORM(Layouts.key_slim_layout, SELF := LEFT)); 
dSlimeCrashSearch := DISTRIBUTED(dsSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch := SORT(dSlimeCrashSearch, accident_nbr, tag_nbr, tagnbr_st, report_code, jurisdiction_state, jurisdiction,
                          accident_date, report_type_id, LOCAL);
uSlimeCrashSearch := DEDUP(sSlimeCrashSearch, accident_nbr, tag_nbr, tagnbr_st, report_code, jurisdiction_state, jurisdiction,
                           accident_date, report_type_id, LOCAL); 
											 
EXPORT Key_eCrashV2_LicensePlateNbr := INDEX(uSlimeCrashSearch,
																						 {tag_nbr, tagnbr_st, jurisdiction_state, jurisdiction},
																						 {uSlimeCrashSearch},
																						 Files_eCrash.FILE_KEY_LICENSE_PLATE_NBR_SF);