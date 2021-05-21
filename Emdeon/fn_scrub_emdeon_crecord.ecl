IMPORT Address, Ut, lib_STRINGlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, emdeon, Scrubs, Scrubs_Emdeon_CRecord;

EXPORT fn_scrub_emdeon_crecord (dataset(emdeon.Layouts.base.c_record) pBaseFile, string filedate='',boolean pUseProd = false):= function
 			//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(pBaseFile,
																		TRANSFORM(Scrubs_Emdeon_CRecord.CRecord_Layout_CRecord,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsEmdeon							:=	Scrubs_Emdeon_CRecord.CRecord_Scrubs;									//	Scrubs Module for Emdeon Layout
		//Apply Scrubs
		dEmdeonScrubbedRecords		:=	scrubsEmdeon.FromNone(recordsToScrub);		//	Generate the Emdeon error flags
		dEmdeonExpandedRecords		:=	scrubsEmdeon.FromExpanded(dEmdeonScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dEmdeonExpandedRecords.SummaryStats, NAMED('CRec_' + 'ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.AllErrors, 1000), NAMED('CRec_' + 'EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.BadValues, 1000), NAMED('CRec_' + 'SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dEmdeonExpandedRecords.OrbitStats()
																		:persist(Emdeon.Filenames(filedate,pUseProd).claims_lPersistTemplate + '::scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_CRecord',,orbitStats,filedate,'Emdeon').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_CRecord',,orbitStats,filedate,'Emdeon').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(Emdeon.Email_Notification_Lists.quality_assurance
																															,'Scrubs Emdeon Claims Report Test' //subject
																															,'Scrubs Emdeon Claims Report Test WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'EmdeonScrubsReport.csv'
																															,
																															,
																															,'jason.allerdings@lexisnexisrisk.com');	
																														
		//****************************************************************************************************

		// dEmdeonPostScrubbedRecords	:=	PROJECT(dEmdeonScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(dEmdeonScrubbedRecords),SELF:=LEFT))
			// :persist(Emdeon.Filenames(filedate,pUseProd).claims_lPersistTemplate + '::post');
			
		runScrub :=	SEQUENTIAL(
									ErrorSummary,
									EyeballSomeErrors,
									SomeErrorValues,
									// OrbitReport,
									// OrbitReportSummary,
									// CreateBitmaps,
									// TranslateBitmap,
									// GenerateCSVTemplate,
									// GenerateAlertsCSVTemplate,
									SubmitStats
									//IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Emdeon CRecord Scrubs Alerts')) //mailfile
								);
		runScrub;
				
		return true;

END;