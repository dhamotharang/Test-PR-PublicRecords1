/*2017-03-22T17:50:04Z (Srilatha Katukuri)
ECH-4531 Analytics key Injury count correction
*/
EXPORT Key_ecrash_byCollisionType := INDEX(mod_PrepEcrashAnalyticKeys().dsByCollisionType, 
                                           {agencyid, Accident_date}, 
																					 {mod_PrepEcrashAnalyticKeys().dsByCollisionType},
                                           Files_eCrash.FILE_KEY_ANALYTICS_BY_COLLISION_TYPE_SF);

