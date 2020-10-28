dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs(officer_id <> ''), 
                              TRANSFORM(Layouts.key_slim_layout, SELF := LEFT));  
dSlimeCrashSearch := DISTRIBUTED(dsSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch := SORT(dSlimeCrashSearch, accident_nbr, officer_id, report_code, jurisdiction_state, jurisdiction,
                          accident_date, report_type_id, LOCAL);
uSlimeCrashSearch := DEDUP(sSlimeCrashSearch, accident_nbr, officer_id, report_code, jurisdiction_state, jurisdiction, 
                           accident_date, report_type_id, LOCAL);
													 
EXPORT Key_eCrashV2_OfficerBadgeNbr := INDEX(uSlimeCrashSearch,
																				     {officer_id, jurisdiction_state, jurisdiction},
																				     {uSlimeCrashSearch},
																				     Files_eCrash.FILE_KEY_OFFICER_BADGE_NBR_STATE_SF);