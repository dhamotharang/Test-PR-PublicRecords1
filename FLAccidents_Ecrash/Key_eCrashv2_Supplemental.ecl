/*2015-11-16T21:04:30Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-08-14T23:18:41Z (Srilatha Katukuri)
#181860 - key builds in PRUS folder for testing.
*/
/*2015-08-07T23:53:47Z (Srilatha Katukuri)
#181860
*/
export Key_eCrashv2_Supplemental := index(mod_PrepEcrashKeys().ded_base
                                         ,{super_report_id}
								                         ,{report_id
																				   ,hash_key
																					 ,accident_nbr
																					 ,report_code
																					 ,jurisdiction
																					 ,jurisdiction_state
																					 ,accident_date
																					 ,orig_accnbr
																					 ,work_type_id
																					 ,report_type_id
																					 ,agency_ori
																					 ,addl_report_number
																					 ,Vendor_Code
																					 ,vendor_report_id
																					 ,Page_Count 
																					 }
															           ,Files_eCrash.FILE_KEY_SUPPLEMENTAL_SF);
                                  