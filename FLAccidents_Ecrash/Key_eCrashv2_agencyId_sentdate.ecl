EXPORT Key_eCrashv2_agencyId_sentdate := INDEX(mod_PrepEcrashSearchKeys().tbSlimAgencyIdSentdate, 
                                               {jurisdiction_nbr},
																							 {contrib_source, MaxSent_to_hpcc_date},
																							 Files_eCrash.FILE_KEY_AGENCY_ID_SENT_DATE_STATE_SF);
																							