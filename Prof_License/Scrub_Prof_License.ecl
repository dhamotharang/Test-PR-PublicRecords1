IMPORT _Control, Prof_License, Scrubs, Scrubs_Prof_License;

EXPORT Scrub_Prof_License(STRING pversion) := FUNCTION

	emailList := 'skasavajjala@seisint.com;qualityassurance@seisint.com;albert.metzmaier@lexisnexis.com';
	F := Prof_License.File_prof_license_base_AID;	//	Records to scrub
	S := Scrubs_Prof_License.Base_Scrubs;					//	My scrubs module
	N := S.FromNone(F);														//	Generate the error flags
	U := S.FromExpanded(N.ExpandedInFile);				//	Pass the expanded error flags into the Expanded module

	ErrorSummary        := OUTPUT(U.SummaryStats, NAMED('ErrorSummaryProf_License'));										//	Show errors by field and type
	EyeballSomeErrors   := OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrorsProf_License'));		//	Just eyeball some errors
	SomeErrorValues     := OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValuesProf_License'));			//	See my error field values

	persist_name        := '~persist::Scrubs_Prof_License_orbit_stats';
	Orbit_stats         := U.OrbitStats():PERSIST(persist_name);
	OrbitReport         := OUTPUT(Orbit_stats,ALL,NAMED('OrbitReportProf_License'));
	OrbitReportSummary  := OUTPUT(Scrubs.OrbitProfileStats(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummaryProf_License'));

	//Submits Profile's stats to Orbit
	SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Prof_License','ScrubsAlerts',Orbit_stats,pversion,'Prof_License').SubmitStats;
	dScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Prof_License','ScrubsAlerts',Orbit_stats,pversion,'Prof_License').CompareToProfile_with_examples;
	scrubsAlert         := dScrubsWithExamples(RejectWarning = 'Y');
	scrubsAttachment    := Scrubs.fn_email_attachment(scrubsAlert);
	mailfile            := FileServices.SendEmailAttachData(emailList
																														 ,'Prof_License Report' //subject
																														 ,'Prof_License Report WU: '+ WORKUNIT //body
																														 ,(DATA)scrubsAttachment
																														 ,'text/csv'
																														 ,'Prof_LicenseScrubsReport.csv'
																														 ,
																														 ,
																														 ,_Control.MyInfo.EmailAddressNotify);

	RETURN SEQUENTIAL(ErrorSummary,
										EyeballSomeErrors,
										SomeErrorValues,
										OrbitReport,
										OrbitReportSummary,
										SubmitStats,
										IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Prof_License Scrubs Alerts')));

END;
