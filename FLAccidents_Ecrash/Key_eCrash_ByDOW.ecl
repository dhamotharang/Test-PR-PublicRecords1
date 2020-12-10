// Ecrash Reports key, by Day Of Week

IMPORT Data_Services, doxie;

EXPORT Key_ecrash_byDOW := INDEX(mod_PrepEcrashAnalyticKeys().by_DOW, 
                                 {agencyid, Accident_date}, 
																 {mod_PrepEcrashAnalyticKeys().by_DOW}, 
                                 Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byDOW_' + doxie.Version_SuperKey);