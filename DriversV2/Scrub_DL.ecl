IMPORT _Control, DriversV2, Scrubs, Scrubs_DL_CT, Scrubs_DL_FL, Scrubs_DL_MA, Scrubs_DL_ME_MEDCERT, Scrubs_DL_MI, 
        Scrubs_DL_NE, Scrubs_DL_NC, Scrubs_DL_NV, Scrubs_DL_OH, Scrubs_DL_TN, Scrubs_DL_TN_CONV, 
				Scrubs_DL_TN_WDL, Scrubs_DL_TX, Scrubs_DL_WI; 
       //,Scrubs_DL_NC_CHG
       // ,Scrubs_DL_MO
			 // ,Scrubs_DL_MO_MEDCERT
			 // ,Scrubs_DL_WY_MEDCERT 

EXPORT Scrub_DL(STRING pversion) := MODULE

	SHARED MAC_Scrubs_Report(BuildDate,myFolder,myFile,datasetName)	:=	FUNCTIONMACRO
		folder						:=	#EXPAND(myFolder);
		inFile						:=	folder.#EXPAND(myFile)(BuildDate);
		scrubs_name				:=	'Scrubs';

		myEmail		:=	_Control.MyInfo.EmailAddressNotify;
		F	:=	inFile;																				//	Records to scrub
		S	:=	folder.#EXPAND(scrubs_name);									//	My scrubs module
		N	:=	S.FromNone(F);																//	Generate the error flags
		U :=	S.FromExpanded(N.ExpandedInFile);							//	Pass the expanded error flags into the Expanded module
		ErrorSummary			:=	OUTPUT(U.SummaryStats, NAMED('ErrorSummary'+datasetName));										//	Show errors by field and type
		EyeballSomeErrors	:=	OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrors'+datasetName));		//	Just eyeball some errors
		SomeErrorValues		:=	OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValues'+datasetName));			//	See my error field values

		persist_name				:=	'~persist::'+myFolder+'_orbit_stats';
		Orbit_stats					:=	U.OrbitStats():PERSIST(persist_name);
		OrbitReport					:=	OUTPUT(Orbit_stats,ALL,NAMED('OrbitReport'+datasetName));
		OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummary'+datasetName));

		//Submits Profile's stats to Orbit
		SubmitStats						:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).SubmitStats;
		dScrubsWithExamples		:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).CompareToProfile_with_examples;
    //Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		// AlertsCSVTemplate	     := Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts', Orbit_stats, BuildDate, datasetName).ProfileAlertsTemplate;
		scrubsAlert						:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment			:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile							:=	FileServices.SendEmailAttachData(DriversV2.Email_Notification_Lists.BuildFailure
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

  SHARED Temp_NoReport() := FUNCTION
    RETURN OUTPUT('NO SCRUBS REPORT READY FOR THIS STATE');
  END;

  EXPORT CT          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_CT',         'In_CT',         'DL_CT');
  EXPORT FL          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_FL',         'In_FL',         'DL_FL');
  EXPORT LA          := Temp_NoReport();
  EXPORT MA          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_MA',         'In_MA',         'DL_MA');
  EXPORT ME_MEDCERT  := MAC_Scrubs_Report(pversion, 'Scrubs_DL_ME_MEDCERT', 'In_ME_MEDCERT', 'DL_ME_MEDCERT');
  EXPORT MI          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_MI',         'In_MI',         'DL_MI');
  EXPORT MO          := Temp_NoReport();
  EXPORT MO_MEDCERT  := Temp_NoReport();
  EXPORT NE          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_NE',         'In_NE',         'DL_NE');
  EXPORT NC          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_NC',         'In_NC',         'DL_NC');
  EXPORT NV          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_NV',         'In_NV',         'DL_NV');
  EXPORT OH          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_OH',         'In_OH',         'DL_OH');
  EXPORT TN          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_TN',         'In_TN',         'DL_TN');
  EXPORT TX          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_TX',         'In_TX',         'DL_TX');
  EXPORT WI          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_WI',         'In_WI',         'DL_WI');
  EXPORT WY_MEDCERT  := Temp_NoReport();

  // EXPORT LA          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_LA',         'In_LA',         'DL_LA');  
  // EXPORT MO          := MAC_Scrubs_Report(pversion, 'Scrubs_DL_MO',         'In_MO',         'DL_MO');
  // EXPORT MO_MEDCERT  := MAC_Scrubs_Report(pversion, 'Scrubs_DL_MO_MEDCERT', 'In_MO_MEDCERT', 'DL_MO_MEDCERT');
  // EXPORT WY_MEDCERT  := MAC_Scrubs_Report(pversion, 'Scrubs_DL_WY_MEDCERT', 'In_WY_MEDCERT', 'DL_WY_MEDCERT');

  //***************Convictions**************
  // EXPORT OH_CONV     := MAC_Scrubs_Report(pversion, 'Scrubs_DL_OH_CONV',    'In_OH_CONV',    'DL_OH_CONV');
  // EXPORT MN_CONV     := MAC_Scrubs_Report(pversion, 'Scrubs_DL_MN_CONV',    'In_MN_CONV',    'DL_MN_CONV');
  EXPORT TN_CONV     := MAC_Scrubs_Report(pversion, 'Scrubs_DL_TN_CONV', 'In_TN_CONV', 'DL_TN_CONV');
  EXPORT TN_WDL      := MAC_Scrubs_Report(pversion, 'Scrubs_DL_TN_WDL', 'In_TN_WDL', 'DL_TN_WDL');
  // EXPORT WY_CONV     := MAC_Scrubs_Report(pversion, 'Scrubs_DL_WY_CONV',    'In_WY_CONV',    'DL_WY_CONV');

  // EXPORT All := PARALLEL(CT, FL, LA, MA, ME_MEDCERT, MI, MO, //MO_BASIC, MO_ICISSU,
                         // MO_MEDCERT, NE, NC, //NC_CHG, 
                         // OH, TN, TX, WI, WY_MEDCERT
                         // OH_CONV, MN_CONV, TN_CONV, TN_WDL, WY_CONV);

END;