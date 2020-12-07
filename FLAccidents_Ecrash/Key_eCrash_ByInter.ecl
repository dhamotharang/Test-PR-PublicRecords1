// Ecrash Reports key, by Intersection

IMPORT doxie, Data_Services;

EXPORT Key_ecrash_ByInter := INDEX(mod_PrepEcrashAnalyticKeys().dsByInter, 
                                   {agencyid, Accident_date}, 
																	 {mod_PrepEcrashAnalyticKeys().dsByInter}, 
                                   Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byInter_' + doxie.Version_SuperKey);