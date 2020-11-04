dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs(reportlinkid <> ''), TRANSFORM(Layouts.key_slim_layout, SELF := LEFT)); 
dSlimeCrashSearch := DISTRIBUTED(dsSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch := SORT(dSlimeCrashSearch, accident_nbr, reportlinkid, accident_date, report_type_id, 
                          report_id, jurisdiction_state, jurisdiction_nbr, agency_ori, LOCAL);
uSlimeCrashSearch := DEDUP(sSlimeCrashSearch, accident_nbr, reportlinkid, accident_date, report_type_id, 
                           report_id, jurisdiction_state, jurisdiction_nbr, agency_ori, LOCAL);										 

EXPORT Key_eCrashv2_ReportLinkId := INDEX(uSlimeCrashSearch, 
																					{reportlinkid},
																					{uSlimeCrashSearch},
																					Files_eCrash.FILE_KEY_REPORT_LINKID_SF);
																							  

