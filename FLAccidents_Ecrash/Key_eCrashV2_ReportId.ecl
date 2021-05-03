/*2015-11-16T21:02:23Z (Srilatha Katukuri)
#193680 - CR323
*/
export Key_eCrashV2_ReportId := index(mod_PrepEcrashKeys().dep_Report_base
                                     ,{report_id}
							                       ,{Super_report_id}
							                       ,Files_eCrash.FILE_KEY_REPORT_ID_SF);
																		