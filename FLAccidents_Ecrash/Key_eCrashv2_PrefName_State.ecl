dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs(fname <> ''), TRANSFORM(Layouts.key_slim_layout, SELF := LEFT));  
dSlimeCrashSearch := DISTRIBUTED(dsSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch := SORT(dSlimeCrashSearch, accident_nbr, fname, report_code, jurisdiction_state, jurisdiction,
                          accident_date, report_type_id, LOCAL);
uSlimeCrashSearch := DEDUP(sSlimeCrashSearch, accident_nbr, fname, report_code, jurisdiction_state, jurisdiction, 
                           accident_date, report_type_id, LOCAL); 
													 
EXPORT Key_eCrashv2_PrefName_State:=	INDEX(uSlimeCrashSearch,
																					  {fname, jurisdiction_state, jurisdiction},
																						{uSlimeCrashSearch},
																						Files_eCrash.FILE_KEY_PREFNAME_STATE_SF);
																							
																																
																															
