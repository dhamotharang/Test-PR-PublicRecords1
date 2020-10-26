dsSlimeCrashSearch := PROJECT(File_KeybuildV2.eCrashSearchRecs, TRANSFORM(Layouts.key_slim_layout, SELF := LEFT));
tbSlimeCrashSearch := TABLE(dsSlimeCrashSearch, 
                            {jurisdiction_nbr, STRING8 MaxSent_to_hpcc_date := MAX(GROUP, date_vendor_last_reported)},
													  jurisdiction_nbr);

EXPORT Key_eCrashv2_agencyId_sentdate := INDEX(tbSlimeCrashSearch, 
                                               {jurisdiction_nbr},
																							 {MaxSent_to_hpcc_date},
																							 Files_eCrash.FILE_KEY_AGENCY_ID_SENT_DATE_STATE_SF);
																							