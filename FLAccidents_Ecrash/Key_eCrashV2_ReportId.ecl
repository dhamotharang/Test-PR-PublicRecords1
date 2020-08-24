Import Data_Services, doxie,FLAccidents;

// Contain all report id's till to date

Reportversion := FLAccidents_Ecrash.Files.Base.Supplemental;

dst_Report_base := distribute(Reportversion, hash(Super_report_id));
srt_Report_base := sort(dst_Report_base, report_id, Super_report_id, local);
dep_Report_base := dedup(srt_Report_base, report_id, Super_report_id,local);

export Key_eCrashV2_ReportId := index(dep_Report_base
                                     ,{report_id}
							                       ,{Super_report_id}
							                       ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_ReportId_' + doxie.Version_SuperKey);
