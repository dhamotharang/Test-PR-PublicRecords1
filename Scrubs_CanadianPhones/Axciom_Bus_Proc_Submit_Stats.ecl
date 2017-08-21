IMPORT Scrubs, ut;
EXPORT Axciom_Bus_Proc_Submit_Stats(STRING version) := FUNCTION

	CanadianPhones_Axciom_Bus_In_File_Name := '~thor400_60::in::axciombus';
	F := Scrubs_CanadianPhones.Axciom_Bus_In_CanadianPhones;		//Input file
	S := Scrubs_CanadianPhones.Axciom_Bus_Scrubs;
	N := S.FromNone(F);
	U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	error_summary := output(U.SummaryStats, named('ErrorSummary_Bus')); // Show errors by field and type
	// output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors_Bus')); // Just eyeball some errors
	// output(choosen(U.BadValues, 1000), named('SomeErrorValues_Bus')); // See my error field values
	Orbit_st := U.OrbitStats(); 

	//Outputs reports
	// output(Orbit_st,all,named('OrbitReport_Bus'));
	// output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummary_CanadianPhones_Bus'));
	// Scrubs.OrbitProfileStats(,,Orbit_st).ProfileAlertsTemplate;
	
	//Submits Profile's stats to Orbit
	submit_stats := Scrubs.OrbitProfileStats('Scrubs_CanadianPhones_Axciom_Bus',, Orbit_st, version,'CanadianPhones').SubmitStats;

	//Output Scrubs report with examples in WU
	Scrubs_report_with_examples_bus := Scrubs.OrbitProfileStats('Scrubs_CanadianPhones_Axciom_Bus',, Orbit_st, version,'CanadianPhones').CompareToProfile_with_examples;

	//Send Alerts and Scrubs reports via email 
	Scrubs_alert_bus := Scrubs_report_with_examples_bus(RejectWarning = 'Y');
	attachment_bus := Scrubs.fn_email_attachment(Scrubs_alert_bus);
	mailfile := FileServices.SendEmailAttachData('cathy.tio@lexisnexis.com'
																							 ,'Scrubs CandianPhones Bus - ' + version//subject
																							 ,'Scrubs CandianPhones Bus input file - ' + CanadianPhones_Axciom_Bus_In_File_Name + '\n\r' + WORKUNIT  //body
																							 ,(data)attachment_bus
																							 ,'text/csv'
																							 ,'ScrubsReport_CanadianPhones_Bus.csv'
																							 ,
																							 ,
																							 ,'cathy.tio@lexisnexis.com');	
	GoScrub := IF(fileservices.getsuperfilesubcount(CanadianPhones_Axciom_Bus_In_File_Name)	>	0,
		            SEQUENTIAL(submit_stats,mailfile),
						    OUTPUT(CanadianPhones_Axciom_Bus_In_File_Name + ' is empty and scrub did not take place.'));
								
	RETURN GoScrub;
	
END;
