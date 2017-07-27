IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,HMS_STLIC,Scrubs_HMS_STLIC,Scrubs;

EXPORT fn_scrub_hmsstlic (dataset(HMS_STLIC.layouts.statelicense_base) pBaseFile, string filedate=''):= function
 				//********************************Apply Scrubs before building the base file***************************
      											   
      										recordsToScrub						:=	PROJECT(pBaseFile,
      																											TRANSFORM(Scrubs_HMS_STLIC.HmsStlic_Layout_HmsStlic,
      																										SELF:=LEFT));											//	Remove Scrub Bits
      																												
      										ScrubsHmsStlic							:=	Scrubs_HMS_STLIC.HmsStlic_Scrubs;									//	Scrubs Module for HmsStlic Layout
      										//Apply Scrubs
      										dHmsStlicScrubbedRecords		:=	ScrubsHmsStlic.FromNone(recordsToScrub);		//	Generate the HmsStlic error flags
      										dHmsStlicExpandedRecords		:=	ScrubsHmsStlic.FromExpanded(dHmsStlicScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
      										//Generate Some Debug Results
      										ErrorSummary							:=	OUTPUT(dHmsStlicExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
      										EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dHmsStlicExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
      										SomeErrorValues						:=	OUTPUT(CHOOSEN(dHmsStlicExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
      										//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
      										orbitStats								:=	dHmsStlicExpandedRecords.OrbitStats():persist('~persist::HmsStlic_scrubs_rpt');	//	Get our stats
   												
   												// OrbitReport					:=	OUTPUT(orbitStats,ALL,NAMED('OrbitReport'));
   												// OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,orbitStats).SummaryStats,ALL,NAMED('OrbitReportSummary'));
      											
   												//Generate CSV Templates
   												// GenerateCSVTemplate				:=	Scrubs.OrbitProfileStats('Scrubs_HMS_STLIC',,orbitStats,filedate,'HMS_STLIC').ProfileTemplate;
   												// GenerateAlertsCSVTemplate	:=	Scrubs.OrbitProfileStats('Scrubs_HMS_STLIC',,orbitStats,filedate,'HMS_STLIC','20').ProfileAlertsTemplate;
   											
   												//Submits stats to Orbit
      										submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_HMS_STLIC',,orbitStats,filedate,'HMS_STLIC').SubmitStats;
      										//Output Scrubs report with examples in WU
      										dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_HMS_STLIC',,orbitStats,filedate,'HMS_STLIC').CompareToProfile_with_examples;
      										//Send Alerts and Scrubs reports via email 
      										scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
      										scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
      										mailfile									:=	FileServices.SendEmailAttachData(HMS_STLIC.email_notification_lists.BuildSuccess
      																																								,'Scrubs HmsStlic Report' //subject
      																																								,'Scrubs HmsStlic Report WU: '+WORKUNIT //body
      																																								,(data)scrubsAttachment
      																																								,'text/csv'
      																																								,'HmsStlicScrubsReport.csv'
      																																								,
      																																								,
      																																								,_Control.MyInfo.EmailAddressNotify);
      																																							
      						
      						//****************************************************************************************************
   												
      								//dHmsStlicPostScrubbedRecords	:=	PROJECT(dHmsStlicScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(names_flipped),SELF:=LEFT)):persist('~persist::dHmsStlicScrubbed');
   										runScrub :=		SEQUENTIAL(
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
      																	//IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No HMS_STLIC Scrubs Alerts')) //mailfile
      																);
      										runScrub;
   
      						//****************************************************************************************************
									return true;

END;