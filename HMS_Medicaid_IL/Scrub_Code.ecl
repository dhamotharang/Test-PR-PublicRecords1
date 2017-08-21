IMPORT hms_Medicaid_VT,HMS_Medicaid_IL, Scrubs, Scrubs_Medicaid_IL,HMS_Medicaid_Common, _Control;

EXPORT Scrub_Code (string filedate, boolean pUseProd = false) := MODULE
		EXPORT Scrub_Code(Dataset(HMS_Medicaid_Common.Layouts.base_IL) pBaseFile, string version) := FUNCTION
			recordsToScrub_IL						:=	PROJECT(pBaseFile, TRANSFORM(HMS_Medicaid_Common.Layouts.base_IL,SELF:=LEFT));

			scrubsMedicaid_IL					:=	Scrubs_Medicaid_IL.Scrubs;									//	Scrubs Module for Medicaid_IL Layout

			dScrubbedRecords		:=	scrubsMedicaid_IL.FromNone(recordsToScrub_IL);		//	Generate the SureScripts error flags
			dExpandedRecords		:=	scrubsMedicaid_IL.FromExpanded(dScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dExpandedRecords.SummaryStats, NAMED('ErrorSummary'),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
			Orbitstats					:=	dExpandedRecords.OrbitStats():persist('~persist::HMS_Medicaid_IL_scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Medicaid_IL',,Orbitstats,version,'Medicaid_IL').SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Medicaid_IL',,Orbitstats,version,'Medicaid_IL').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			mailfile									:=	FileServices.SendEmailAttachData(HMS_Medicaid_Common.Email_Notification_Lists('IL',version).BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,'Scrubs Medicaid_IL Report Test' //subject
																																,'Scrubs Medicaid_IL Report Test WU: '+WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'Medicaid_ILScrubsReport.csv'
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
		ToScrub_File := HMS_Medicaid_IL.StandardizeInputFile(filedate,pUseProd).base;
		EXPORT Scrubbed_Output := Scrub_Code(ToScrub_File, filedate);
END; // Module		
