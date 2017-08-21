IMPORT Avenger, Scrubs_IDM_quiz, Scrubs, ut;
#option('multiplePersistInstances',FALSE);
EXPORT proc_submit_stats(STRING version) := FUNCTION
vPrepSuperFileBldg :=  '~thor_data400::in::avenger::idm::quiz';
	F := Scrubs_IDM_quiz.In_quiz;		//Input file
	S := Scrubs_IDM_quiz.Scrubs;
	N := S.FromNone(F);
	T := S.FromBits(N.BitmapInfile);     // Use the FromBits module; makes my bitmap datafile easier to get to
	U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
	output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
	output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values

	//error_summary := output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
	// output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
	// output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values
	Orbit_st := U.OrbitStats()  :persist('~persist::Avenger::IDM::scrubs_rpt');

	//Outputs reports
	//output(Orbit_st,all,named('OrbitReport'));
	//output(Scrubs.OrbitProfileStats(,,U.OrbitStats()).SummaryStats, all,named('OrbitReportSummary'));

	//Submits Profile's stats to Orbit
	submit_stats := Scrubs.OrbitProfileStats('Scrubs_Avenger_IDM',, Orbit_st, version,'IDM').SubmitStats;

	//Output Scrubs report with examples in WU
	Scrubs_report_with_examples := Scrubs.OrbitProfileStats('Scrubs_Avenger_IDM',, Orbit_st, version,'IDM').CompareToProfile_with_examples;

	//Send Alerts and Scrubs reports via email 
	Scrubs_alert := Scrubs_report_with_examples(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(Scrubs_alert);
	mailfile := FileServices.SendEmailAttachData('wenhong.ma@lexisnexis.com'
																							 ,'Scrubs Avenger IDM - ' + version//subject
																							 ,'Scrubs Avenger IDM input file - ' + vPrepSuperFileBldg + '\n\r' + WORKUNIT  //body
																							 ,(data)attachment
																							 ,'text/csv'
																							 ,'ScrubsReport_IDM.csv'
																							 ,
																							 ,
																							 ,'wenhong.ma@lexisnexis.com');	
	GoScrub := IF(fileservices.getsuperfilesubcount(vPrepSuperFileBldg)	>	0,
		            SEQUENTIAL(submit_stats,mailfile),
							  OUTPUT(vPrepSuperFileBldg + 'is empty and scrub did not take place.'));
								
	RETURN GoScrub;
	
END;

	