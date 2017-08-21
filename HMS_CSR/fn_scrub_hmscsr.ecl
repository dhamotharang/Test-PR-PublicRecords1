IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,HMS_CSR,Scrubs_HMS_CSR,Scrubs;

EXPORT fn_scrub_hmscsr (dataset(HMS_CSR.layouts.csrcredential_base) pBaseFile, string filedate=''):= function
 				//********************************Apply Scrubs before building the base file***************************
      											   
      										recordsToScrub						:=	PROJECT(pBaseFile,
      																											TRANSFORM(Scrubs_HMS_CSR.HmsCsr_Layout_HmsCsr,
      																										SELF:=LEFT));											//	Remove Scrub Bits
      																												
      										ScrubsHmsCsr							:=	Scrubs_HMS_CSR.HmsCsr_Scrubs;									//	Scrubs Module for HmsCsr Layout
      										//Apply Scrubs
      										dHmsCsrScrubbedRecords		:=	ScrubsHmsCsr.FromNone(recordsToScrub);		//	Generate the HmsCsr error flags
      										dHmsCsrExpandedRecords		:=	ScrubsHmsCsr.FromExpanded(dHmsCsrScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
      										//Generate Some Debug Results
      										ErrorSummary							:=	OUTPUT(dHmsCsrExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
      										EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dHmsCsrExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
      										SomeErrorValues						:=	OUTPUT(CHOOSEN(dHmsCsrExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
      										//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
      										orbitStats								:=	dHmsCsrExpandedRecords.OrbitStats():persist('~persist::HmsCsr_scrubs_rpt');	//	Get our stats
   												
   												// OrbitReport					:=	OUTPUT(orbitStats,ALL,NAMED('OrbitReport'));
   												// OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,orbitStats).SummaryStats,ALL,NAMED('OrbitReportSummary'));
      											
   												//Generate CSV Templates
   												GenerateCSVTemplate				:=	Scrubs.OrbitProfileStats('Scrubs_HMS_CSR',,orbitStats,filedate,'HMS_CSR').ProfileTemplate;
   												GenerateAlertsCSVTemplate	:=	Scrubs.OrbitProfileStats('Scrubs_HMS_CSR',,orbitStats,filedate,'HMS_CSR','20').ProfileAlertsTemplate;
   											
   												//Submits stats to Orbit
      										submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_HMS_CSR',,orbitStats,filedate,'HMS_CSR').SubmitStats;
      										//Output Scrubs report with examples in WU
      										dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_HMS_CSR',,orbitStats,filedate,'HMS_CSR').CompareToProfile_with_examples;
      										//Send Alerts and Scrubs reports via email 
      										scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
      										scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
      										mailfile									:=	FileServices.SendEmailAttachData(HMS_CSR.email_notification_lists.BuildSuccess
      																																								,'Scrubs HmsCsr Report' //subject
      																																								,'Scrubs HmsCsr Report WU: '+WORKUNIT //body
      																																								,(data)scrubsAttachment
      																																								,'text/csv'
      																																								,'HmsCsrScrubsReport.csv'
      																																								,
      																																								,
      																																								,_Control.MyInfo.EmailAddressNotify);
      																																							
      						
      						//****************************************************************************************************
   												
      								//dHmsCsrPostScrubbedRecords	:=	PROJECT(dHmsCsrScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(names_flipped),SELF:=LEFT)):persist('~persist::dHmsCsrScrubbed');
   										runScrub :=		SEQUENTIAL(
      																	ErrorSummary,
      																	EyeballSomeErrors,
      																	SomeErrorValues,
      																	// OrbitReport,
      																	// OrbitReportSummary,
      																	// CreateBitmaps,
      																	// TranslateBitmap,
      																	GenerateCSVTemplate,
      																	GenerateAlertsCSVTemplate,
      																	SubmitStats
      																//	IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No HMS_CSR Scrubs Alerts'))
      																);
      										runScrub;
   
      						//****************************************************************************************************
									return true;

END;