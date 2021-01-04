/*2015-11-16T20:52:07Z (Srilatha Katukuri)
#193680 - CR 323
*/
EXPORT Key_eCrashV2_DeltaDate := INDEX(mod_PrepEcrashKeys().DateFile, 
                                       {delta_text}, 
																			 {Date_Added},   
																			 Files_eCrash.FILE_KEY_DELTA_DATE_SF);
																	
