IMPORT hms_Medicaid_NY, Scrubs,HMS_Medicaid_Common, Scrubs_Medicaid_NY, _Control;


EXPORT Scrub_Code (string filedate, boolean pUseProd = false) := MODULE
		EXPORT Scrub_Code(Dataset(HMS_Medicaid_Common.Layouts.base_NY) pBaseFile, string version) := FUNCTION
			recordsToScrub_NY					:=	PROJECT(pBaseFile, TRANSFORM(HMS_Medicaid_Common.Layouts.base_NY,SELF:=LEFT));

			scrubsMedicaid_NY					:=	Scrubs_Medicaid_NY.Scrubs;									//	Scrubs Module for Medicaid_NY Layout

			dScrubbedRecords					:=	scrubsMedicaid_NY.FromNone(recordsToScrub_NY);		//	Generate the SureScripts error flags
			dExpandedRecords					:=	scrubsMedicaid_NY.FromExpanded(dScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dExpandedRecords.SummaryStats, NAMED('ErrorSummary'),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
			Orbitstats								:=	dExpandedRecords.OrbitStats():persist('~persist::HMS_Medicaid_NY_scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Medicaid_NY',,Orbitstats,version,'Medicaid_NY').SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Medicaid_NY',,Orbitstats,version,'Medicaid_NY').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			mailfile									:=	FileServices.SendEmailAttachData(HMS_Medicaid_Common.Email_Notification_Lists('NY',version).BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,'Scrubs Medicaid_NY Report Test' //subject
																																,'Scrubs Medicaid_NY Report Test WU: '+WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'Medicaid_NYScrubsReport.csv'
																																,
																																,
																																,_Control.MyInfo.EmailAddressNotify);	
		//****************************************************************************************************
			SEQUENTIAL(
				ErrorSummary,
				EyeballSomeErrors,
				SomeErrorValues,
				SubmitStats
				//mailfile
			);

			Return true;
		END; //FUNCTION	
		ToScrub_File := HMS_Medicaid_NY.StandardizeInputFile(filedate,pUseProd).base;
		EXPORT Scrubbed_Output := Scrub_Code(ToScrub_File, filedate);
END; // Module		
