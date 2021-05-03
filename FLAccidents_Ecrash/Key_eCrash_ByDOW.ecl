// Ecrash Reports key, by Day Of Week
EXPORT Key_ecrash_byDOW := INDEX(mod_PrepEcrashAnalyticKeys().by_DOW, 
                                 {agencyid, Accident_date}, 
																 {mod_PrepEcrashAnalyticKeys().by_DOW}, 
                                 Files_eCrash.FILE_KEY_ANALYTICS_BY_DOW_SF);