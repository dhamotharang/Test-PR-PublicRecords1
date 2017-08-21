// The macro was copied from Scrubs_Vina.Proc_Scrubs_Report and adjusted
IMPORT _Control, Infogroup, Scrubs, Scrubs_Infogroup, ut;

EXPORT Scrub_Infogroup(STRING pversion) := MODULE

  scopename := 'Input';

	MAC_Scrubs_Report(myFolder,myFile,datasetName)	:=	FUNCTIONMACRO
		folder						:=	#EXPAND(myFolder);
		inFile						:=	folder.#EXPAND(myFile);
		scrubs_name				:=	scopename+'_Scrubs';
		scope_datasetName	:=	scopename+'_'+datasetName;

		myEmail		:=	_Control.MyInfo.EmailAddressNotify;
		F	:=	inFile;																				//	Records to scrub
		S	:=	folder.#EXPAND(scrubs_name);									//	My scrubs module
		N	:=	S.FromNone(F);																//	Generate the error flags
		U :=	S.FromExpanded(N.ExpandedInFile);							//	Pass the expanded error flags into the Expanded module
		ErrorSummary			:=	OUTPUT(U.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors	:=	OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues		:=	OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values

		persist_name				:=	'~persist::'+myFolder+'_orbit_stats';
		Orbit_stats					:=	U.OrbitStats():PERSIST(persist_name);
		OrbitReport					:=	OUTPUT(Orbit_stats,ALL,NAMED('OrbitReport'));
		OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummary'));

		//Submits Profile's stats to Orbit
		SubmitStats						:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,pversion,datasetName).SubmitStats;
		dScrubsWithExamples		:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,pversion,datasetName).CompareToProfile_with_examples;
		scrubsAlert						:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment			:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile							:=	FileServices.SendEmailAttachData(Infogroup.Email_Notification_Lists.BuildFailure
																															 ,scope_datasetName+' Report' //subject
																															 ,scope_datasetName+' Report WU: '+WORKUNIT //body
																															 ,(data)scrubsAttachment
																															 ,'text/csv'
																															 ,datasetName+'ScrubsReport.csv'
																															 ,
																															 ,
																															 ,myEmail);

		// The contract requires 90% fill in certain fields or LN could legally terminate the
		//   relationship in 90 days.  Those errors require the build to stop.
		bad_list := ['ADDRESS:INVALID_ADDRESS:LENGTH', 'FIRST_NAME:INVALID_FIRST_NAME:LENGTH',
		             'LAST_NAME:INVALID_LAST_NAME:LENGTH', 'LICENSE_STATE:INVALID_LICENSE_STATE:LENGTH',
								 'OCCUPATION_TITLE:INVALID_OCCUPATION_TITLE:LENGTH',
								 'STATUS_CODE:INVALID_STATUS_CODE:LENGTH'];
		critical_bad_records := dScrubsWithExamples(RejectWarning = 'Y' AND ut.CleanSpacesAndUpper(RuleName) IN bad_list);

		RETURN SEQUENTIAL(ErrorSummary,
											EyeballSomeErrors,
											SomeErrorValues,
											OrbitReport,
											OrbitReportSummary,
											SubmitStats,
											IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No ' + datasetName + ' Scrubs Alerts')),
											IF(COUNT(critical_bad_records) > 0,
											   SEQUENTIAL(FAIL('One or more of the following fields do not have the ' +
																		        'proper population %: address, first name, last name, ' +
																						'license state, occupation title, or status code.  ' +
																						'Please find out which fields are failing and contact ' +
																						'Data Receiving, to contact the vendor to fix.  The ' +
																						'contract states these fields have to be 90%+ populated.')),
												 OUTPUT('No ' + datasetName + ' critical errors occurred.')));
	ENDMACRO;

  EXPORT All := SEQUENTIAL(MAC_Scrubs_Report('Scrubs_Infogroup', 'Input_In_Infogroup', 'Infogroup'));

END;
