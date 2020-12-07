// Ecrash Reports key, by Day Of Week

IMPORT doxie, Data_Services;

EXPORT Key_ecrash_byHOD := INDEX(mod_PrepEcrashAnalyticKeys().by_HOD, 
                                 {agencyid, Accident_date}, 
																 {mod_PrepEcrashAnalyticKeys().by_HOD}, 
																 Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byHOD_' + doxie.Version_SuperKey);

