IMPORT Scrubs;

EXPORT proc_submit_stats(STRING version) := FUNCTION

	vPrepSuperFileBldg		:=	'~thor_data400::in::vehiclev2::di::oh_building';

	F := Scrubs_VehicleV2_OH_Direct.In_VehicleV2_OH_Direct;		//Input file
	S := Scrubs_VehicleV2_OH_Direct.Scrubs;
	N := S.FromNone(F);
	//T := S.FromBits(N.BitmapInfile);     // Use the FromBits module; makes my bitmap datafile easier to get to
	U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//error_summary := output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
	// output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
	// output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values
	Orbit_st := U.OrbitStats()  :persist('~persist::vehiclev2::oh_direct::scrubs_rpt');;

	//Outputs reports
	//output(Orbit_st,all,named('OrbitReport'));
	//output(Scrubs.OrbitProfileStats(,,U.OrbitStats()).SummaryStats, all,named('OrbitReportSummary'));

	//Submits Profile's stats to Orbit
	submit_stats := Scrubs.OrbitProfileStats('Scrubs_VehicleV2_OH_Direct',, Orbit_st, version,'OH_Direct').SubmitStats;

	//Output Scrubs report with examples in WU
	Scrubs_report_with_examples := Scrubs.OrbitProfileStats('Scrubs_VehicleV2_OH_Direct',, Orbit_st, version,'OH_Direct').CompareToProfile_with_examples;
	
	//Send Alerts and Scrubs reports via email 
	Scrubs_alert := Scrubs_report_with_examples(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(Scrubs_alert);
	mailfile := FileServices.SendEmailAttachData('cathy.tio@lexisnexis.com'
																							 ,'Scrubs VehicleV2 OH Driect - ' + version  //subject
																							 ,'Scrubs VehicleV2 OH Driect - ' + vPrepSuperFileBldg + '\r\n' + WORKUNIT  //body
																							 ,(data)attachment
																							 ,'text/csv'
																							 ,'ScrubsReport_OH_Direct.csv'
																							 ,
																							 ,
																							 ,'cathy.tio@lexisnexis.com');	
	GoScrub := IF(fileservices.getsuperfilesubcount(vPrepSuperFileBldg)	>	0,
		            SEQUENTIAL(submit_stats,mailfile),
							  OUTPUT(vPrepSuperFileBldg + ' is empty and scrub did not take place.'));
								
	RETURN GoScrub;
	
END;
