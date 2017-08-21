IMPORT HMS_SureScripts, Scrubs, Scrubs_SureScripts, _Control;

EXPORT Scrub_Code (string filedate, boolean pUseProd = false) := MODULE
		EXPORT Scrub_Code(Dataset(hms_surescripts.Layouts.base) pBaseFile, string version) := FUNCTION
			recordsToScrub						:=	PROJECT(pBaseFile, TRANSFORM(HMS_SureScripts.Layouts.base,SELF:=LEFT));

			scrubsSureScripts					:=	Scrubs_SureScripts.SureScripts_Scrubs;									//	Scrubs Module for SureScripts Layout

			dSureScriptsScrubbedRecords		:=	scrubsSureScripts.FromNone(recordsToScrub);		//	Generate the SureScripts error flags
			dSureScriptsExpandedRecords		:=	scrubsSureScripts.FromExpanded(dSureScriptsScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dSureScriptsExpandedRecords.SummaryStats, NAMED('ErrorSummary'),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dSureScriptsExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dSureScriptsExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
			Orbitstats					:=	dSureScriptsExpandedRecords.OrbitStats():persist('~persist::HMS_SureScripts_scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Surescripts','Scrubs',Orbitstats,version,'SureScripts').SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Surescripts','Scrubs',Orbitstats,version,'Surescripts').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			mailfile									:=	FileServices.SendEmailAttachData(hms_surescripts.email_notification_lists.BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,'Scrubs Surescripts Report Test' //subject
																																,'Scrubs Surescripts Report Test WU: '+WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'SurescriptsScrubsReport.csv'
																																,
																																,
																																,_Control.MyInfo.EmailAddressNotify);	
		//****************************************************************************************************
			SEQUENTIAL(
				ErrorSummary,
				EyeballSomeErrors,
				SomeErrorValues,
				SubmitStats
			);

			Return true;
		END; //FUNCTION	
		ToScrub_File := HMS_SureScripts.StandardizeInputFile(filedate,pUseProd).base;
		EXPORT Scrubbed_Output := Scrub_Code(ToScrub_File, filedate);
END; // Module		
