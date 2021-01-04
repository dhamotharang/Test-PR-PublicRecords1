// Ecrash Reports key, by Intersection
EXPORT Key_ecrash_ByInter := INDEX(mod_PrepEcrashAnalyticKeys().dsByInter, 
                                   {agencyid, Accident_date}, 
																	 {mod_PrepEcrashAnalyticKeys().dsByInter}, 
                                   Files_eCrash.FILE_KEY_ANALYTICS_BY_INTER_SF);