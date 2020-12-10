/*2015-11-16T20:52:07Z (Srilatha Katukuri)
#193680 - CR 323
*/
IMPORT Data_Services, doxie; 

EXPORT Key_eCrashV2_DeltaDate := INDEX(mod_PrepEcrashKeys().DateFile, 
                                       {delta_text}, 
																			 {Date_Added},   
																			 Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_deltadate_'+ doxie.Version_SuperKey);
																	
