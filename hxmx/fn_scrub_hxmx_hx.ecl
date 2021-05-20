IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, hxmx, Scrubs, Scrubs_HX;


EXPORT fn_scrub_hxmx_hx (dataset(hxmx.layouts.base.hx_record) pBaseFile, string filedate='', boolean pUseProd = false):= function

		
		//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(pBaseFile,
																		TRANSFORM(Scrubs_HX.HX_Layout_HX,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsHXMX							:=	Scrubs_HX.HX_Scrubs;									//	Scrubs Module for HXMX Layout
		//Apply Scrubs
		dHXMXScrubbedRecords		:=	scrubsHXMX.FromNone(recordsToScrub);		//	Generate the HXMX error flags
		dHXMXExpandedRecords		:=	scrubsHXMX.FromExpanded(dHXMXScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dHXMXExpandedRecords.SummaryStats, NAMED('HX_' + 'ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dHXMXExpandedRecords.AllErrors, 1000), NAMED('HX_' + 'EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dHXMXExpandedRecords.BadValues, 1000), NAMED('HX_' + 'SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dHXMXExpandedRecords.OrbitStats()
																		:persist(HXMX.Filenames(filedate,pUseProd).hx_lPersistTemplate + '::scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Symphony_HX',,orbitStats,filedate,'HXMX').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Symphony_HX',,orbitStats,filedate,'HXMX').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(	HXMX.Email_Notification_Lists.quality_assurance
																															,'Scrubs HX Claims Report' //subject
																															,'Scrubs HX Claims Report WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'HXScrubsReport.csv'
																															,
																															,
																															,'jason.allerdings@lexisnexisrisk.com');	
																														
		//****************************************************************************************************

		// dHXMXPostScrubbedRecords	:=	PROJECT(dHXMXScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(new_base_d),SELF:=LEFT))
			// :persist(HXMX.Filenames(pVersion,pUseProd).hx_lPersistTemplate + '::post');
			
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
									//IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Symphony HX Scrubs Alerts')) 
								);
		runScrub;
				

		return true;

END;