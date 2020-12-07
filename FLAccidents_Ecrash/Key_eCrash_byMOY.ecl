// Ecrash Reports key, by Month Of Year

IMPORT Data_Services, doxie;

EXPORT Key_ecrash_byMOY := INDEX(mod_PrepEcrashAnalyticKeys().by_MOY, 
                                 {agencyid, Accident_date}, 
																 {mod_PrepEcrashAnalyticKeys().by_MOY}, 
                                 Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byMOY_' + doxie.Version_SuperKey);