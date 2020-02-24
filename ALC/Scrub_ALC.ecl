// The macro was copied from Scrubs_Vina.Proc_Scrubs_Report and adjusted
IMPORT _Control, ALC, Scrubs, Scrubs_ALC_ACCOUNTANTS, Scrubs_ALC_DENTAL_PROFESSIONALS,
       Scrubs_ALC_INSURANCE_AGENTS, Scrubs_ALC_LAWYERS, Scrubs_ALC_NURSES, Scrubs_ALC_PHARMACISTS,
			 Scrubs_ALC_PILOTS, Scrubs_ALC_PROFESSIONALS;

EXPORT Scrub_ALC(STRING pversion) := MODULE

	MAC_Scrubs_Report(BuildDate,myFolder,myFile,datasetName)	:=	FUNCTIONMACRO
		folder						:=	#EXPAND(myFolder);
		inFile						:=	folder.#EXPAND(myFile);
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
		scrubsAlert						:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment			:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile							:=	FileServices.SendEmailAttachData(ALC.Email_Notification_Lists.BuildFailure
																															 ,datasetName+' Report' //subject
																															 ,datasetName+' Report WU: '+WORKUNIT //body
																															 ,(data)scrubsAttachment
																															 ,'text/csv'
																															 ,datasetName+'ScrubsReport.csv'
																															 ,
																															 ,
																															 ,myEmail);

// All custom errors for this product have the value of 2, but only a few have the custom check.




	
critical_bad_records := 
#IF(datasetName IN['ALC_ACCOUNTANTS', 'ALC_NURSES'])
	#IF(datasetName = 'ALC_ACCOUNTANTS')
		 N.ExpandedInFile(license_no_invalid = 2)
	#END
	#IF(datasetName = 'ALC_NURSES')
	   IF(Scrubs_ALC_nurses.MOD_custom_err.fn_get_tx_err_pct >= 2, N.ExpandedInFile(license_no_invalid = 2), DATASET([], RECORDOF(N.ExpandedInFile)))
	#END	
	#ELSE  DATASET([], RECORDOF(N.ExpandedInFile))
#END;


    // For professionals, the custom error detection is only the first step.  The vendor says that a short
		//   license number is not, in itself, an error, but if the license number is not unique on top of it...
		//   then that's a problem.
    potential_professional_bad_records := #IF(datasetName = 'ALC_PROFESSIONALS')
                                            N.ExpandedInFile(license_no_invalid = 2)
														              #ELSE
			                                      DATASET([], RECORDOF(N.ExpandedInFile))
														              #END;



    #IF(datasetName = 'ALC_PROFESSIONALS')
			custom_rec := RECORD
				the_count := COUNT(GROUP);
				potential_professional_bad_records.license_no;
			END;

			professional_errors_table := TABLE(potential_professional_bad_records, custom_rec, license_no);
			professional_critical_bad_records := professional_errors_table(the_count > 1);
		#ELSE
		  professional_critical_bad_records := DATASET([], RECORDOF(N.ExpandedInFile));
		#END
		
		RETURN SEQUENTIAL(ErrorSummary,
											EyeballSomeErrors,
											SomeErrorValues,
											OrbitReport,
											OrbitReportSummary,
											SubmitStats,
											IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No ' + datasetName + ' Scrubs Alerts')),

										IF(COUNT(critical_bad_records) > 0 OR COUNT(professional_critical_bad_records) > 0,
											   SEQUENTIAL(#IF(datasetName != 'ALC_PROFESSIONALS')
												              OUTPUT(critical_bad_records, , '~thor_data400::error::' + pversion + '::' + datasetName, COMPRESSED, OVERWRITE);
																		#ELSE
												              OUTPUT(professional_critical_bad_records, , '~thor_data400::error::' + pversion + '::' + datasetName, COMPRESSED, OVERWRITE);
																		#END
												            FAIL('Custom Scrubs error occurred.  Getting bad license ' +
																		        'numbers with ' + datasetName + '.  Check file ' +
																						'thor_data400::error::' + pversion + '::' + datasetName)),
												 OUTPUT('No ' + datasetName + ' custom error occurred.')));
	ENDMACRO;

  EXPORT All :=
	  SEQUENTIAL(
							MAC_Scrubs_Report(pversion, 'Scrubs_ALC_ACCOUNTANTS', 'In_ALC_ACCOUNTANTS','ALC_ACCOUNTANTS'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_DENTAL_PROFESSIONALS', 'In_ALC_DENTAL_PROFESSIONALS','ALC_DENTAL_PROFESSIONALS'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_INSURANCE_AGENTS', 'In_ALC_INSURANCE_AGENTS','ALC_INSURANCE_AGENTS'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_LAWYERS', 'In_ALC_LAWYERS', 'ALC_LAWYERS'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_NURSES', 'In_ALC_NURSES', 'ALC_NURSES'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_PHARMACISTS', 'In_ALC_PHARMACISTS','ALC_PHARMACISTS'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_PILOTS', 'In_ALC_PILOTS', 'ALC_PILOTS'),
							 MAC_Scrubs_Report(pversion, 'Scrubs_ALC_PROFESSIONALS', 'In_ALC_PROFESSIONALS', 'ALC_PROFESSIONALS')
							);

END;
