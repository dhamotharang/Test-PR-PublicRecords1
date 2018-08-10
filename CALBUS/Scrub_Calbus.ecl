IMPORT _Control,  Scrubs, Scrubs_Calbus;

EXPORT Scrub_Calbus(STRING pversion) := MODULE

	SHARED MAC_Scrubs_Report(BuildDate,myFolder,myFile,datasetName)	:=	FUNCTIONMACRO
		folder							:=	#EXPAND(myFolder);
		inFile							:=	folder.#EXPAND(myFile)(BuildDate);
		scrubs_name					:=	'raw_Scrubs';

		myEmail							:=	_Control.MyInfo.EmailAddressNotify;
		F										:=	inFile;																				//	Records to scrub
		S										:=	folder.#EXPAND(scrubs_name);									//	My scrubs module
		N										:=	S.FromNone(F);																//	Generate the error flags
		U 									:=	S.FromExpanded(N.ExpandedInFile);							//	Pass the expanded error flags into the Expanded module
		
		ErrorSummary				:=	OUTPUT(U.SummaryStats, NAMED('ErrorSummary'+datasetName));										//	Show errors by field and type
		EyeballSomeErrors		:=	OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrors'+datasetName));		//	Just eyeball some errors
		SomeErrorValues			:=	OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValues'+datasetName));			//	See my error field values

		persist_name				:=	'~persist::'+myFolder+'_orbit_stats';
		Orbit_stats					:=	U.OrbitStats():PERSIST(persist_name);
		OrbitReport					:=	OUTPUT(Orbit_stats,ALL,NAMED('OrbitReport'+datasetName));
		OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStatsPost310(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummary'+datasetName));

		//Submits Profile's stats to Orbit
		SubmitStats					:=	Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).SubmitStats;
		dScrubsWithExamples	:=	Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).CompareToProfile_with_examples;
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		// AlertsCSVTemplate	     := Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts', Orbit_stats, BuildDate, datasetName).ProfileAlertsTemplate;
		scrubsAlert					:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment		:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile						:=	FileServices.SendEmailAttachData(_Control.MyInfo.EmailAddressNotify
																														 ,datasetName+' Report' //subject
																														 ,datasetName+' Report WU: '+WORKUNIT //body
																														 ,(data)scrubsAttachment
																														 ,'text/csv'
																														 ,datasetName+'ScrubsReport.csv'
																														 ,
																														 ,
																														 ,myEmail);

		critical_bad_records := DATASET([], RECORDOF(N.ExpandedInFile));

		RETURN SEQUENTIAL(ErrorSummary,
											EyeballSomeErrors,
											SomeErrorValues,
											OrbitReport,
											OrbitReportSummary,
											SubmitStats,
											// AlertsCSVTemplate,
											IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No ' + datasetName + ' Scrubs Alerts')),
											IF(COUNT(critical_bad_records) > 0,
											   SEQUENTIAL(OUTPUT(critical_bad_records, , '~thor_data400::error::' + pversion + '::' + datasetName, COMPRESSED, OVERWRITE),
															FAIL('Custom Scrubs error occurred.  Getting bad license ' +
																				'numbers with ' + datasetName + '.  Check file ' +
																						'thor_data400::error::' + pversion + '::' + datasetName)),
												 OUTPUT('No ' + datasetName + ' custom error occurred.')));
	ENDMACRO;

EXPORT Report:= MAC_Scrubs_Report(pversion, 'Scrubs_Calbus', 'raw_in_Calbus', 'CALBUS');

END;
  