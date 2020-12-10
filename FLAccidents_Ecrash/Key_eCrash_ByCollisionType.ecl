/*2017-03-22T17:50:04Z (Srilatha Katukuri)
ECH-4531 Analytics key Injury count correction
*/
IMPORT doxie, Data_Services;

EXPORT Key_ecrash_byCollisionType := INDEX(mod_PrepEcrashAnalyticKeys().dsByCollisionType, 
                                           {agencyid, Accident_date}, 
																					 {mod_PrepEcrashAnalyticKeys().dsByCollisionType},
                                           Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byCollisionType_' + doxie.Version_SuperKey);

