/*2017-03-22T17:49:34Z (Srilatha Katukuri)
ECH-4531 Analytics key Injury Count
*/
EXPORT Key_ecrash_byAgencyID := INDEX(mod_PrepEcrashAnalyticKeys().by_AgencyID, 
                                      {AgencyID, accident_date}, 
																			{mod_PrepEcrashAnalyticKeys().by_AgencyID}, 
                                      Files_eCrash.FILE_KEY_ANALYTICS_BY_AGENCY_ID_SF);