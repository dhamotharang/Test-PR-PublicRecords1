IMPORT _Control, Scrubs, Scrubs_DEA, ut;

EXPORT Scrub_DEA(STRING pversion) := MODULE

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
		mailfile							:=	FileServices.SendEmailAttachData('darren.knowles@lexisnexis.com;CPettola@seisint.com;avenkatachalam@seisint.com;charlene.ros@lexisnexis.com'
																															 ,scope_datasetName+' Report' //subject
																															 ,scope_datasetName+' Report WU: '+WORKUNIT //body
																															 ,(data)scrubsAttachment
																															 ,'text/csv'
																															 ,datasetName+'ScrubsReport.csv'
																															 ,
																															 ,
																															 ,myEmail);

    // If one of the rules gives a reject warning, we want the build to stop.
		RETURN SEQUENTIAL(ErrorSummary,
											EyeballSomeErrors,
											SomeErrorValues,
											OrbitReport,
											OrbitReportSummary,
											SubmitStats,
											IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No ' + datasetName + ' Scrubs Alerts')),
											IF(COUNT(scrubsAlert) > 0,
											   SEQUENTIAL(FAIL('One or more of the scrubs rules have failed.  The build ' +
																		        'will not happen until the problem is fixed, one way or another. ')),
												 OUTPUT('No ' + datasetName + ' critical errors occurred.')));
	ENDMACRO;

  EXPORT All := SEQUENTIAL(MAC_Scrubs_Report('Scrubs_DEA', 'Input_In_DEA', 'DEA'));

END;
