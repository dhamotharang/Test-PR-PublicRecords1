IMPORT Scrubs, ut;
EXPORT Axciom_Res_Proc_Submit_Stats(STRING version) := FUNCTION

	CanadianPhones_Axciom_Res_In_File_Name := '~thor400_60::in::axciomres';
	F := Scrubs_CanadianPhones.Axciom_Res_In_CanadianPhones;		//Input file
	S := Scrubs_CanadianPhones.Axciom_Res_Scrubs;
	N := S.FromNone(F);
	U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	error_summary := output(U.SummaryStats, named('ErrorSummary_Res')); // Show errors by field and type
	// output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors_Res')); // Just eyeball some errors
	// output(choosen(U.BadValues, 1000), named('SomeErrorValues_Res')); // See my error field values
	Orbit_st := U.OrbitStats();

	//Outputs reports
	// output(Orbit_st,all,named('OrbitReport_Res'));
	// output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummary_CanadianPhones_Res'));
	// prof_stats :=Scrubs.OrbitProfileStats(,,Orbit_st).ProfileAlertsTemplate;

	//Submits Profile's stats to Orbit
	submit_stats := Scrubs.OrbitProfileStats('Scrubs_CanadianPhones_Axciom_Res',, Orbit_st, version,'CanadianPhones').SubmitStats;

	//Output Scrubs report with examples in WU
	Scrubs_report_with_examples_Res := Scrubs.OrbitProfileStats('Scrubs_CanadianPhones_Res',, Orbit_st, version,'CanadianPhones').CompareToProfile_with_examples;

	//Send Alerts and Scrubs reports via email 
	Scrubs_alert_Res := Scrubs_report_with_examples_Res(RejectWarning = 'Y');
	attachment_Res := Scrubs.fn_email_attachment(Scrubs_alert_Res);
	mailfile := FileServices.SendEmailAttachData('cathy.tio@lexisnexis.com'
																							 ,'Scrubs CandianPhones Res - ' + version//subject
																							 ,'Scrubs CandianPhones Res input file - ' + CanadianPhones_Axciom_Res_In_File_Name + '\n\r' + WORKUNIT  //body
																							 ,(data)attachment_Res
																							 ,'text/csv'
																							 ,'ScrubsReport_CanadianPhones_Res.csv'
																							 ,
																							 ,
																							 ,'cathy.tio@lexisnexis.com');	
	GoScrub := IF(fileservices.getsuperfilesubcount(CanadianPhones_Axciom_Res_In_File_Name)	>	0,
		            SEQUENTIAL(submit_stats, mailfile),
						    OUTPUT(CanadianPhones_Axciom_Res_In_File_Name + ' is empty and scrub did not take place.'));
								
	RETURN GoScrub;
	
END;
