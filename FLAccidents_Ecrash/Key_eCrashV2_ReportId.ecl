/*2015-11-16T21:02:23Z (Srilatha Katukuri)
#193680 - CR323
*/
Import Data_Services, doxie;

export Key_eCrashV2_ReportId := index(mod_PrepEcrashKeys().dep_Report_base
                                     ,{report_id}
							                       ,{Super_report_id}
							                       ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_ReportId_' + doxie.Version_SuperKey);
																		