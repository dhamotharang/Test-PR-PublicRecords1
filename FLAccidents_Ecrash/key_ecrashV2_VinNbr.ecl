dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs(vin <> ''), TRANSFORM(Layouts.key_slim_layout, SELF := LEFT)); 
dSlimeCrashSearch := DISTRIBUTED(dsSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch := SORT(dSlimeCrashSearch, accident_nbr, vin, report_code, jurisdiction_state, jurisdiction, accident_date, report_type_id, LOCAL);
uSlimeCrashSearch := DEDUP(sSlimeCrashSearch, accident_nbr, vin, report_code, jurisdiction_state, jurisdiction, accident_date, report_type_id, LOCAL);

EXPORT Key_eCrashV2_VinNbr :=	INDEX(uSlimeCrashSearch,
																		{vin, jurisdiction_state, jurisdiction},
																		{uSlimeCrashSearch},
																		Files_eCrash.FILE_KEY_VINNBR_SF);
																							