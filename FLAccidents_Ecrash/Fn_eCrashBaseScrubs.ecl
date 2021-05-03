EXPORT Fn_eCrashBaseScrubs(STRING filedate) := FUNCTION

IMPORT STD, scrubs, scrubs_ecrash;
								 
// #############################################################################################
// Apply Scrubs to eCrash reports
// #############################################################################################	
	eCrashScrub := PROJECT(BaseFile, Layouts.scrubs);	
	eCrashScrubStep1 := scrubs_ecrash.Scrubs.FromNone(eCrashScrub);
  maxprocessdate := MAX(eCrashScrubStep1.ExpandedInFile(date_vendor_last_reported [1..2]= '20'), date_vendor_last_reported);
	eCrashScrubStep2 := scrubs_ecrash.Scrubs.FromExpanded(eCrashScrubStep1.ExpandedInFile(date_vendor_last_reported = maxprocessdate)); 
	
//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	eCrashOrbitstats := eCrashScrubStep2.OrbitStats():PERSIST('~persist::ecrash_scrubs_rpt');
//Submits stats to Orbit
	eCrashSubmitStats := Scrubs.OrbitProfileStats('Scrubs_eCrash',, eCrashOrbitstats, filedate).SubmitStats;
//Output Scrubs report with examples in WU
	eCrashScrubsReportWithExamples := Scrubs.OrbitProfileStats('Scrubs_eCrash',, eCrashOrbitstats, filedate).CompareToProfile_with_examples;
//Send Alerts and Scrubs reports via email 
	eCrashScrubsAlert := eCrashScrubsReportWithExamples(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(eCrashScrubsAlert);	
  mailfile := STD.System.Email.SendEmailAttachData ('DataDevelopment-InsRiskeCrash@lexisnexisrisk.com; sudhir.kasavajjala@lexisnexis.com',
																						        'Scrubs eCrash Report ', //subject
																						        'Scrubs eCrash Report ', //body
																						        (data)attachment,
																						        'text/csv',
																						        'ScrubsReport.csv',
																						        ,
																					          ,
																						        'sudhir.kasavajjala@lexisnexis.com');

RETURN SEQUENTIAL(eCrashSubmitStats,
		              OUTPUT(eCrashScrubsReportWithExamples, ALL, NAMED('ScrubsReportWithExamples')),
		              IF(COUNT(eCrashScrubsAlert) > 1, mailfile, OUTPUT('No_Scrubs_Alerts'))
								 );

END;
																										