/*2017-03-22T17:49:34Z (Srilatha Katukuri)
ECH-4531 Analytics key Injury Count
*/
IMPORT doxie, Data_Services;

EXPORT Key_ecrash_byAgencyID := INDEX(mod_PrepEcrashAnalyticKeys().by_AgencyID, 
                                      {AgencyID, accident_date}, 
																			{mod_PrepEcrashAnalyticKeys().by_AgencyID}, 
                                      Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byAgencyID_' + doxie.Version_SuperKey);